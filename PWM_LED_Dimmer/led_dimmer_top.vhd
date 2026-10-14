--Top Level Module for 7 Segment LED Dimmer with PWM signal
--Active Low Inputs (debounced) and Common Anode 7 Segment Display
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity led_dimmer_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           sw : in  STD_LOGIC;
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (7 downto 0));
end led_dimmer_top;

architecture Structural of led_dimmer_top is
	
	signal int_reset, int_sw : STD_LOGIC;
	signal int_sseg0 : STD_LOGIC_VECTOR (7 downto 0); -- Raw data segment
	signal int_sseg1 : STD_LOGIC_VECTOR (7 downto 0); -- Dimmed segment
	signal w_count : STD_LOGIC_VECTOR (3 downto 0); -- counter for duty cycle
	signal holder : STD_LOGIC;

begin
	--INVERT ALL INPUTS
	int_reset <= NOT reset;
	int_sw <= NOT sw;
	
	count_proc: process(clk, int_reset, int_sw)
	begin
		if (int_reset = '1') then
			w_count <= (others => '0');
			holder <= '0';
		else
			if (int_sw = '1') then
				if (holder = '0') then
					w_count <=  w_count + 1;
					holder <= '1';
				else
					holder <= '0';
				end if;
			end if;
		end if;
	end process;

	--Instantiation of 7 Segment Multiplexer
	disp_unit : entity work.disp_hex_mux
		port map(clk => clk, reset => int_reset, 
					hex3 => (others=> '0'), hex2 => (others=> '0'),
					hex1 => (others=> '0'), hex0 => w_count,
					dp_in => (others=> '1'), an => an, sseg => int_sseg0);
		
	--Instantiation of LED Dimmer (8 circuits for each individual segment)
	dimmer_generation: FOR i IN 0 TO 7 GENERATE

		led_dim : entity work.led_dimmer
			port map(clk => clk, reset => int_reset, en => (NOT int_sseg0(i)), 
						w => w_count, pwm => int_sseg1(i));
	
		--Output
		sseg(i) <= NOT int_sseg1(i);
	end generate dimmer_generation;
end Structural;

