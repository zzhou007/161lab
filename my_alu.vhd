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
generic(NUMBITS : natural := 8);
    Port ( A : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);	
           B : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           opcode : in  STD_LOGIC_VECTOR(2 downto 0);
           result : out  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is
signal stuff: std_logic_vector(NUMBITS downto 0);
begin

	process (A, B, opcode, stuff)
	begin

	--UNSIGNED ADD
	if opcode = "000" then
		stuff <= std_logic_vector( ('0' & unsigned(A) ) + ( '0' & unsigned(B)));
		result <= stuff(NUMBITS-1 downto 0);		
		overflow <= '0';
		carryout <= stuff(NUMBITS);
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
	--SIGNED ADD	
	elsif opcode = "001" then
		stuff <= std_logic_vector( signed('0' & A) + signed('0' & B) );
		result <= stuff(NUMBITS-1 downto 0);		
		
		if (A(NUMBITS-1) = '0') and (B(NUMBITS-1) = '0') and (stuff(NUMBITS-1) = '1') then
			overflow <= '1';
		elsif (A(NUMBITS-1) = '1') and (B(NUMBITS-1) = '1') and (stuff(NUMBITS-1) = '0') then
			overflow <= '1';
		else
			overflow <= '0';
		end if;

		carryout <= '0';
		
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
	
	--UNSIGNED SUB
	elsif opcode = "010" then
		stuff <= std_logic_vector( ('0' & unsigned(A) ) + ( '0' & ((not unsigned(B)) + 1)));
		result <= stuff(NUMBITS-1 downto 0);		
		
		overflow <= '0';
		
		if stuff(NUMBITS) = '0' then
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
	elsif opcode = "011" then
		stuff <= std_logic_vector( ('0' & signed(A) ) + ( '0' & ((not signed(B)) + 1)));
		result <= stuff(NUMBITS-1 downto 0);		
		
		if (A(NUMBITS-1) = '0') and (B(NUMBITS-1) = '1') and (stuff(NUMBITS-2) = '1') then
			overflow <= '1';
		elsif (A(NUMBITS-1) = '1') and (B(NUMBITS-1) = '0') and (stuff(NUMBITS-2) = '0') then
			overflow <= '1';
		else
			overflow <= '0';
		end if;

		carryout <= '0';
		
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
