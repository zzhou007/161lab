library IEEE;
use IEEE.STD_LOGIC_1164.all;

package cpu_constant_library is

  -- opcodes
  constant OPCODE_R_TYPE       : std_logic_vector(5 downto 0)   := (others => '0'); 
  constant OPCODE_LOAD_WORD    : std_logic_vector(5 downto 0)   := (others => '0'); 
  constant OPCODE_STORE_WORD   : std_logic_vector(5 downto 0)   := (others => '0'); 
  constant OPCODE_BRANCH_EQ    : std_logic_vector(5 downto 0)   := (others => '0'); 
  
  -- funct
  constant FUNCT_AND           : std_logic_vector(5 downto 0)   := (others => '0'); 
  constant FUNCT_OR            : std_logic_vector(5 downto 0)   := (others => '0'); 

  -- ALU signals
  constant ALU_AND             : std_logic_vector(3 downto 0)   := (others => '0'); 
  constant ALU_OR              : std_logic_vector(3 downto 0)   := (others => '0'); 

end cpu_constant_library;

package body cpu_constant_library is 
end cpu_constant_library;
