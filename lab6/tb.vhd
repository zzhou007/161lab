LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
 
ENTITY system_tb IS
END system_tb;
 
ARCHITECTURE behavior OF system_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CAM_Wrapper
	 
	 GENERIC 
	   (
			CAM_WIDTH : integer := 4 ;
			CAM_DEPTH : integer := 4 
		);
		
    PORT(
         clk 					    : IN  std_logic;
         rst 						 : IN  std_logic;
         we_decoded_row_address: IN  std_logic_vector(3 downto 0);
         search_word 			 : IN  std_logic_vector(3 downto 0);
         dont_care_mask 		 : IN  std_logic_vector(3 downto 0);
         decoded_match_address : OUT  std_logic_vector(3 downto 0)
        );
		  
    END COMPONENT;
    

   --Inputs
   signal clk 							: std_logic := '0';
   signal rst 							: std_logic := '0';
   signal we_decoded_row_address : std_logic_vector(3 downto 0) := (others => '0');
   signal search_word 				: std_logic_vector(3 downto 0) := (others => '0');
   signal dont_care_mask 			: std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal decoded_match_address 	: std_logic_vector(3 downto 0);
	
	-- Temps for verification
	signal temp_addr					: std_logic_vector(3 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period 				: time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CAM_Wrapper GENERIC MAP
	(
		CAM_WIDTH => 4,
		CAM_DEPTH => 4
	)
	PORT MAP 
	(
          clk 							=> clk,
          rst 							=> rst,
          we_decoded_row_address => we_decoded_row_address,
          search_word 				=> search_word,
          dont_care_mask 			=> dont_care_mask,
          decoded_match_address 	=> decoded_match_address
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
      -- hold reset state for 100ms.
		wait for clk_period/2;
		rst <= '1';
      wait for clk_period*2;
		rst <= '0';

      -- insert stimulus here 
		for i in 3 downto 0 loop
			we_decoded_row_address <= (OTHERS => '0');
			we_decoded_row_address(i) <= '1';
			search_word <= conv_std_logic_vector((i+1)*2, 4);
			wait for clk_period;
			
		end loop;

		we_decoded_row_address <= (OTHERS => '0');
		wait for clk_period;
		
		for i in 8 downto 1 loop
			search_word <= conv_std_logic_vector(i, 4);
			
			wait for clk_period;
			temp_addr <= (others => '0');
			
			if( i mod(2) = 0 ) then
				temp_addr( (i/2) - 1) <= '1'; 
				
			end if;
			wait for 10 ns;
			assert temp_addr = decoded_match_address report "Case did not match, you have a bug in your code" severity Warning;
		end loop;
		
		
      wait;
   end process;

END;