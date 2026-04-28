-- BCD Incrementor with carry out and enable signal
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_incrementor is
    Port ( bcd_in : in  STD_LOGIC_VECTOR (3 downto 0);
           bcd_out : out  STD_LOGIC_VECTOR (3 downto 0);
           en : in  STD_LOGIC;
           carry : out  STD_LOGIC);
end bcd_incrementor;

architecture Behavioral of bcd_incrementor is

begin
	process(en,bcd_in)
		--Temporary variable for concatenation of en&bcd_in
		variable val : STD_LOGIC_VECTOR (4 downto 0);
	
	begin
		bcd_out <= bcd_in; -- Initialize output
		carry <= '0';
		
		val := en & bcd_in;
		case val is
			when "10000" => bcd_out <="0001"; -- If 0 then 1
			when "10001" => bcd_out <="0010"; -- If 1 then 2
			when "10010" => bcd_out <="0011";
			when "10011" => bcd_out <="0100";
			when "10100" => bcd_out <="0101";
			when "10101" => bcd_out <="0110";
			when "10110" => bcd_out <="0111";
			when "10111" => bcd_out <="1000";
			when "11000" => bcd_out <="1001";
			when "11001" => bcd_out <="0000"; -- If 9 then 0 and add carry
								 carry <= '1';
			when others => null;
		end case;
	end process;
	
end Behavioral;

