library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity STCAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
   	   cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end STCAM_Cell;

architecture Behavioral of STCAM_Cell is

signal FF: STD_LOGIC;
signal DFF: STD_LOGIC;

begin

	process(clk, rst, we, cell_search_bit, cell_dont_care_bit, cell_match_bit_in)

	begin

		--reset data most important
		if rst = '1' then
			FF <= '0';
			DFF <= '0';
			cell_match_bit_out <= '0';

		-- write data from search 
		elsif we = '1' then
			 FF <= cell_search_bit;
			 DFF <= cell_dont_care_bit;
			 cell_match_bit_out <= '0';

		--search
		--previous result is wrong therefore nothing matches
		elsif cell_match_bit_in = '0' then
			 cell_match_bit_out <= '0';
			 
		--previous result matches
		elsif cell_match_bit_in = '1' then
			--check if current cell is a dont care
			if DFF = '1' then
				cell_match_bit_out <= '1';
			--if cell is not a dont care
			else
				--check current cell if match
				if FF = cell_search_bit then
					cell_match_bit_out <= '1';
				else
					--current cell doesnt match 
					cell_match_bit_out <= '0';
				 end if;
			end if;
		end if;
		
	end process;
end Behavioral;