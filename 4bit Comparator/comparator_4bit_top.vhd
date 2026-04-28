-- Top Level for Active Low Logic

--Implementation of 4 bit comparator using 2 instantiations of 2bit comparators
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity comparator_4bit_top is
    Port(
      extA : in  STD_LOGIC_VECTOR (3 downto 0);
      extB : in  STD_LOGIC_VECTOR (3 downto 0);
      extAeqB : out  STD_LOGIC; -- A=B output
      extAgrB : out  STD_LOGIC; -- A>B output
      extAsmB : out  STD_LOGIC); -- A<B output
end comparator_4bit_top;

architecture Structural of comparator_4bit_top is
	
	signal intA, intB : STD_LOGIC_VECTOR (3 downto 0);
	signal intAeqB, intAgrB, intAsmB : STD_LOGIC;
	
	component comparator_4bit is
		Port ( A,B : in STD_LOGIC_VECTOR (3 downto 0);
				 AeqB : out STD_LOGIC;
				 AgrB : out STD_LOGIC;
				 AsmB : out STD_LOGIC);
		end component;
				 
begin
	--INVERT ALL INPUTS
	intA <= NOT extA;
	intB <= NOT extB;
	
	--Instantiation
	comp4b1: comparator_4bit port map(
		A => intA,
		B => intB,
		AeqB => intAeqB,
		AgrB => intAgrB,
		AsmB => intAsmB
		);
	
	--INVERT ALL OUTPUTS
	extAeqB <= NOT intAeqB;
	extAgrB <= NOT intAgrB;
	extAsmB <= NOT intAsmB;

end Structural;

