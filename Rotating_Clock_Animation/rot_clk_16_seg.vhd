--Rotating Clock Sequence with 16 Segment Display
--Common Cathode
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rot_clk_16_seg is
	port(
		clk : in  STD_LOGIC;
      reset : in  STD_LOGIC;
		seg : out STD_LOGIC_VECTOR(15 downto 0)
		);
end rot_clk_16_seg;

architecture Behavioral of rot_clk_16_seg is
	
	constant DVSR : integer := 10000000; --Rotation Frequency = 25MHz / 10000000 = 2.5 Hz
	signal ms_reg, ms_next : unsigned (23 downto 0); -- Registers for clock divider
	signal ms_tick : STD_LOGIC;
	
	--Segment Registers
	signal ds_reg, ds_next : unsigned (2 downto 0);
	
begin
	--Registers
	process (clk)
	begin
		if rising_edge(clk) then
			ms_reg <= ms_next;
			ds_reg <= ds_next;
		end if;
	end process;
	
	--Clock Divider
	ms_next <= (others => '0') when reset = '1' or ms_reg = DVSR else
               ms_reg + 1;
    
	ms_tick <= '1' when ms_reg = DVSR else '0';
	
	--Next State Logic
	process (ds_reg, ms_tick, reset)
	begin 
		ds_next <= ds_reg;
	
		if reset = '1' then -- Reset
			ds_next <= "000";
	
		elsif ms_tick = '1' then
			if (ds_reg /= 7) then
					ds_next <= ds_reg + 1;
				else ds_next <= "000"; -- Wrap Around
			end if;
		end if;
	end process;
	
	--Output Logic
	process (ds_reg)
	begin
		--Start with all segments off
		seg <= (others => '0');
		
		case ds_reg is --    	 abcdefghkmnprstu
			when "000" => seg <= "1111111101000000";
			when "001" => seg <= "1111111101100000";
			when "010" => seg <= "1111111101010000";
			when "011" => seg <= "1111111101001000";
			when "100" => seg <= "1111111101000100";
			when "101" => seg <= "1111111101000010";
			when "110" => seg <= "1111111101000001";
			when "111" => seg <= "1111111111000000";
			when others => seg <= "0000000000000000";
		end case;
	end process;

end Behavioral;

