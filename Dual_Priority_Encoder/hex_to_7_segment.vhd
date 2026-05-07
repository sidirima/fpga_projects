
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hex_to_7_segment is
    Port ( hex : in  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (6 downto 0));
end hex_to_7_segment;

architecture Behavioral of hex_to_7_segment is

begin
	with hex select
		sseg(6 downto 0) <=
		 --"abcdefg"
			"0000001" when "0000", -- HEX 0
			"1001111" when "0001", -- HEX 1
			"0010010" when "0010", -- HEX 2
			"0000110" when "0011", -- HEX 3
			"1001100" when "0100", -- HEX 4
			"0100100" when "0101", -- HEX 5
			"0100000" when "0110", -- HEX 6
			"0001111" when "0111", -- HEX 7
			"0000000" when "1000", -- HEX 8
			"0000100" when "1001", -- HEX 9
			"0001000" when "1010", -- HEX A
			"1100000" when "1011", -- HEX B
			"0110001" when "1100", -- HEX C
			"1000010" when "1101", -- HEX D
			"0110000" when "1110", -- HEX E
			"0111000" when "1111", -- HEX F
			"1111111" when others; -- Failsafe

end Behavioral;

