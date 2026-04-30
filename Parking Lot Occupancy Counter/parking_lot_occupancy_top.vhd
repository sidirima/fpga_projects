--Top Level Module for Parking Lot Occupancy Test
--Active Low I/O and Debounced Pushbuttons Used
--Common Anode NON MUXed 7 Segment Displays

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parking_lot_occupancy_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
		   max_cap : in STD_LOGIC_VECTOR (7 downto 0); -- Max Capacity Input
           sseg0 : out  STD_LOGIC_VECTOR (6 downto 0);
           sseg1 : out  STD_LOGIC_VECTOR (6 downto 0);
		   ovf : out STD_LOGIC_VECTOR (1 downto 0);
		   full : out STD_LOGIC;
		   vacant : out STD_LOGIC);
end parking_lot_occupancy_top;

architecture Structural of parking_lot_occupancy_top is
	signal cnt_reg, cnt_next : unsigned (7 downto 0); -- Counter registers
	signal int_reset, int_a, int_b : STD_LOGIC; -- Input Inversion
	signal int_maxcap : STD_LOGIC_VECTOR(7 downto 0); -- Input Inversion
	signal enter_car, exit_car : STD_LOGIC; -- Internal signals
	signal bcd0, bcd1 : STD_LOGIC_VECTOR (3 downto 0); -- Hex to 7 Segment Output
	signal int_ovf : STD_LOGIC_VECTOR (1 downto 0);
	signal start_conv : STD_LOGIC; -- start signa l for dd
	signal cnt_prev : unsigned (7 downto 0); -- previous counter 
	
	
begin
	--INPUT INVERSION
	int_reset <= NOT reset;
	int_a <= NOT a;
	int_b <= NOT b;
	int_maxcap <= NOT max_cap;
	
	--Instantiation of Parking Lot Occupancy
	park_lot_occ : entity work.parking_lot_fsm
		port map (clk => clk, reset => int_reset, a => int_a, 
					 b => int_b, enter_car => enter_car, exit_car => exit_car);
	
	--Instantiation of 7 Segment (NON MUX)
	disp0 : entity work.hex_to_7_segment
		port map (hex => bcd0, sseg => sseg0);
	
	disp1 : entity work.hex_to_7_segment
		port map (hex => bcd1, sseg => sseg1);
	
	--Double Dabble signal change detector to enable / disable start 
	process(clk)
	begin
		if rising_edge(clk) then
			cnt_prev <= cnt_reg;
			if (cnt_reg /= cnt_prev) then
				start_conv <= '1';
			else
				start_conv <= '0';
			end if;
		end if;
	end process;
	--Instantiation of Binary-to-BCD Conversion (Double Dabble Algorithm)
	bcd_conv: entity work.bin2bcd_dd
		port map (clk => clk, reset => int_reset, start => start_conv,
					 bin => STD_LOGIC_VECTOR(cnt_reg), ready => open,
					 done_tick => open, bcd1 => bcd1, bcd0 => bcd0, ovf => int_ovf);
					 
	--COUNTER REGISTER
	count_proc: process (clk)
	begin
		if rising_edge(clk) then
			cnt_reg <= cnt_next;
		end if;
	end process;

	--Next State Logic
	cnt_next <= (others => '0') when int_reset = '1' else
				   cnt_reg + 1 when (enter_car = '1' AND cnt_reg < unsigned(int_maxcap)) else -- Increase till max
					cnt_reg - 1 when (exit_car = '1' AND cnt_reg > 0) else -- Decrease till 0
					cnt_reg;

	--Output Logic
	full <= '1' when cnt_reg >= unsigned(int_maxcap) else '0'; -- Full flag
	vacant <= '1' when cnt_reg < unsigned(int_maxcap) else '0'; -- Space available
	
	ovf <= "11" when int_ovf = "00" else
		   "10" when int_ovf = "01" else
		   "00" when int_ovf = "10" else
		   "01";

end Structural;

