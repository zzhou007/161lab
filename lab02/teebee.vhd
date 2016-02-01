--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:14:24 01/27/2016
-- Design Name:   
-- Module Name:   /home/csmajs/masfo001/lab2/tbbbbbe.vhd
-- Project Name:  lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_alu
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
 
ENTITY tbbbbbe IS
END tbbbbbe;
 
ARCHITECTURE behavior OF tbbbbbe IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_alu
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         opcode : IN  std_logic_vector(3 downto 0);
         result : OUT  std_logic_vector(35 downto 0);
         carryout : OUT  std_logic;
         overflow : OUT  std_logic;
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal opcode : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(35 downto 0);
   signal carryout : std_logic;
   signal overflow : std_logic;
   signal zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_alu PORT MAP (
          A => A,
          B => B,
          opcode => opcode,
          result => result,
          carryout => carryout,
          overflow => overflow,
          zero => zero
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 10 ns;
		
		--add value will go to new n+3 digit
		opcode <= "1000";
		A <= "10010000000000000000000000000000";
		B <= "00011000000000000000000000000101";
      wait for 10 ns;
		
		--add value will not go to new n+3 digit
		opcode <= "1000";
		A <= "00010000000000000000000000000000";
		B <= "00011000000000000000000000000101";
		wait for 10 ns;
		
		--signed add value will be 0
		opcode <= "1100";
		A <= "00000000000000001000000000000101";
		B <= "00010000000000001000000000000101";
		wait for 10 ns;
		
		--signed add value will be +
		opcode <= "1100";
		A <= "10010000000000000000000000000000";
		B <= "00001000000000000000000000000101";
      wait for 10 ns;	
		
		--signed add value will be -
		opcode <= "1100";
		A <= "10010000000000000000000000000000";
		B <= "00011000000000000000000000000101";
		wait for 10 ns;
		
		--unsigned sub value will be 0
		opcode <= "1001";
		A <= "10011000000000000000000000000101";
		B <= "10011000000000000000000000000101";
      wait for 10 ns;	
		
		--unsigned sub value will be +
		opcode <= "1001";
		A <= "10011000000000000000000000000101";
		B <= "00011000000000000000000000000101";
      wait for 10 ns;	

		--unsigned sub value will be -
		opcode <= "1001";
		A <= "00011000000000000000000000000101";
		B <= "10011000000000000000000000000101";
		wait for 10 ns;

		--signed sub value will be 0
		opcode <= "1101";
		A <= "00001000000000000000000000000101";
		B <= "00001000000000000000000000000101";
		wait for 10 ns;

		--signed sub value will be 0
		opcode <= "1101";
		A <= "00011000000000000000000000000101";
		B <= "00011000000000000000000000000101";
		wait for 10 ns;
		
		--signed sub value will be 5
		opcode <= "1101";
		A <= "00001000000000000000000000000101";
		B <= "00001000000000000000000000000000";
		wait for 10 ns;

      wait;
   end process;

END;
