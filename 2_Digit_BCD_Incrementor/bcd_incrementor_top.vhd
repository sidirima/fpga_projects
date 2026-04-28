--Top Level Module for 8 bit BCD Incrementor
--Active Low Inputs, Active High Output and Common Anode 7 Segment Display
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bcd_incrementor_top is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           sseg0 : out  STD_LOGIC_VECTOR (6 downto 0);
           sseg1 : out  STD_LOGIC_VECTOR (6 downto 0);
           ovf : out  STD_LOGIC);
end bcd_incrementor_top;

architecture Structural of bcd_incrementor_top is
	
	signal int_a : STD_LOGIC_VECTOR (7 downto 0);
	signal bcd_1, bcd_0 : STD_LOGIC_VECTOR (3 downto 0);
	signal en_0 : STD_LOGIC;
	signal carry_0 : STD_LOGIC;
	
begin
	--INVERT INPUT
	int_a <= NOT a;
	
	en_0 <= '1'; -- First enable signal
	
	--Instantiation 
	bcd_inc0: entity work.bcd_incrementor
		port map(bcd_in => int_a(3 downto 0),
					bcd_out => bcd_0, 
					en => en_0,
					carry => carry_0);
	
	bcd_inc1: entity work.bcd_incrementor
		port map(bcd_in => int_a(7 downto 4),
					bcd_out => bcd_1,
					en => carry_0,
					carry => ovf);
	
	--Output to 7 segment display
	sseg_0: entity work.hex_to_7_segment
		port map(hex => bcd_0, sseg => sseg0);
	
	sseg_1: entity work.hex_to_7_segment
		port map(hex => bcd_1, sseg => sseg1);
	
end Structural;

