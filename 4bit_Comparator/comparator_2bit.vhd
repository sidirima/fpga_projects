--Basic Code for 2 bit Comparator with SOP implementation

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator_2bit is
    Port(
      A : in  STD_LOGIC_VECTOR (1 downto 0);
      B : in  STD_LOGIC_VECTOR (1 downto 0);
      AeqB : out  STD_LOGIC;
      AgrB : out  STD_LOGIC;
      AsmB : out  STD_LOGIC);
end comparator_2bit;

architecture Behavioral of comparator_2bit is

	signal p0,p1,p2,p3,p4,p5,p6,p7,p8,p9 : STD_LOGIC;

begin
	--Equality Comparator
	p0 <= ((NOT A(1) AND NOT A(0)) AND (NOT B(1) AND NOT B(0)));
	p1 <= ((NOT A(1) AND A(0)) AND (NOT B(1)) AND B(0));
	p2 <= (A(1) AND NOT A(0)) AND B(1) AND (NOT B(0));
	p3 <= (A(1) AND A(0) AND B(1) AND B(0));
	AeqB <= p0 OR p1 OR p2 OR p3;
	
	--Greater-than Comparator
	p4 <= (A(1) AND (NOT B(1)));
	p5 <= (A(0) AND (NOT B(1)) AND (NOT B(0)));
	p6 <= (A(1) AND A(0) AND (NOT B(0)));
	AgrB <= p4 OR p5 OR p6;
	
	--Smaller-than Comparator
	p7 <= ((NOT A(0)) AND B(1) AND B(0));
	p8 <= ((NOT A(1)) AND (NOT A(0)) AND B(0));
	p9 <= ((NOT A(1)) AND B(1));
	AsmB <= p7 OR p8 OR p9;

end Behavioral;

