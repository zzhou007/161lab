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
	signal test : std_logic_vector(67 downto 0);
	begin

		process(I, test)
			variable bcd : std_logic_vector(67 downto 0);
			

		begin
			if (opcode = "1100" or opcode = "1101") then
				if (I(NUMBITS - 1) /= '0') then
					bcd := "111111111111111111111111111111111111"&std_logic_vector(I);
					bcd := (not bcd) + 1;
				else
					bcd := "000000000000000000000000000000000000"&std_logic_vector(I);
				end if;
			end if;

			
			--if unsigned
			if (opcode = "1000" or opcode = "1001") then
				
				bcd := "000000000000000000000000000000000000"&std_logic_vector(I);
				for i1 in 0 to 31 loop  -- repeating 32 times.
					bcd(67 downto 1) := bcd(66 downto 0);  --shifting the bits.
					if(i1 < 31 and bcd(35 downto 32) > "0100") then --add 3 if BCD digit is greater than 4.
						bcd(35 downto 32) := bcd(35 downto 32) + "0011";
					end if;

					if(i1 < 31 and bcd(39 downto 36) > "0100") then --add 3 if BCD digit is greater than 4.
						bcd(39 downto 36) := bcd(39 downto 36) + "0011";
					end if;

					if(i1 < 31 and bcd(43 downto 40) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(43 downto 40) := bcd(43 downto 40) + "0011";
					end if;
					
					if(i1 < 31 and bcd(47 downto 44) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(47 downto 44) := bcd(47 downto 44) + "0011";
					end if;
					
					if(i1 < 31 and bcd(51 downto 48) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(51 downto 48) := bcd(51 downto 48) + "0011";
					end if;

					if(i1 < 31 and bcd(55 downto 52) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(55 downto 52) := bcd(55 downto 52) + "0011";
					end if;
					
					if(i1 < 31 and bcd(59 downto 56) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(59 downto 56) := bcd(59 downto 56) + "0011";
					end if;
					
					if(i1 < 31 and bcd(63 downto 60) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(63 downto 60) := bcd(63 downto 60) + "0011";
					end if;
					
					if(i1 < 31 and bcd(67 downto 64) > "0100") then  --add 3 if BCD digit is greater than 4.
						bcd(67 downto 64) := bcd(67 downto 64) + "0011";
					end if;
				
				end loop;
				O <= bcd(67 downto 32);
		--if signed
		else
			for i1 in 0 to 31 loop  -- repeating 32 times.
				bcd(67 downto 1) := bcd(66 downto 0);  --shifting the bits.
				if(i1 < 31 and bcd(35 downto 32) > "0100") then --add 3 if BCD digit is greater than 4.
					bcd(35 downto 32) := bcd(35 downto 32) + "0011";
				end if;

				if(i1 < 31 and bcd(39 downto 36) > "0100") then --add 3 if BCD digit is greater than 4.
					bcd(39 downto 36) := bcd(39 downto 36) + "0011";
				end if;

				if(i1 < 31 and bcd(43 downto 40) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(43 downto 40) := bcd(43 downto 40) + "0011";
				end if;
				
				if(i1 < 31 and bcd(47 downto 44) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(47 downto 44) := bcd(47 downto 44) + "0011";
				end if;
				
				if(i1 < 31 and bcd(51 downto 48) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(51 downto 48) := bcd(51 downto 48) + "0011";
				end if;

				if(i1 < 31 and bcd(55 downto 52) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(55 downto 52) := bcd(55 downto 52) + "0011";
				end if;
				
				if(i1 < 31 and bcd(59 downto 56) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(59 downto 56) := bcd(59 downto 56) + "0011";
				end if;
				
				if(i1 < 31 and bcd(63 downto 60) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(63 downto 60) := bcd(63 downto 60) + "0011";
				end if;
				
				if(i1 < 31 and bcd(67 downto 64) > "0100") then  --add 3 if BCD digit is greater than 4.
					bcd(67 downto 64) := bcd(67 downto 64) + "0011";
				end if;
				
			end loop;
				if (I(NUMBITS - 1) /= '0') then
					if bcd(63 downto 32) = 0 then
						o <= "0000"&bcd(63 downto 32);
					else
						O <= "0001"&bcd(63 downto 32);
					end if;
				else
					o <= "0000"&bcd(63 downto 32);
				end if;

		end if;	

		end process;


end Behavioral;
