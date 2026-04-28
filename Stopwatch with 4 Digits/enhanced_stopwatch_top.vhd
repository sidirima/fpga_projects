--Top Level Module for Enhanced Stopwatch
--Active Low Button Inputs
--Common Anode 7 Segment LED Display

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity enhanced_stopwatch_top is
    Port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (2 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           sseg : out  STD_LOGIC_VECTOR (7 downto 0));
end enhanced_stopwatch_top;

architecture Structural of enhanced_stopwatch_top is

	signal d3, d2, d1, d0 : STD_LOGIC_VECTOR (3 downto 0);
	signal int_btn : STD_LOGIC_VECTOR (2 downto 0);
	
begin
	--7 Segment Multiplexer Instantiation
	disp_unit: entity work.disp_hex_mux
		port map(
			clk => clk, reset => '0',
			hex3 => d3, hex2 => d2, hex1 => d1, hex0 => d0,
			dp_in => "0110", an => an, sseg => sseg);
	
	enh_stopwatch: entity work.enhanced_stopwatch
		port map(
			clk => clk, go => btn(2), up => btn(1), clr => btn(0),
			d3 => d3, d2 => d2, d1 => d1, d0 => d0);

end Structural;

