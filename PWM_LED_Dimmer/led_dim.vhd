
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity led_dimmer is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           en : in  STD_LOGIC;
           w : in  STD_LOGIC_VECTOR (3 downto 0); -- variable duty cycle
           pwm : out  STD_LOGIC);
end led_dimmer;

architecture Behavioral of led_dimmer is
	
	signal cnt_reg, cnt_next : unsigned (3 downto 0);
	signal pwm_reg, pwm_next : STD_LOGIC;
	signal max_tick : STD_LOGIC;
	
begin
	--Register Logic // SYNCHRONOUS
	process(clk,reset)
	begin
		if(reset = '1') then -- Clear Registers
			cnt_reg <= (others => '0'); 
			pwm_reg <= '0';
		elsif rising_edge(clk) then
			if (en = '1') then
				cnt_reg <= cnt_next; -- Set next state when enable
				pwm_reg <= pwm_next;
			end if;
		end if;
	end process;

	--Next State Logic 
	cnt_next <= (others => '0') when cnt_reg = 15 else 
					cnt_reg + 1; -- Increase counter when not max

	max_tick <= '1' when cnt_reg = 15 else '0'; -- Max tick state
	
	pwm_next <= '1' when (max_tick = '1' and w /= "000") else 
					'0' when (max_tick = '1' and w = "000") else 
					'0' when (cnt_next = unsigned(w)) else
					pwm_reg;
	
	--Output Logic
	pwm <= pwm_reg;
	
end Behavioral;

