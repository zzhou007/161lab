library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity control_unit is
  port (
    instr_op          : in std_logic_vector(5 downto 0);
    reg_dst           : out std_logic;
    branch            : out std_logic;
    mem_read          : out std_logic;
    mem_to_reg        : out std_logic;
    alu_op            : out std_logic_vector(1 downto 0);
    mem_write         : out std_logic;
    alu_src           : out std_logic;
    reg_write         : out std_logic
    );
end control_unit;
 
architecture Behavioral of control_unit is

begin
    process(instr_op) begin
        case instr_op is
            when "000000" =>
                reg_dst <= '1';
                alu_src <= '0';
                mem_to_reg <= '0';
                reg_write <= '1';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '0';
                alu_op <= "10";
            when "100011" =>
                reg_dst <= '0';
                alu_src <= '1';
                mem_to_reg <= '1';
                reg_write <= '1';
                mem_read <= '1';
                mem_write <= '0';
                branch <= '0';
                alu_op <= "00";
            when "101011" =>
                --reg_dst <= '0';
                alu_src <= '1';
                --mem_to_reg <= '1';
                reg_write <= '0';
                mem_read <= '0';
                mem_write <= '1';
                branch <= '0';
                alu_op <= "00";
            when "000100" =>
                --reg_dst <= '0';
                alu_src <= '0';
                --mem_to_reg <= '1';
                reg_write <= '0';
                mem_read <= '0';
                mem_write <= '0';
                branch <= '1';
                alu_op <= "01";
            when "001000" =>
            -- Add immediate
				reg_dst		<= '1';
				alu_src 		<= '1';
				mem_to_reg 	<= '0';
				reg_write 	<= '1';
				mem_read 	<= '0';
				mem_write 	<= '0';
				branch 		<= '0';
				alu_op 		<= "00";
            when others =>
        end case;
    end process;
end Behavioral; 
