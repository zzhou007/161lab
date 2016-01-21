library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin_bcd is
generic(NUMBITS : natural := 32);
    Port ( I : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);	
			  opcode : in STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);
end bcd_bin;

architecture Behavioral of bin_bcd is

