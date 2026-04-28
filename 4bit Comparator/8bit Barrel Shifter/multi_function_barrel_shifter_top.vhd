
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multi_function_barrel_shifter_top is
    Port ( ext_a : in  STD_LOGIC_VECTOR (7 downto 0);
           ext_amt : in  STD_LOGIC_VECTOR (2 downto 0);
           ext_y : out  STD_LOGIC_VECTOR (7 downto 0);
           ext_func : in  STD_LOGIC);
end multi_function_barrel_shifter_top;

architecture Structural of multi_function_barrel_shifter_top is
	
	signal int_a : STD_LOGIC_VECTOR (7 downto 0);
	signal int_amt : STD_LOGIC_VECTOR (2 downto 0);
	signal int_yr : STD_LOGIC_VECTOR (7 downto 0);
	signal int_yl : STD_LOGIC_VECTOR (7 downto 0);
	signal final_y : STD_LOGIC_VECTOR (7 downto 0);
	signal int_func : STD_LOGIC;
	
begin
	--INVERT ALL INPUTS
	int_a <= NOT ext_a;
	int_amt <= NOT ext_amt;
	int_func <= NOT ext_func;
	
	--Instantiation
	bar_shift_right: entity work.barrel_shifter_8bit_right
		port map(a=>int_a, amt=>int_amt, y=>int_yr);
	
	bar_shift_left: entity work.barrel_shifter_8bit_left
		port map(a=>int_a, amt=>int_amt, y=>int_yl);
	
	--Multiplexer 2 to 1 for choosing left or right rotation
	with int_func select
	final_y <= int_yr when '0', -- Right rotation
				  int_yl when others; -- Left rotation
	--INVERT THE OUTPUT
	ext_y <= final_y;

end Structural;

