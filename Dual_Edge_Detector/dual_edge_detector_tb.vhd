
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY dual_edge_detector_tb IS
END dual_edge_detector_tb;
 
ARCHITECTURE behavior OF dual_edge_detector_tb IS 

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal level : std_logic := '0';
	
	--Signals for MOORE and MEALY
	signal edge_moore : STD_LOGIC;
	signal edge_mealy : STD_LOGIC;

 	--Outputs
   signal edge : std_logic;

   -- Clock period definitions
   constant clk_period : time := 40 ns;
 
BEGIN
 
	-- Instantiate the MOORE Unit Under Test (UUT)
   UUT_MOORE: entity work.dual_edge_detector(moore_arch) 
		PORT MAP (
          clk => clk,
          reset => reset,
          level => level,
          edge => edge_moore
		);
 
	-- Instantiate the MEALY Unit Under Test (UUT)
   UUT_MEALY: entity work.dual_edge_detector(mealy_arch) 
		PORT MAP (
          clk => clk,
          reset => reset,
          level => level,
          edge => edge_mealy
		);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      --Reset
		reset <= '1';
		level <= '0';
		wait for 40 ns;
		reset <= '0';
		wait for clk_period;
		
		--Rising Edge Test
		report "Testing Rising Edge...";
		level <= '1';
		wait for 4 * clk_period;
		
		--Falling Edge Test
		report "Testing Falling Edge...";
		level <= '0';
		wait for 4 * clk_period;
		
		--Pulse Test
		report "Testing Pulse...";
		level <= '1';
		wait for clk_period;
		level <= '0';
		wait for 3 * clk_period;
		
		--Testing Reset during Operation
		report "Testing Reset during operation...";
		level <= '1';
		wait for clk_period;
		reset <= '1';
		wait for clk_period;
		reset <= '0';
		level <= '0';
		
		report "Simulation Finished successfully!";

      wait;
   end process;

END;
