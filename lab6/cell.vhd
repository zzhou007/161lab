library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cam_cell is

    Port  (clk 					: in  STD_LOGIC;
           rst 					: in  STD_LOGIC;
           we 						: in  STD_LOGIC;
           cell_search_bit 	: in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in 	: in  STD_LOGIC;
           cell_match_bit_out : out  STD_LOGIC);
			  
end cam_cell;


---------------------------------
-- BCAM -------------------------
---------------------------------

architecture bcam of cam_cell is

signal FF: STD_LOGIC;

begin

	process(clk, rst, we, cell_search_bit, cell_dont_care_bit, cell_match_bit_in)

	begin

		--reset data most important
		if rst = '1' then
			FF <= '0';
			cell_match_bit_out <= '0';

		-- write data from search 
		elsif we = '1' then
			 FF <= cell_search_bit;
			 cell_match_bit_out <= '0';

		--search
		--previous result is wrong therefore nothing matches
		elsif cell_match_bit_in = '0' then
			 cell_match_bit_out <= '0';
			 
		--previous result matches
		elsif cell_match_bit_in = '1' then
			--check current cell if match
			if FF = cell_search_bit then
				cell_match_bit_out <= '1';
			else
				--current cell doesnt match 
				cell_match_bit_out <= '0';
			 end if;
		end if;
		
	end process;
end bcam ;

------------------------------
---TCAM-----------------------
------------------------------

architecture tcam of cam_cell is

signal FF: STD_LOGIC;

begin

	process(clk, rst, we, cell_search_bit, cell_dont_care_bit, cell_match_bit_in)

	begin

		--reset data most important
		if rst = '1' then
			FF <= '0';
			cell_match_bit_out <= '0';

		-- write data from search 
		elsif we = '1' then
			 FF <= cell_search_bit;
			 cell_match_bit_out <= '0';

		--search
		--previous result is wrong therefore nothing matches
		elsif cell_match_bit_in = '0' then
			 cell_match_bit_out <= '0';
			 
		--previous result matches
		elsif cell_match_bit_in = '1' then
			--check if search input is dont care
			if cell_dont_care_bit = '1' then
				cell_match_bit_out <= '1';
			--if search is not a dont care
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
end tcam;

-------------------------------------
--STCAM------------------------------
-------------------------------------


architecture stcam of cam_cell is

signal FF: STD_LOGIC;

begin

	process(clk, rst, we, cell_search_bit, cell_dont_care_bit, cell_match_bit_in)

	begin

		--reset data most important
		if rst = '1' then
			FF <= '0';
			cell_match_bit_out <= '0';

		-- write data from search 
		elsif we = '1' then
			 FF <= cell_search_bit;
			 cell_match_bit_out <= '0';

		--search
		--previous result is wrong therefore nothing matches
		elsif cell_match_bit_in = '0' then
			 cell_match_bit_out <= '0';
			 
		--previous result matches
		elsif cell_match_bit_in = '1' then
			--check if search input is dont care
			if cell_dont_care_bit = '1' then
				cell_match_bit_out <= '1';
			--if search is not a dont care
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
end stcam;
