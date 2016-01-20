library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

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

