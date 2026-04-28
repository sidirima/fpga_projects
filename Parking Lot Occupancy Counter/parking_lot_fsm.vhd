
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parking_lot_fsm is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  sw : in STD_LOGIC_VECTOR(1 downto 0);
           a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           enter_car : out  STD_LOGIC;
           exit_car : out  STD_LOGIC);
end parking_lot_fsm;

architecture Behavioral of parking_lot_fsm is
	type state_type is (start, enter1, enter2, enter3, 
							  entered, exit1, exit2, exit3, exited);
	signal state_reg, state_next : state_type;
					
begin
	--Register
	reg_proc : process (clk,reset)
	begin
		if (reset = '1') then
			state_reg <= start;
		elsif rising_edge (clk) then
			state_reg <= state_next;
		end if;
	end process;

	--Next State / Output Logic
	process (state_reg, a, b)
	begin
		state_next <= state_reg;
		enter_car <= '0';
		exit_car <= '0';
		case state_reg is -- ab
			when start => -- "00"
				if (a = '1' AND b = '0') then
					state_next <= enter1; -- Car maybe entering // Check a AND b sensor
				elsif (a = '0' AND b = '1') then
					state_next <= exit1; -- Car maybe exiting // Check a AND b sensor
				end if;
			
			when enter1 => -- "10"
				if (a = '1' AND b = '1') then
					state_next <= enter2; -- Car maybe entering // Check b sensor
				elsif (a = '0' AND b = '0') then
					state_next <= start; -- Pedestrian crossing // False trigger
				end if;
			
			when enter2 => -- "11"
				if (a = '0' AND b = '1') then
					state_next <= enter3; -- Car is entering // Check a sensor release
				elsif (a = '1' AND b = '0') then
					state_next <= enter1; -- Pedestrian or car re-check // Check again
				end if;
			
			when enter3 => -- "01"
				if (a = '0' AND b = '0') then -- Car entered // Check a AND b Sensors Released
					state_next <= entered;
				elsif (a = '1' AND b = '1') then -- Car is maybe entering // Check again
					state_next <= enter2;
				end if;
			
			when entered => -- "00"
				enter_car <= '1';
				state_next <= start;
			
			when exit1 => -- "01"
				if (a = '1' AND b = '1') then -- Car maybe exiting // Check a AND b sensor
					state_next <= exit2;
				elsif (a = '0' AND b = '0') then -- Pedestrian crossing // False Trigger
					state_next <= start;
				end if;
				
			when exit2 => -- "11"
				if (a = '1' AND b = '0') then -- Car maybe exiting // Check a sensor
					state_next <= exit3;
				elsif (a = '0' AND b = '1') then -- Pedestrian or car re-check // Check again
					state_next <= exit1; 
				end if;
			
			when exit3 => -- "10"
				if (a = '0' AND b = '0') then -- Car exited // Check a AND b sensors release
					state_next <= exited;
				elsif (a = '1' AND b = '1') then -- Pedestrian or car re-check // Check again
					state_next <= exit2;
				end if;
			
			when exited =>
				exit_car <= '1';
				state_next <= start;
		
		end case;
	end process;
end Behavioral;

