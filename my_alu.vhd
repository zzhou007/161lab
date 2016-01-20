
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:09:00 01/06/2016 
-- Design Name: 
-- Module Name:    my_alu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
generic(NUMBITS : natural := 32);
    Port ( A : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);	
           B : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
           opcode : in  STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(NUMBITS + 3 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is
--temp signal for alu
signal stuff: std_logic_vector(NUMBITS downto 0);

--bcd section signals
signal A0: std_logic_vector (3 downto 0);
signal A1: std_logic_vector (3 downto 0);
signal A2: std_logic_vector (3 downto 0);
signal A3: std_logic_vector (3 downto 0);
signal A4: std_logic_vector (3 downto 0);
signal A5: std_logic_vector (3 downto 0);
signal A6: std_logic_vector (3 downto 0);
signal A7: std_logic_vector (3 downto 0);

signal B0: std_logic_vector (3 downto 0);
signal B1: std_logic_vector (3 downto 0);
signal B2: std_logic_vector (3 downto 0);
signal B3: std_logic_vector (3 downto 0);
signal B4: std_logic_vector (3 downto 0);
signal B5: std_logic_vector (3 downto 0);
signal B6: std_logic_vector (3 downto 0);
signal B7: std_logic_vector (3 downto 0);

--bin numbers for alu
signal ABIN: std_logic_vector (NUMBITS downto 0);
signal BBIN: std_logic_vector (NUMBITS downto 0);

begin
A0 <= A(3 downto 0);
A1 <= A(7 downto 4);
A2 <= A(11 downto 8);
A3 <= A(15 downto 12);
A4 <= A(19 downto 16);
A5 <= A(23 downto 20);
A6 <= A(27 downto 24);
A7 <= A(31 downto 28);

B0 <= B(3 downto 0);
B1 <= B(7 downto 4);
B2 <= B(11 downto 8);
B3 <= B(15 downto 12);
B4 <= B(19 downto 16);
B5 <= B(23 downto 20);
B6 <= B(27 downto 24);
B7 <= B(31 downto 28);

	--ALU 
	process (A, B, opcode, stuff)
	begin
	ABIN <= std_logic_vector(unsigned(A0) + (unsigned(A1) * 10) + 
									(unsigned(A2) * 100) + (unsigned(A3) * 1000) + 
									(unsigned(A4) * 10000) + (unsigned(A5) * 100000) + 
									(unsigned(A6) * 1000000) + (unsigned(A7) * 100000000));
	
	--UNSIGNED ADD
	if opcode = "1000" then
		stuff <= std_logic_vector( unsigned('0' & A ) + unsigned( '0' & B));
		result <= stuff(NUMBITS-1 downto 0);		
		--carryout <= '1';
		carryout <= stuff(NUMBITS);
		overflow <= stuff(NUMBITS);
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
	--SIGNED ADD	
	elsif opcode = "1100" then
		stuff <= std_logic_vector( signed('0' & A) + signed('0' & B) );
		result <= stuff(NUMBITS-1 downto 0);		
		
		if (A(NUMBITS-1) = '0') and (B(NUMBITS-1) = '0') and (stuff(NUMBITS-1) = '1') then
			overflow <= '1';
		elsif (A(NUMBITS-1) = '1') and (B(NUMBITS-1) = '1') and (stuff(NUMBITS-1) = '0') then
			overflow <= '1';
		else
			overflow <= '0';
		end if;
		
		carryout <= stuff(NUMBITS);
		
		if stuff(NUMBITS - 1 downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
	
	--UNSIGNED SUB
	elsif opcode = "1001" then
		stuff <= std_logic_vector( ('0' & unsigned(A) ) + ( '0' & ((not unsigned(B)) + 1)));
		result <= stuff(NUMBITS-1 downto 0);		
		
		overflow <= stuff(NUMBITS - 1);
		
		if stuff(NUMBITS - 1) = '0' then
			carryout <= '1';
		else
			carryout <= '0';
		end if;
		
		if stuff(NUMBITS - 1 downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
	
	--SIGNED SUB
	elsif opcode = "1101" then
		stuff <= std_logic_vector( ('0' & signed(A) ) + ( '0' & ((not signed(B)) + 1)));
		result <= stuff(NUMBITS-1 downto 0);		
		
		if (A(NUMBITS-1) = '0') and (B(NUMBITS-1) = '1') and (stuff(NUMBITS-2) = '1') then
			overflow <= '1';
		elsif (A(NUMBITS-1) = '1') and (B(NUMBITS-1) = '0') and (stuff(NUMBITS-2) = '0') then
			overflow <= '1';
		else
			overflow <= '0';
		end if;

		carryout <= stuff(NUMBITS);
		
		if stuff(NUMBITS - 1 downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;

	--BITWISE AND
	elsif opcode = "100" then
		stuff <= std_logic_vector(('0' & A) AND ('0' & B));
		result <= stuff(NUMBITS-1 downto 0);
		overflow <= '0';
		carryout <= '0';
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
	--BITWISE OR
	elsif opcode = "101" then
		stuff <= std_logic_vector(('0' & A) OR ('0' & B));
		result <= stuff(NUMBITS-1 downto 0);
		overflow <= '0';
		carryout <= '0';
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;

	--BITWUS XOR
	elsif opcode = "110" then
		stuff <= std_logic_vector(('0' & A) XOR ('0' & B));
		result <= stuff(NUMBITS-1 downto 0);
		overflow <= '0';
		carryout <= '0';
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
	
	else
		--Divide A by 2
		stuff <= std_logic_vector( ('0' & unsigned(A)) / 2 );
		result <= stuff(NUMBITS-1 downto 0);
		overflow <= '0';
		carryout <= '0';
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
	
	end if;
	end process;
	
end Behavioral;
