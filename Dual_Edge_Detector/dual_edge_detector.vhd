--Dual Edge Detector Module using Moore & Mealy FSM Design
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity dual_edge_detector is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           level : in  STD_LOGIC;
           edge : out  STD_LOGIC);
end dual_edge_detector;

architecture moore_arch of dual_edge_detector is
	
	type state_type is (zero, ris_edge, fall_edge, one);
	signal state_reg, state_next : state_type;
	
begin
	--State Register
	process(clk,reset)
	begin
		if (reset = '1') then
			state_reg <= zero; -- Default state
		elsif rising_edge (clk) then
			state_reg <= state_next;
		end if;
	end process;

	--Next State / Output
	process(state_reg, level)
		begin
			state_next <= state_reg; -- Default state
			edge <= '0'; -- Default tick
			case state_reg is
				when zero =>
					if level = '1' then
						state_next <= ris_edge;
					end if;
				
				when ris_edge =>
					edge <= '1';
					if level = '1' then
						state_next <= one;
					else
						state_next <= zero;
					end if;
				
				when one =>
					if level = '0' then
						state_next <= fall_edge;
					end if;
				
				when fall_edge => --Next state is ALWAYS zero
					edge <= '1';
					state_next <= zero;
					
			end case;
		end process;
end moore_arch;

architecture mealy_arch of dual_edge_detector is
	
	type state_type is (zero, one);
	signal state_reg, state_next : state_type;
	
begin
	--State Register
	process (clk, reset)
	begin
		if (reset = '1') then
			state_reg <= zero; -- Default state
		elsif rising_edge (clk) then
			state_reg <= state_next;
		end if;
	end process;
	
	--Next State / Output Logic
	process (state_reg, level)
	begin
		state_next <= state_reg;
		edge <= '0';
		case state_reg is
			when zero =>
				if level = '1' then
					state_next <= one;
					edge <= '1';
				end if;
			
			when one =>
				if level = '0' then
					state_next <= zero;
					edge <= '1';
				end if;
		end case;
	end process;
end mealy_arch;

