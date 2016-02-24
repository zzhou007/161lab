library ieee;
use ieee.std_logic_1164.all;
use work.cpu_component_library.all;
use IEEE.numeric_std.all;

-- this is entity
entity cs161_processor is
  port (
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
 
 --our processor 
architecture Behavioral of cs161_processor is
   --PC and IR
    signal pcout       : std_logic_vector(31 downto 0) := (others => '0');
    signal pcnew       : std_logic_vector(31 downto 0) := (others => '0');
    signal instrwordno : std_logic_vector(7 downto 0) := (others => '0');
    signal four : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";
   
    --Decoding
    signal instr                    : std_logic_vector(31 downto 0);
    signal imm16                : std_logic_vector(15 downto 0);
    signal funct                : std_logic_vector(5 downto 0);
   
    --Memory
   signal data_address         : std_logic_vector(7 downto 0);
   signal data_write_data      : std_logic_vector(31 downto 0);
   signal data_read_data       : std_logic_vector(31 downto 0);

    signal opCode                      : std_logic_vector(5 downto 0) := (others => '0');
    signal rsnum                      : std_logic_vector(4 downto 0) := (others => '0');
    signal rtnum                      : std_logic_vector(4 downto 0) := (others => '0');
    signal rdnum                      : std_logic_vector(4 downto 0) := (others => '0');
    signal writeregnum             : std_logic_vector(4 downto 0) := (others => '0');
    signal writeregdata              : std_logic_vector(31 downto 0) := (others => '0');

    -- Control Unit
    signal muxRegDst : std_logic;
    signal muxAluSrc : std_logic;
    signal muxMemReg : std_logic;
    signal regWrite  : std_logic;
    signal memRead   : std_logic;
    signal memWrite  : std_logic;
    signal branch    : std_logic;
    signal aluOp     : std_logic_vector(1 downto 0) := (others => '0');


    --Registers
    signal regRead1    : std_logic_vector(31 downto 0) := (others => '0');
    signal regRead2    : std_logic_vector(31 downto 0) := (others => '0');

    --Sign Extending
    signal signExtend32 : std_logic_vector(31 downto 0) := (others => '0');

    --Alu
    signal aluControl : std_logic_vector(3 downto 0) := (others => '0');
    signal aluReadA : std_logic_vector(31 downto 0) := (others => '0');
    signal aluReadB : std_logic_vector(31 downto 0) := (others => '0');
    signal aluZero  : std_logic;
    signal aluResult : std_logic_vector(31 downto 0) := (others => '0');

    --Memory
    signal dataRead : std_logic_vector(31 downto 0) := (others => '0');
   
    --signal andBranchZero : std_logic;

begin

        --IR
        InstructionRegister: generic_register
          generic map (32)
          port map (
             clk => clk,
             rst => rst,
             write_en => '1',
             data_in => pcnew,
             data_out => pcout);
  
   
        instrwordno <= pcout(9 downto 2);


     -- Fetch
        SplitMemory: memory
        port map (
                clk => clk,
            rst => rst,
            instr_read_address => instrwordno,
            instr_instruction => instr,
            data_mem_write => memWrite,
            data_address => aluResult(7 downto 0),
            data_write_data => writeregdata,
            data_read_data => dataRead);
     
   
     opCode <= instr(31 downto 26);
  
   
    -- Decoding
    rsnum <= instr(25 downto 21);
    rtnum <= instr(20 downto 16);
    rdnum <= instr(15 downto 11);
    funct <= instr(5 downto 0);
    imm16 <= instr(15 downto 0);
  
    -- Control Unit
    CONTROLLER: control_unit
        port map (opCode, muxRegDst,branch,memRead,muxMemReg,aluOp,memWrite,muxAluSrc,regWrite);
  
    RDMUX: mux_2_1
        generic map(5)
        port map(muxRegDst,rtnum,rdnum,writeregnum);
           
    Registers: cpu_registers
        port map(clk,rst,regWrite,rsnum,rtnum,writeregnum,
          writeregdata,regRead1,regRead2);
 
    --sign extend the immediate
    signExtend32(31 downto 16) <= (others => imm16(15));
    signExtend32(15 downto 0) <= imm16(15 downto 0);
 
    ALUS2MUX: mux_2_1
        generic map(32)
        port map(muxAluSrc,regRead2,signExtend32,aluReadB); 
 
    
    WriteBackMUX: mux_2_1
        generic map(32)
        port map(muxMemReg,aluResult,dataRead,writeregdata);
 
 
    ALUControlUnit: alu_control
        port map(aluOp,funct,aluControl);
 
 
    ALUnit: alu
        port map(aluControl,aluReadA,aluReadB, aluZero,aluResult);
 
    aluZero <= branch and aluZero;
    
    PCMUX: mux_2_1
    generic map (32)
     port map (
     select_in => aluZero,
    data_0_in => std_logic_vector(unsigned(pcout) + unsigned(four)),
    data_1_in => std_logic_vector(unsigned(pcout) + unsigned(four) + unsigned(signExtend32(29 downto 0) & "00")),
    data_out  => pcnew
	 );
      
    prog_count <= pcnew;
    instr_opcode <= opCode;
    reg1_addr <= rsnum;
    reg1_data <= regRead1;
    reg2_addr <= rtnum;
    reg2_data <= regRead2;
    write_reg_addr <= writeregnum;
    write_reg_data <= writeregdata;
  
  --maybe compile
end Behavioral;
