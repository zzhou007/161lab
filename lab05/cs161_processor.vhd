library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use work.cpu_component_library.all;

entity cs161_processor is
  port (
  
    clk            : in std_logic;
    rst            : in std_logic;
    prog_count     : out std_logic_vector(31 downto 0);
    instr_opcode   : out std_logic_vector(5 downto 0);
    reg1_addr      : out std_logic_vector(4 downto 0);
    reg1_data      : out std_logic_vector(31 downto 0);
    reg2_addr      : out std_logic_vector(4 downto 0);
    reg2_data      : out std_logic_vector(31 downto 0);
    write_reg_addr : out std_logic_vector(4 downto 0);
    write_reg_data : out std_logic_vector(31 downto 0)
    );
end cs161_processor;

architecture Behavioral of cs161_processor is

	signal ctrlbr			:std_logic := '0';
	signal aluop			:std_logic_vector(1 downto 0) := (others => '0');
	signal aluout			:std_logic_vector(3 downto 0) := (others => '0');
	signal aluResult 		:std_logic_vector(31 downto 0) := (others => '0');
	signal aluzero			:std_logic := '0';
	signal earth 			:std_logic := '0';
	signal talumux			:std_logic_vector(31 downto 0) := (others => '0');
	signal tpcmux			:std_logic := '0';
	signal tpcmux0			:std_logic_vector(7 downto 0) := (others => '0');
	signal tpcmux1			:std_logic_vector(7 downto 0) := (others => '0');
	signal tdataadr 		:std_logic_vector(7 downto 0) := (others => '0');
	signal pcout 			:std_logic_vector(7 downto 0) :=(others => '0');
	signal memory_out 	:std_logic_vector(31 downto 0) :=(others => '0'); 
	signal memRead 		:std_logic_vector(31 downto 0) := (others => '0');
	signal memWrite 		:std_logic_vector(31 downto 0) := (others => '0');
	signal pcnew 			:std_logic_vector(7 downto 0) :=(others => '0');
	signal muxreg 			:std_logic_vector(4 downto 0) := (others => '0');
	signal muxdat 			:std_logic_vector (31 downto 0) := (others => '0');
	signal aluReadB 		:std_logic_vector (31 downto 0) := (others => '0');
	signal aluReadA		:std_logic_vector (31 downto 0) := (others => '0');
	signal regread2		:std_logic_vector (31 downto 0) := (others => '0');
	signal ctrlw 			:std_logic := '0';
	signal ctrlrw			:std_logic := '0';
	signal ctrlrd 			:std_logic := '0';
	signal m2r  			:std_logic := '0';
	signal alusrc			:std_logic := '0';

begin
   reg2_addr      <= memory_out(20 downto 16);
   reg2_data      <= regread2;
   write_reg_addr <= muxreg;
   write_reg_data <= muxdat;
	prog_count 		<= std_logic_vector( resize(unsigned(pcout) sll 2, prog_count'length));
	instr_opcode 	<= memory_out(31 downto 26);
	reg1_addr      <= memory_out(25 downto 21);
   reg1_data      <= aluReadA;
	
	--IR
	InstructionRegister : generic_register
		generic map (SIZE => 8)
		port map (
			clk			=>	clk, 
			rst			=> rst,  
			write_en		=> '1', 
			data_in		=> pcnew, 
			data_out		=> pcout
			);
			
	--Fetch
	SplitMemory : memory
		generic map ( COE_FILE_NAME => "init.coe")
		port map(
			clk 						=> clk,
			rst  						=> rst,
			instr_read_address   => pcout, 
			instr_instruction    => memory_out, 	 
			data_mem_write       => ctrlw,
			data_address         => aluResult(7 downto 0), 
			data_write_data      => regread2,
			data_read_data       => memRead
			);
	
	-- Control Unit
	CONTROLLER: control_unit
		port map(
			instr_op					=> memory_out(31 downto 26),
			reg_dst					=> ctrlrd,
			branch					=> ctrlbr,
			MEM_read					=> earth, 
			mem_to_reg				=> m2r,
			alu_op					=> aluop,
			MEM_write				=> ctrlw,
			alu_src					=> alusrc,
			reg_write				=> ctrlrw
			);
		
	Registers : cpu_registers
			clk						=> clk,
		port map(
			rst						=> rst,
			reg_write				=> ctrlrw,
			read_register_1		=> memory_out(25 downto 21),
			read_register_2   	=> memory_out(20 downto 16),
			write_register			=> muxreg,
			write_data				=> muxdat,
			read_data_1				=> aluReadA,
			read_data_2				=> regread2
			);
	 
	REG_MUX_1 : mux_2_1 
		generic map (SIZE => 5)
		port map(ctrlrd, memory_out(20 downto 16), memory_out(15 downto 11), muxreg);
	 
	REG_MUX_2 : mux_2_1
		generic map (SIZE => 32)
		port map(m2r, aluResult, memRead, muxdat);

	ALU_MUX : mux_2_1 
		generic map (SIZE => 32)
		port map(alusrc, regread2, talumux, aluReadB);

	ALUControlUnit : alu_control
		port map(aluop, memory_out(5 downto 0), aluout);

	ALUnit: alu 
		port map(aluout, aluReadA, aluReadB, aluzero, aluResult);
			
	PCMUX : mux_2_1
		generic map (SIZE => 8)
		port map(tpcmux, tpcmux0, tpcmux1, pcnew);
			
	talumux	<= std_logic_vector(resize(signed(memory_out(15 downto 0)), aluReadB'length));
	tpcmux	<= (ctrlbr and aluzero);
	tpcmux0	<= std_logic_vector(unsigned(pcout) + 1);
	tpcmux1	<= std_logic_vector(unsigned( resize(signed(memory_out(15 downto 0)), pcnew'length)) + unsigned(pcout) + 1);

end Behavioral;
