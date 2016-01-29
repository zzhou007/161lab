library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_arith.conv_std_logic_vector;
library work;

entity bcd_bin is
generic(NUMBITS : natural := 32);
    Port ( I : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
			  opcode : in STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0));
end bcd_bin;

architecture Behavioral of bcd_bin is
--bcd section signals
	signal T0: std_logic_vector (3 downto 0);
	signal T1: std_logic_vector (3 downto 0);
	signal T2: std_logic_vector (3 downto 0);
	signal T3: std_logic_vector (3 downto 0);
	signal T4: std_logic_vector (3 downto 0);
	signal T5: std_logic_vector (3 downto 0);
	signal T6: std_logic_vector (3 downto 0);
	signal T7: std_logic_vector (3 downto 0);
		

	begin
	--moving each digit of bcd input into own section
		T0 <= I(3 downto 0);
		T1 <= I(7 downto 4);
		T2 <= I(11 downto 8);
		T3 <= I(15 downto 12);
		T4 <= I(19 downto 16);
		T5 <= I(23 downto 20);
		T6 <= I(27 downto 24);
		T7 <= I(31 downto 28);

		process (opcode, T0, T1, T2, T3, T4, T5, T6, T7)
		variable Tint : integer;
		begin
			--stores the bin when adding all the sections together
			Tint := 0; 
			
			--if unsigned
			if (opcode = "1000" or opcode = "1001") then
				Tint := (to_integer(unsigned(T0)) + to_integer(unsigned(T1)) * 10 +
							to_integer(unsigned(T2)) * 100 + to_integer(unsigned(T3)) * 1000 +
							to_integer(unsigned(T4)) * 10000 + to_integer(unsigned(T5)) * 100000 +
							to_integer(unsigned(T6)) * 1000000 + to_integer(unsigned(T7)) * 10000000);
				O <= conv_std_logic_vector(Tint, NUMBITS);
				
			--if signed
			else 
				--if pos
				if T7 = "0000" then
					Tint := (to_integer(unsigned(T0)) + to_integer(unsigned(T1)) * 10 +
							to_integer(unsigned(T2)) * 100 + to_integer(unsigned(T3)) * 1000 +
							to_integer(unsigned(T4)) * 10000 + to_integer(unsigned(T5)) * 100000 +
							to_integer(unsigned(T6)) * 1000000);
					O <= conv_std_logic_vector(Tint, NUMBITS);
				
				else
					Tint := (to_integer(unsigned(T0)) + to_integer(unsigned(T1)) * 10 +
							to_integer(unsigned(T2)) * 100 + to_integer(unsigned(T3)) * 1000 +
							to_integer(unsigned(T4)) * 10000 + to_integer(unsigned(T5)) * 100000 +
							to_integer(unsigned(T6)) * 1000000);
					O <= (not (conv_std_logic_vector(Tint, NUMBITS))) + 1;
				
				end if;
			end if;
	end process;	
end Behavioral;
