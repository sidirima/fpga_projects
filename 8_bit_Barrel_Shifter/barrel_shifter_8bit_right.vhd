-- Barrel Shifter for Logic Right Rotation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity barrel_shifter_8bit_right is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           amt : in  STD_LOGIC_VECTOR (2 downto 0);
           y : out  STD_LOGIC_VECTOR (7 downto 0));
end barrel_shifter_8bit_right;

architecture Behavioral of barrel_shifter_8bit_right is
	
	--Temporary signals for each stage
	signal s0,s1: STD_LOGIC_VECTOR (7 downto 0);
	
begin
		--Stage 0: shift 0 or 1 bit
		s0 <= a(0) & a(7 downto 1) when amt(0)='1'
		else a;
		--Stage 1: shift 0 or 2 bit
		s1 <= s0(1 downto 0) & s0(7 downto 2) when amt(1)='1'
		else s0;
		--Stage 2: shift 0 or 4 bit
		y <= s1(3 downto 0) & s0(7 downto 4) when amt(2)='1'
		else s1;

end Behavioral;

