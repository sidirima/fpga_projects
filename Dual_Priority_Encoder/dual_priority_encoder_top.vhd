--Top Level for Dual Priority Encoder with 12bit Input and 4 bit outputs
--Active Low Logic
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dual_priority_encoder_top is
    Port ( req : in  STD_LOGIC_VECTOR (11 downto 0);
           first : out  STD_LOGIC_VECTOR (6 downto 0);
           second : out  STD_LOGIC_VECTOR (6 downto 0));
end dual_priority_encoder_top;

architecture Behavioral of dual_priority_encoder_top is

	signal int_req : STD_LOGIC_VECTOR (11 downto 0);
	signal int_req_first : STD_LOGIC_VECTOR (11 downto 0);
	signal int_dec_first : STD_LOGIC_VECTOR (11 downto 0);
	signal dec_first_not: STD_LOGIC_VECTOR (11 downto 0);
	signal int_first, int_second : STD_LOGIC_VECTOR (3 downto 0);
	
begin
	--INVERT ALL INPUTS
	int_req <= NOT req;
	
	--Find the first '1'
	prenc_1: entity work.priority_encoder_12to4
		port map (req => int_req, y => int_first);
	
	--Decode the first position
	dec: entity work.decoder_12to4
		port map (first => int_first, first_dec =>int_dec_first);
	
	--Invert the decoded first position
	dec_first_not <= NOT int_dec_first;
	
	--Perform AND to eliminate fist '1'
	int_req_first <=dec_first_not AND int_req;
	
	--Find the second '1'
	prenc_2: entity work.priority_encoder_12to4
		port map (req => int_req_first, y => int_second);
	
	--Outputs
	sseg_1: entity work.hex_to_7_segment
		port map (hex => int_first, sseg => first);
	
	sseg_2: entity work.hex_to_7_segment
		port map (hex => int_second, sseg => second);
		
end Behavioral;

