library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity bin_alu is
generic(NUMBITS : natural := 32);
    Port ( Atemp : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
			  Btemp : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
			  A : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);	
           B : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
           opcode : in  STD_LOGIC_VECTOR(3 downto 0);
           result : out  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end bin_alu;

architecture Behavioral of bin_alu is
--temp signal for alu
	signal stuff: std_logic_vector(NUMBITS downto 0);
	begin

	process (A, B, opcode, stuff, Atemp, Btemp)
	begin
	--UNSIGNED ADD
	if opcode = "1000" then
		stuff <= std_logic_vector( unsigned('0' & A ) + unsigned( '0' & B));
		result <= stuff(NUMBITS-1 downto 0);		
		--carryout <= '1';
		carryout <= stuff(NUMBITS);
		overflow <= '0';
		if stuff(NUMBITS downto 0) = 0 then
			zero <= '1';
		else
			zero <= '0';
		end if;
		
	--SIGNED ADD	
	elsif opcode = "1100" then
		stuff <= std_logic_vector( signed('0' & A) + signed('0' & B) );
		result <= stuff(NUMBITS-1 downto 0);		
		
		overflow <= '0';
		
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
		
		if (Atemp < Btemp) then
			overflow <= '1';
		end if;
		
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
	end if;
end process;	
end Behavioral;
