library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bcd_bin is
generic(NUMBITS : natural := 32);
    Port ( I : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);	
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
	signal TBIN: std_logic_vector (NUMBITS downto 0);

	begin

		T0 <= I(3 downto 0);
		T1 <= I(7 downto 4);
		T2 <= I(11 downto 8);
		T3 <= I(15 downto 12);
		T4 <= I(19 downto 16);
		T5 <= I(23 downto 20);
		T6 <= I(27 downto 24);
		T7 <= I(31 downto 28);

		--ALU 
		process (I)
		begin
		O <= std_logic_vector(unsigned(T0) + (unsigned(T1) * 10) + 
										(unsigned(T2) * 100) + (unsigned(T3) * 1000) + 
										(unsigned(T4) * 10000) + (unsigned(T5) * 100000) + 
										(unsigned(T6) * 1000000) + (unsigned(T7) * 100000000));
	end process;	
end Behavioral;
