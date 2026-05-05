--Top Level module for 16 Segment Display Rotating Clock Animation
--Common Cathode Segments
--Active Low Inputs

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rot_clock_top is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (15 downto 0));
end rot_clock_top;

architecture Structural of rot_clock_top is
	
	signal int_reset : STD_LOGIC;
	
begin
	--INVERT INPUTS
	int_reset <= NOT reset;
	
	--Rotating Clock entity instantiation
	rot_clk : entity work.rot_clk_16_seg
		port map (clk => clk, reset => int_reset, seg => seg);
	
end Structural;

