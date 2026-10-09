
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity disp_hex_mux is
    Port ( clk : in  STD_LOGIC;
			  reset : in STD_LOGIC;
           hex3 : in  STD_LOGIC_VECTOR (3 downto 0);
           hex2 : in  STD_LOGIC_VECTOR (3 downto 0);
           hex1 : in  STD_LOGIC_VECTOR (3 downto 0);
           hex0 : in  STD_LOGIC_VECTOR (3 downto 0);
           dp_in : in  STD_LOGIC_VECTOR (3 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (7 downto 0));
end disp_hex_mux;

architecture Behavioral of disp_hex_mux is
	-- Each LED enabled for (2^17/4) * 25 ns
	constant N: integer := 17;
	signal q_reg, q_next : unsigned (N-1 downto 0);
	signal sel : STD_LOGIC_VECTOR (1 downto 0);
	signal hex : STD_LOGIC_VECTOR (3 downto 0);
	signal dp : STD_LOGIC;
	
	
begin
	
	--Register
	process (clk,reset)
	begin
		if reset = '1' then
			q_reg <= (others => '0');
		elsif rising_edge(clk) then
			q_reg <= q_next;
		end if;
	end process;

	--Next State Logic for counter
	q_next <= q_reg + 1;
	
	--2 MSBs of counter control 4to1 multiplexing
	sel <= STD_LOGIC_VECTOR (q_reg(N-1 downto N-2));
	process(sel,hex0, hex1, hex2, hex3, dp_in)
	begin
		case sel is
			when "00" => 
				an <= "1110"; -- X X X ON
				hex <= hex0;
				dp <= dp_in(0);
			
			when "01" =>
				an <= "1101"; -- X X ON X
				hex <= hex1;
				dp <= dp_in(1);
			
			when "10" =>
				an <= "1011"; -- X ON X X
				hex <= hex2;
				dp <= dp_in(2);
			
			when others =>
				an <= "0111"; -- ON X X X
				hex <= hex3;
				dp <= dp_in(3);
		end case;
	end process;

	--HEX-to-7 Segment Decoding
	with hex select
		sseg(6 downto 0) <=
			"0000001" when "0000", -- 0
			"1001111" when "0001", -- 1
			"0010010" when "0010", -- 2
			"0000110" when "0011", -- 3
			"1001100" when "0100", -- 4
			"0100100" when "0101", -- 5
			"0100000" when "0110", -- 6
			"0001111" when "0111", -- 7
			"0000000" when "1000", -- 8
			"0000100" when "1001", -- 9
			"0001000" when "1010", -- A
			"1100000" when "1011", -- B
			"0110001" when "1100", -- C
			"1000010" when "1101", -- D
			"0110000" when "1110", -- E
			"0111000" when "1111", -- F
			"1111111" when others; -- Failsafe
	
	--Decimal point
	sseg(7) <= dp;
end Behavioral;

