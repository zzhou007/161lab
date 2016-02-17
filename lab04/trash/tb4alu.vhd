--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:59:46 02/10/2016
-- Design Name:   
-- Module Name:   /home/csmajs/masfo001/lab4/tb.vhd
-- Project Name:  lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu_control
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb IS
END tb;
 
ARCHITECTURE behavior OF tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu_control
    PORT(
         alu_op : IN  std_logic_vector(1 downto 0);
         instruction_5_0 : IN  std_logic_vector(5 downto 0);
         alu_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal alu_op : std_logic_vector(1 downto 0) := (others => '0');
   signal instruction_5_0 : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal alu_out : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu_control PORT MAP (
          alu_op => alu_op,
          instruction_5_0 => instruction_5_0,
          alu_out => alu_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

	alu_op <= "00";
	instruction_5_0 <= "000000";

	wait for 100 ns;
	alu_op <= "01";
		instruction_5_0 <= "000001";

	wait for 100 ns;
	alu_op <= "10";
		instruction_5_0 <= "000010";

	wait for 100 ns;
	alu_op <= "11";
		instruction_5_0 <= "001000";

	wait for 100 ns;


      wait;
   end process;

END;
