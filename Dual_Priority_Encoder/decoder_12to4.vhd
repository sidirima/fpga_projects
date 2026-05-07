
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder_12to4 is
    Port ( first : in  STD_LOGIC_VECTOR (3 downto 0);
           first_dec : out  STD_LOGIC_VECTOR (11 downto 0));
end decoder_12to4;

architecture Behavioral of decoder_12to4 is

begin
	with first select
		first_dec <= "100000000000" when "1100", --12th position
						 "010000000000" when "1011", --11th position
						 "001000000000" when "1010", --10th position
						 "000100000000" when "1001", --9th position
						 "000010000000" when "1000", --8th position
						 "000001000000" when "0111", --7th position
						 "000000100000" when "0110", --6th position
						 "000000010000" when "0101", --5th position
						 "000000001000" when "0100", --4th position
						 "000000000100" when "0011", --3rd position
						 "000000000010" when "0010", --2nd position
						 "000000000001" when "0001", --1st position
						 "000000000000" when others; --No '1' 

end Behavioral;

