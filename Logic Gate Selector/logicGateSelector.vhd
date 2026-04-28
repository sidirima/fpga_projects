--LOGIC GATE SELECTOR FOR 2 INPUTS 1-bit

--Code for Active-Low Inputs and Outputs
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logicGateSelector is
    Port ( A : in  STD_LOGIC;
           B : in  STD_LOGIC;
           Y : out  STD_LOGIC;
           Sel : in  STD_LOGIC_VECTOR (2 downto 0));
end logicGateSelector;

architecture Behavioral of logicGateSelector is

begin
	process(A,B,Sel)
	begin
		case Sel is
		when "000" => -- Buffer for A
			Y <= A;
		
		when "001" => -- NOT for A
			Y <= NOT A;
		
		when "010" => -- AND
			Y <= A AND B;
			
		when "011" => -- NAND
			Y <= A NAND B;
			
		when "100" => -- OR
			Y <= A OR B;
		
		when "101" => -- NOR
			Y <= A NOR B;
		
		when "110" => -- XOR
			Y <= A XOR B;
		
		when "111" => -- XNOR
			Y <= A XNOR B;
			
		when others => --Failsafe
			Y <= '0'; --On error, deactivate Output
		end case;
		
	end process;

end Behavioral;

