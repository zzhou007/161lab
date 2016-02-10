library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.cpu_constant_library.all;

entity alu_control is
  port (
    alu_op            : in std_logic_vector(1 downto 0);
    instruction_5_0   : in std_logic_vector(5 downto 0);
    alu_out           : out std_logic_vector(3 downto 0)
    );
end alu_control;

architecture Behavioral of alu_control is

begin
	process (alu_op, instruction_5_0)
	begin
		case alu_op is 
			when "00" => --lw and sw
				alu_out <= "0010";
		
			when "01" => --branch
				alu_out <= "0110";
		
			when "10" => --r type
				case instruction_5_0 is
					when "100000" => --add
						alu_out <= "0010";
					when "100010" => --sub
						alu_out <= "0110";
					when "100100" => --AND
						alu_out <= "0000";
					when "100101" => --OR
						alu_out <= "0001";
					when "101010" => --slt
						alu_out <= "0111";
					when others => --bad input
						alu_out <= "0000";
				end case;
			when others => --bad input
				alu_out <= "0000";
			end case;
		end process;
end Behavioral;
