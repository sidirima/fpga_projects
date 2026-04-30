-- Module for Binary to BCD Conversion using the Double Dabble Algorithm
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin2bcd_dd is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           start : in  STD_LOGIC;
           bin : in  STD_LOGIC_VECTOR (7 downto 0);
           ready : out  STD_LOGIC;
           done_tick : out  STD_LOGIC;
           bcd1 : out  STD_LOGIC_VECTOR (3 downto 0);
           bcd0 : out  STD_LOGIC_VECTOR (3 downto 0);
           ovf : out  STD_LOGIC_VECTOR (1 downto 0));
end bin2bcd_dd;

architecture Behavioral of bin2bcd_dd is
	
	type state_type is (idle, op, done);
	signal state_reg, state_next : state_type;
	signal p2s_reg, p2s_next : std_logic_vector(7 downto 0);
	signal n_reg, n_next : unsigned (3 downto 0);
	signal ovf_reg, bcd1_reg, bcd0_reg: unsigned (3 downto 0);
	signal ovf_next, bcd1_next, bcd0_next : unsigned (3 downto 0);
	signal ovf_temp, bcd1_temp, bcd0_temp : unsigned (3 downto 0);
	
begin
	-- State and Data Registers
	process (clk,reset)
	begin
		if reset = '1' then
			state_reg <= idle;
			p2s_reg 	<= (others => '0');
			n_reg 	<= (others => '0');
			ovf_reg 	<= (others => '0');
			bcd1_reg <= (others => '0');
			bcd0_reg <= (others => '0');
		elsif rising_edge(clk) then
			state_reg <= state_next;
			p2s_reg <= p2s_next;
			n_reg <= n_next;
			ovf_reg <= ovf_next;
			bcd1_reg <= bcd1_next;
			bcd0_reg <= bcd0_next;
		end if;
	end process;
	
	--FSMD Next State Logic / Data Path Operations
	process (state_reg, start, p2s_reg, n_reg, n_next,
				bin, bcd0_reg, bcd1_reg, ovf_reg,
				bcd0_temp, bcd1_temp, ovf_temp)
	begin
		state_next <= state_reg;
		ready <= '0';
		done_tick <= '0';
		p2s_next <= p2s_reg;
		bcd0_next <= bcd0_reg;
		bcd1_next <= bcd1_reg;
		ovf_next <= ovf_reg;
		n_next <= n_reg;
		
		case state_reg is
			when idle =>
				ready <= '1';
				if start = '1' then 
					state_next <= op;
					ovf_next <= (others => '0');
					bcd1_next <= (others => '0');
					bcd0_next <= (others => '0');
					n_next <= "1000"; -- Index is equal to width of number insterted
					p2s_next <= bin; -- Input Shift Register
					state_next <= op;
				end if;
			
			when op =>
				--Shift in binary bit
				p2s_next <= p2s_reg(6 downto 0) & '0';
				--Shift 3 BCD digits
				bcd0_next <= bcd0_temp(2 downto 0) & p2s_reg(7);
				bcd1_next <= bcd1_temp(2 downto 0) & bcd0_temp(3);
				ovf_next <= ovf_temp (2 downto 0) & bcd1_temp(3);
				n_next <= n_reg - 1; -- Index counter
				if (n_next = 0) then
					state_next <= done;
				end if;
				
			when done =>
				state_next <= idle;
				done_tick <= '1';
		end case;
	end process;
	
	--Data Path Function Units
	--BCD ADJUSTMENT CIRCUITS
	bcd0_temp <= bcd0_reg + 3 when bcd0_reg > 4 else -- Add 3 when bigger of 4
					 bcd0_reg;
	bcd1_temp <= bcd1_reg + 3 when bcd1_reg > 4 else
					 bcd1_reg;
	ovf_temp <= ovf_reg + 3 when ovf_reg > 4 else
					ovf_reg;
	
	--Output
	bcd0 <= std_logic_vector(bcd0_reg);
	bcd1 <= std_logic_vector(bcd1_reg);
	ovf <= std_logic_vector(ovf_reg(1 downto 0)); -- The ovf is just a 1bit flag, so the LSB is enough
					

end Behavioral;

