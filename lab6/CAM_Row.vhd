library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CAM_Row is
	Generic (CAM_WIDTH : integer := 8) ;
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           row_match : out  STD_LOGIC);
end CAM_Row;

architecture Behavioral of CAM_Row is


component CAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
	   cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

for all: cam_cell use entity work.cam_cell(bcam);

signal last : std_logic_vector(CAM_WIDTH-1 downto 0);
signal x: integer := 0;

begin

One: if (x = 0) generate
begin

	F_CELL: CAM_Cell
	port map(clk, rst, we, search_word(0), dont_care_mask(0), '1', last(0));
		
end generate One;

Gen_Row : 

for x in 1 to (CAM_WIDTH-2) generate 

begin

	O_CELLS : CAM_Cell
	port map (clk, rst, we, search_word(x), dont_care_mask(x), last(x-1), last(x));
		
end generate Gen_Row;

Lst : if(true) generate 
begin

	L_CELL : CAM_Cell
	port map (clk, rst, we, search_word(CAM_WIDTH-1), dont_care_mask(CAM_WIDTH-1), last(CAM_WIDTH-2), row_match);

end generate Lst;


end Behavioral;