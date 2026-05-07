
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity priority_encoder_12to4 is
    Port ( req : in  STD_LOGIC_VECTOR (11 downto 0);
           y : out  STD_LOGIC_VECTOR (3 downto 0));
end priority_encoder_12to4;

architecture Behavioral of priority_encoder_12to4 is

begin
	y <= "1100" when (req(11)= '1') else --1xxxxxxxxxxx
		  "1011" when (req(10)= '1') else --01xxxxxxxxxx
		  "1010" when (req(9) = '1') else --001xxxxxxxxx
		  "1001" when (req(8) = '1') else --0001xxxxxxxx
		  "1000" when (req(7) = '1') else --00001xxxxxxx
		  "0111" when (req(6) = '1') else --000001xxxxxx
		  "0110" when (req(5) = '1') else --0000001xxxxx
		  "0101" when (req(4) = '1') else --00000001xxxx
		  "0100" when (req(3) = '1') else --000000001xxx
		  "0011" when (req(2) = '1') else --0000000001xx
		  "0010" when (req(1) = '1') else --00000000001x
		  "0001" when (req(0) = '1') else --000000000001
		  "0000";								 --000000000000

end Behavioral;

