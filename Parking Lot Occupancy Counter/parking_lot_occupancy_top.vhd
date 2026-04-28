--Top Level Module for Parking Lot Occupancy Test
--Active Low Inputs and Debounced Pushbuttons Used
--Common Anode NON MUXed 7 Segment Displays

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity parking_lot_occupancy_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           sseg0 : out  STD_LOGIC_VECTOR (6 downto 0);
           sseg1 : out  STD_LOGIC_VECTOR (6 downto 0);
			  full : out STD_LOGIC;
			  vacant : out STD_LOGIC);
end parking_lot_occupancy_top;

architecture Structural of parking_lot_occupancy_top is
	constant MAX_DIGIT : integer := 9;
	constant MAX_COUNT : integer := 15;
	signal cnt_reg, cnt_next : unsigned (3 downto 0); -- Counter registers
	signal int_reset, int_a, int_b : STD_LOGIC; -- Input Inversion
	signal enter_car, exit_car : STD_LOGIC; -- Internal signals
	signal hex0, hex1 : STD_LOGIC_VECTOR (3 downto 0); -- Hex to 7 Segment Output
	
begin
	--INPUT INVERSION
	int_reset <= NOT reset;
	int_a <= NOT a;
	int_b <= NOT b;
	
	--Instantiation of Parking Lot Occupancy
	park_lot_occ : entity work.parking_lot_fsm
		port map (clk => clk, reset => int_reset, a => int_a, 
					 b => int_b, enter_car => enter_car, exit_car => exit_car);
	
	--Instantiation of 7 Segment (NON MUX)
	disp0 : entity work.hex_to_7_segment
		port map (hex => hex0, sseg => sseg0);
	
	disp1 : entity work.hex_to_7_segment
		port map (hex => hex1, sseg => sseg1);
	
	--COUNTER REGISTER
	count_proc: process (clk)
	begin
		if rising_edge(clk) then
			cnt_reg <= cnt_next;
		end if;
	end process;

	--Next State Logic
	cnt_next <= (others => '0') when int_reset = '1' else
				   cnt_reg + 1 when (enter_car = '1' AND cnt_reg /= MAX_COUNT) else -- Increase till 15
					cnt_reg - 1 when (exit_car = '1' AND cnt_reg /= 0) else -- Decrease till 0
					cnt_reg;

	--Output Logic
	full <= '1' when cnt_reg = MAX_COUNT else '0'; -- Full flag
	vacant <= '1' when cnt_reg < MAX_COUNT else '0'; -- Space available
	
	process (cnt_reg)
	begin
		if (cnt_reg > MAX_DIGIT) then
			hex0 <= std_logic_vector(cnt_reg - 10);
			hex1 <= "0001";
		else
			hex0 <= std_logic_vector(cnt_reg);
			hex1 <= "0000";
		end if;
	end process;
	

end Structural;

