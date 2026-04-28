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
			"0000001" when "0000", -- BCD 0
			"1001111" when "0001", -- BCD 1
			"0010010" when "0010", -- BCD 2
			"0000110" when "0011", -- BCD 3
			"1001100" when "0100", -- BCD 4
			"0100100" when "0101", -- BCD 5
			"0100000" when "0110", -- BCD 6
			"0001111" when "0111", -- BCD 7
			"0000000" when "1000", -- BCD 8
			"0000100" when "1001", -- BCD 9
			"1111111" when others; -- Failsafe

end Behavioral;

