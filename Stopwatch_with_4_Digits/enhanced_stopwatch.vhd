--Enhanced Stopwatch with 4 Displays M.SS.D
--For 25 MHz clock

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity enhanced_stopwatch is
    Port ( clk : in  STD_LOGIC;
           go : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           up : in  STD_LOGIC;
           d3 : out  STD_LOGIC_VECTOR (3 downto 0);
           d2 : out  STD_LOGIC_VECTOR (3 downto 0);
           d1 : out  STD_LOGIC_VECTOR (3 downto 0);
           d0 : out  STD_LOGIC_VECTOR (3 downto 0));
end enhanced_stopwatch;

architecture Behavioral of enhanced_stopwatch is
	
	constant DVSR: integer := 2500000; -- For Clock Divider for 100ms
	signal ms_reg, ms_next : unsigned (21 downto 0); -- Clock Register
	signal ms_tick : STD_LOGIC;
	
	--Digits Registers
	signal d3_reg, d2_reg, d1_reg, d0_reg : unsigned (3 downto 0); 
   signal d3_next, d2_next, d1_next, d0_next : unsigned (3 downto 0);
	
begin
	--Register
	process(clk)
	begin
		if rising_edge(clk) then
			ms_reg <= ms_next;
         d3_reg <= d3_next;
         d2_reg <= d2_next;
         d1_reg <= d1_next;
         d0_reg <= d0_next;
		end if;
	end process;

	--Clock Divider (100 ms Tick Generator)
	ms_next <= (others => '0') when clr = '1' or 
															(ms_reg = DVSR and go = '1') else
               ms_reg + 1		when go = '1' else
               ms_reg;
    
	ms_tick <= '1' when ms_reg = DVSR else '0';
	
	--Next State Logic
	process (d0_reg, d1_reg, d2_reg, d3_reg, ms_tick, clr, up)
	begin
		d0_next <= d0_reg;
		d1_next <= d1_reg;
		d2_next <= d2_reg;
		d3_next <= d3_reg;
		
		if clr = '1' then -- Clear Digits
			d0_next <= "0000";
			d1_next <= "0000";
			d2_next <= "0000";
			d3_next <= "0000";
		
		elsif ms_tick = '1' then
			if up = '1' then -- UP COUNTER LOGIC
				if (d0_reg /= 9) then -- Decimal Digit
					d0_next <= d0_reg + 1;
				else
					d0_next <= "0000";
					if (d1_reg /= 9) then -- Second (Ones) Digit
						d1_next <= d1_reg + 1;
					else
						d1_next <= "0000";
						if (d2_reg /= 5) then -- Second (Tens) Digit
							d2_next <= d2_reg + 1;
						else
							d2_next <= "0000";
							if (d3_reg /= 9) then -- Minutes Digit
								d3_next <= d3_reg + 1;
							else
								d3_next <= "0000"; -- Wrap Around for further addition
							end if;
						end if;
					end if;
				end if;
			-----------------------------------------------------------------------
			else -- DOWN COUNTER LOGIC
				--Check if counter is NOT already at zero
				if (d0_reg /= 0 OR d1_reg /= 0 OR d2_reg /= 0 OR d1_reg /= 0) then
					if (d0_reg /= 0) then -- Decimal Digit
						d0_next <= d0_reg - 1;
					else
						d0_next <= "1001";
						if (d1_reg /= 0) then -- Second (Ones) Digit
							d1_next <= d1_reg - 1;
						else
							d1_next <= "1001";
							if (d2_reg /= 0) then -- Second (Tens) Digit
								d2_next <= d2_reg - 1;
							else
								d2_next <= "0101";
								if (d3_reg /= 0) then -- Minutes Digit
									d3_next <= d3_reg - 1;
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
	
	--Output Logic
	d0 <= STD_LOGIC_VECTOR(d0_reg);
	d1 <= STD_LOGIC_VECTOR(d1_reg);
	d2 <= STD_LOGIC_VECTOR(d2_reg);
	d3 <= STD_LOGIC_VECTOR(d3_reg);
	
end Behavioral;

