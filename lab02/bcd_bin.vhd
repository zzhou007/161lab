library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity bcd_bin is
generic(NUMBITS : natural := 32);
    Port ( I : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
			  opcode : in STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0));
end bcd_bin;

architecture Behavioral of bcd_bin is
--bcd section signals
	signal T0: std_logic_vector (31 downto 0);
	signal T1: std_logic_vector (31 downto 0);
	signal T2: std_logic_vector (31 downto 0);
	signal T3: std_logic_vector (31 downto 0);
	signal T4: std_logic_vector (31 downto 0);
	signal T5: std_logic_vector (31 downto 0);
	signal T6: std_logic_vector (31 downto 0);
	signal T7: std_logic_vector (31 downto 0);
	signal TBIN: std_logic_vector (NUMBITS downto 0);

	begin

		T0 <= "0000000000000000000000000000"&I(3 downto 0);
		T1 <= "0000000000000000000000000000"&I(7 downto 4);
		T2 <= "0000000000000000000000000000"&I(11 downto 8);
		T3 <= "0000000000000000000000000000"&I(15 downto 12);
		T4 <= "0000000000000000000000000000"&I(19 downto 16);
		T5 <= "0000000000000000000000000000"&I(23 downto 20);
		T6 <= "0000000000000000000000000000"&I(27 downto 24);
		T7 <= "0000000000000000000000000000"&I(31 downto 28);

		--ALU 
		process (I)
		begin
			--if unsigned
			if (opcode = "1000" or opcode = "1001") then
				O <= std_logic_vector(unsigned(T0) + (unsigned(T1) * 10) + (unsigned(T2) * 100) + (unsigned(T3) * 1000) + 
											(unsigned(T4) * 10000) + (unsigned(T5) * 100000) + 
											(unsigned(T6) * 1000000) + (unsigned(T7) * 100000000));
			--if signed
			else 
				--if pos
				if T7 = "0000" then
					O <= std_logic_vector(unsigned(T0) + (unsigned(T1) * 10) + 
											(unsigned(T2) * 100) + (unsigned(T3) * 1000) + 
											(unsigned(T4) * 10000) + (unsigned(T5) * 100000) + 
											(unsigned(T6) * 1000000));
				--if neg
				else
					O <= not (std_logic_vector(unsigned(T0) + (unsigned(T1) * 10) + 
											(unsigned(T2) * 100) + (unsigned(T3) * 1000) + 
											(unsigned(T4) * 10000) + (unsigned(T5) * 100000) + 
											(unsigned(T6) * 1000000))) + 1;
				end if;
			end if;
	end process;	
end Behavioral;
