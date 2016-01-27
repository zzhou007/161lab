library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity bin_bcd is
generic(NUMBITS : natural := 32);
    Port ( I : in  STD_LOGIC_VECTOR(NUMBITS - 1 downto 0);	
			  opcode : in STD_LOGIC_VECTOR (3 downto 0);
           O : out  STD_LOGIC_VECTOR(NUMBITS + 3 downto 0));
end bin_bcd;




architecture Behavioral of bin_bcd is

	begin
	
		process(I)
			variable i1 : integer:=0;
			variable bcd : std_logic_vector(35 downto 0) := (others => '0');
			variable bint : std_logic_vector(31 downto 0) := std_logic_vector(I);

		begin
			for i1 in 0 to 31 loop  -- repeating 8 times.
				bcd(35 downto 1) := bcd(34 downto 0);  --shifting the bits.
				bcd(0) := bint(31);
				bint(31 downto 1) := bint(30 downto 0);
				bint(0) :='0';


				if(i1 < 31 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
					bcd(3 downto 0) := bcd(3 downto 0) + "0011";
				end if;

				if(i1 < 31 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
					bcd(7 downto 4) := bcd(7 downto 4) + "0011";
				end if;

				if(i1 < 31 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(11 downto 8) := bcd(11 downto 8) + "0011";
				end if;
				
				if(i1 < 31 and bcd(15 downto 12) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(15 downto 12) := bcd(15 downto 12) + "0011";
				end if;
				
				if(i1 < 31 and bcd(19 downto 16) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(19 downto 16) := bcd(19 downto 16) + "0011";
				end if;

				if(i1 < 31 and bcd(23 downto 20) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(23 downto 20) := bcd(23 downto 20) + "0011";
				end if;
				
				if(i1 < 31 and bcd(27 downto 24) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(27 downto 24) := bcd(27 downto 24) + "0011";
				end if;
				
				if(i1 < 31 and bcd(31 downto 28) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(31 downto 28) := bcd(31 downto 28) + "0011";
				end if;
				
				if(i1 < 31 and bcd(35 downto 31) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(35 downto 31) := bcd(35 downto 31) + "0011";
				end if;

			end loop;
			
			O <= bcd;
			
		end process;


end Behavioral;
