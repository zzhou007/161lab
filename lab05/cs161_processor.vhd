library ieee;
use ieee.std_logic_1164.all;
use work.cpu_component_library.all;
use ieee.numeric_std.all;

entity datapath is

generic
(
    SIZE           : natural   := 32
);
port (
		our_clk : in std_logic;
		our_rst : in std_logic;
		
		-- from cu
		reg_dst_dp : in std_logic;
		branch_dp : in std_logic;
		mem_read_dp : in std_logic;
		mem_to_reg_dp : in std_logic;
		alu_op_dp : in std_logic_vector(1 downto 0);
		mem_write_dp : in std_logic;
		alu_src_dp : in std_logic;
		reg_write_dp : in std_logic;
		--instruction : out std_logic_vector(SIZE-1 downto 0);
		instr_op_dp : out std_logic_vector(5 downto 0);
		instr_fn_dp : out std_logic_vector(5 downto 0);
		
		-- from alu cu
		alu_out_dp : in std_logic_vector(3 downto 0)
		);
		
end datapath;

architecture Behavioral2 of datapath is

-- Pc signals
signal write_en_dp : std_logic;
signal PC_mux_out : std_logic_vector(SIZE-1 downto 0);
signal PC_data_out :  std_logic_vector(SIZE-1 downto 0);

-- pc mux signals
signal next_instruction : std_logic_vector(SIZE-1 downto 0);
signal branch_instruction : std_logic_vector(SIZE-1 downto 0);
signal br_and_out : std_logic;

-- br adder signals
signal branch_offset : std_logic_vector(SIZE-1 downto 0);

-- i_mem signals
signal instruction : std_logic_vector(31 downto 0);

-- rf mux signals
signal rf_mux_out : std_logic_vector(SIZE-1 downto 0);

-- rf signals
signal rf_out_1 : std_logic_vector(SIZE-1 downto 0);
signal rf_out_2 : std_logic_vector(SIZE-1 downto 0);

-- dmem mux signals
signal dmem_mux_out : std_logic_vector(SIZE-1 downto 0);

-- alu mux signals
signal alu_mux_out : std_logic_vector(SIZE-1 downto 0);

-- main alu signals
signal zero_sig : std_logic;
signal zero_sig_adder : std_logic;
signal zero_sig_br_adder : std_logic;
signal zero_sig_shifter : std_logic;
signal zero_sig_main_alu : std_logic;

signal alu_result : std_logic_vector(SIZE-1 downto 0);

-- dmem signals
signal dmem_out : std_logic_vector(SIZE-1 downto 0);

signal and_out : std_logic;


component generic_register
  generic 
  (
    SIZE        : natural   := 32
  );
  port 
  (
  
    clk         : in std_logic;
    rst         : in std_logic;
    write_en    : in std_logic;
    data_in     : in std_logic_vector(SIZE-1 downto 0);
    data_out    : out std_logic_vector(SIZE-1 downto 0)
	 
  );
end component;

component mux_2_1 is
  generic
  (
		SIZE           : natural   := 32
  );
  
  port 
  (
		 select_in      : in std_logic;
		 data_0_in      : in std_logic_vector(SIZE-1 downto 0);
		 data_1_in      : in std_logic_vector(SIZE-1 downto 0);
		 data_out       : out std_logic_vector(SIZE-1 downto 0)
  );
end component;

component alu is
  port 
  (
		alu_control_in : in std_logic_vector(3 downto 0);
		channel_a_in   : in std_logic_vector(31 downto 0);
		channel_b_in   : in std_logic_vector(31 downto 0);
		zero_out       : out std_logic;
		alu_result_out : out std_logic_vector(31 downto 0)
  );
end component;

component cpu_registers is
  port 
  (
  
		clk					: in std_logic;
		rst               : in std_logic;
		reg_write         : in std_logic;
		read_register_1   : in std_logic_vector(4 downto 0);
		read_register_2   : in std_logic_vector(4 downto 0);
		write_register    : in std_logic_vector(4 downto 0);
		write_data        : in std_logic_vector(31 downto 0);
		read_data_1       : out std_logic_vector(31 downto 0);
		read_data_2       : out std_logic_vector(31 downto 0)
		
  );
end component;

component memory is
  generic 
  (
		COE_FILE_NAME        : string   := "init.coe"
  );
  port 
  (
  
	 clk						 : in std_logic;
    rst                  : in std_logic;
    instr_read_address   : in std_logic_vector(7 downto 0);
    instr_instruction    : out std_logic_vector(31 downto 0);
    data_mem_write       : in std_logic;
    data_address         : in std_logic_vector(7 downto 0);
    data_write_data      : in std_logic_vector(31 downto 0);
    data_read_data       : out std_logic_vector(31 downto 0)
	 
   );
end component;


-- sign extended signals
signal s_extended : std_logic_vector(SIZE-1 downto 0);
signal rf_mux_in_0_ex: std_logic_vector(SIZE-1 downto 0);
signal rf_mux_in_1_ex: std_logic_vector(SIZE-1 downto 0);

begin
and_out 			<= zero_sig and branch_dp;
s_extended 		<= (x"0000" & instruction(15 downto 0)) when instruction(15) = '0' 
					else (x"FFFF" & instruction(15 downto 0)) when instruction(15) = '1';
rf_mux_in_0_ex <= "000000000000000000000000000" & instruction(20 downto 16);
rf_mux_in_1_ex <= "000000000000000000000000000" & instruction(15 downto 11);


PC_mux : mux_2_1 port map
( 

	select_in 	=> and_out, 
	data_0_in 	=> next_instruction,
	data_1_in 	=> branch_instruction,
	data_out 	=> PC_mux_out 
	
);
	  

PC : generic_register port map
( 

	clk 		=> our_clk,
	rst 		=> our_rst,
	write_en => write_en_dp,
	data_in 	=> PC_mux_out,
	data_out => PC_data_out 
	
);
	  
PC_adder : alu port map
( 

	alu_control_in => "0010", 
	channel_a_in 	=> x"00000004",
	channel_b_in 	=> PC_data_out,
	zero_out 		=> zero_sig_adder,
	alu_result_out => next_instruction 
	
);
	  
BR_adder : alu port map
( 

	alu_control_in => "0010", -- always add
	channel_a_in 	=> next_instruction,
	channel_b_in 	=> branch_offset,
	zero_out 		=> zero_sig_br_adder,
	alu_result_out => branch_instruction 
	
);
	 
Shifter : alu port map
( 

	alu_control_in 	=> "0111",
	channel_a_in 		=> x"00000002",
	channel_b_in 		=> s_extended,
	zero_out 			=> zero_sig_shifter,
	alu_result_out 	=> branch_offset 
	
);
	  
mem : memory port map
( 

	clk 						=> our_clk,
	rst 						=> our_rst,
	instr_read_address 	=> PC_data_out(9 downto 2),
	instr_instruction 	=> instruction,
	data_mem_write 		=> mem_write_dp,
	data_address 			=> alu_result(9 downto 2),
	data_write_data 		=> rf_out_2,
	data_read_data 		=> dmem_out 
	
);
		
RF_mux : mux_2_1 port map
( 

	select_in => reg_dst_dp,
	data_0_in => rf_mux_in_0_ex,
	data_1_in => rf_mux_in_1_ex,
	data_out => rf_mux_out 
	
);
	  
RF : cpu_registers port map
( 

	clk => our_clk,
	rst => our_rst,
	reg_write => reg_write_dp,
	read_register_1 => instruction(25 downto 21),
	read_register_2 => instruction(20 downto 16),
	write_register => rf_mux_out(4 downto 0), -- write_reg wants 5, and rf_mux_out is 32
	write_data => dmem_mux_out,
	read_data_1 => rf_out_1,
	read_data_2 => rf_out_2 
	
); 
		
alu_mux : mux_2_1 port map
( 

	select_in 	=> alu_src_dp,
	data_0_in 	=> rf_out_2,
	data_1_in 	=> s_extended,
	data_out 	=> alu_mux_out 
	
);
	  
main_alu : alu port map
( 

	alu_control_in 	=> alu_out_dp,
	channel_a_in 		=> rf_out_1,
	channel_b_in	 	=> alu_mux_out,
	zero_out 			=> zero_sig_main_alu,
	alu_result_out 	=> alu_result 
	
);
		
dmem_mux : mux_2_1 port map
( 

	select_in 	=> mem_to_reg_dp,
	data_0_in 	=> alu_result,
	data_1_in 	=> dmem_out,
	data_out 	=> dmem_mux_out 
	
);
	  
instr_op_dp <= instruction(31 downto 26); -- assign first 6 bits to the opcode
instr_fn_dp <= instruction(5 downto 0); -- last 6 bits are function

end Behavioral2;		
		
library ieee;
use ieee.std_logic_1164.all;
use work.cpu_component_library.all;
		
entity cs161_processor is
  port 
  (
  
		clk            : in std_logic;
		rst            : in std_logic;

		-- Debug Signals
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

-- control unit signals
signal reg_dst_161p 				: std_logic;
signal branch_161p 				: std_logic;
signal mem_read_161p 			: std_logic;
signal mem_to_reg_161p 			: std_logic;
signal alu_op_161p 				: std_logic_vector(1 downto 0);
signal mem_write_161p 			: std_logic;
signal alu_src_161p 				: std_logic;
signal reg_write_161p 			: std_logic;
signal instr_op_161p 			: std_logic_vector(5 downto 0); --opcode 
signal instr_fn_161p 			: std_logic_vector(5 downto 0);
-- alu signals
signal alu_out_161p 				: std_logic_vector(3 downto 0);
signal instruction_5_0_161p 	: std_logic_vector(5 downto 0); --  function

-- datapath signals
signal instruction_161p  : std_logic_vector(5 downto 0);

component control_unit
  port 
  (
  
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
end component;

component alu_control
  port 
(

    alu_op            : in std_logic_vector(1 downto 0);
    instruction_5_0   : in std_logic_vector(5 downto 0);
    alu_out           : out std_logic_vector(3 downto 0)
	 
);
end component;



component datapath
generic
(

	SIZE           : natural   := 32
	
);
port 
(

	our_clk 			: in std_logic;
	our_rst 			: in std_logic;
	reg_dst_dp 		: in std_logic;
	branch_dp 		: in std_logic;
	mem_read_dp 	: in std_logic;
	mem_to_reg_dp 	: in std_logic;
	alu_op_dp 		: in std_logic_vector(1 downto 0);
	mem_write_dp 	: in std_logic;
	alu_src_dp 		: in std_logic;
	reg_write_dp 	: in std_logic;
	alu_out_dp 		: in std_logic_vector(3 downto 0);
	instr_op_dp 	: out std_logic_vector(5 downto 0);
	instr_fn_dp 	: out std_logic_vector(5 downto 0)
	--instruction  : out std_logic_vector(SIZE-1 downto 0)
	
);
end component;


begin

CU : control_unit port map
( 

	instr_op 	=> instr_op_161p,
	reg_dst 		=> reg_dst_161p,
	branch 		=> branch_161p,
	mem_read 	=> mem_read_161p,
	mem_to_reg 	=> mem_to_reg_161p,
	alu_op 		=> alu_op_161p,
	mem_write 	=> mem_write_161p,
	alu_src 		=> alu_src_161p,
	reg_write 	=> reg_write_161p 
	
);
	  
ALU_CU : alu_control port map
( 

	alu_out 			=> alu_out_161p,
	alu_op 				=> alu_op_161p,       
	instruction_5_0 	=> instr_fn_161p
	
);
	
DP : datapath port map
( 

	our_clk 	 			=> clk,
	our_rst 	 			=> rst,
	reg_dst_dp 			=> reg_dst_161p,
	branch_dp  			=> branch_161p,
	mem_read_dp   		=> mem_read_161p,
	mem_to_reg_dp 		=> mem_to_reg_161p,
	alu_op_dp 			=> alu_op_161p,
	mem_write_dp 		=> mem_write_161p,
	alu_src_dp 			=> alu_src_161p,
	reg_write_dp 		=> reg_write_161p,
	alu_out_dp 			=> alu_out_161p,
	instr_op_dp 		=> instr_op_161p,
	instr_fn_dp 		=> instr_fn_161p
	
 );


end Behavioral;
