--Top Level Entity for Active Low Logic I/O

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logicGateSelector_top is
    Port( 
			extA : 	in  STD_LOGIC;
         extB : 	in  STD_LOGIC;
         extY : 	out  STD_LOGIC;
         extSel : in  STD_LOGIC_VECTOR (2 downto 0));
end logicGateSelector_top;

architecture Structural of logicGateSelector_top is

	signal int_A, int_B, int_Y : STD_LOGIC;
	signal int_Sel : STD_LOGIC_VECTOR (2 downto 0);
	
begin
	--INVERT ALL INPUTS
	int_A <= NOT extA;
	int_B <= NOT extB;
	int_Sel <= NOT extSel;

	--Instantiation
	lgs1: entity work.logicGateSelector port map(
		A => int_A,
		B => int_B,
		Sel => int_Sel,
		Y => int_Y
	);
	
	--INVERT THE OUTPUT
	extY <= NOT int_Y;
end Structural;

