library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator_4bit is
    Port(
      A : in  STD_LOGIC_VECTOR (3 downto 0);
      B : in  STD_LOGIC_VECTOR (3 downto 0);
      AeqB : out  STD_LOGIC; 	-- A=B output
      AgrB : out  STD_LOGIC; 	-- A>B output
      AsmB : out  STD_LOGIC);	-- A<B output
end comparator_4bit;

architecture Behavioral of comparator_4bit is

	signal eq1,eq0,gr1,gr0,sm1,sm0 : STD_LOGIC;
	
begin
	comp2b1: entity work.comparator_2bit(Behavioral)
		port map (
			A(1) => A(3), 
			A(0) => A(2), 
			B(1) => B(3),
			B(0) => B(2),
			AeqB => eq1,
			AgrB => gr1,
			AsmB => sm1);
	
	comp2b2: entity work.comparator_2bit(Behavioral)
		port map (
			A(1) => A(1), 
			A(0) => A(0), 
			B(1) => B(1),
			B(0) => B(0),
			AeqB => eq0,
			AgrB => gr0,
			AsmB => sm0);

	AeqB <= eq1 AND eq0; --Equality Output
	AgrB <= gr1 OR (eq1 AND gr0); --Greater-than Output
	AsmB <= sm1 OR (eq1 AND sm0); --Smaller-than Output
	
end Behavioral;

