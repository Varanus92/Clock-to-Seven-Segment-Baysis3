--**********************************
--*7Segment *BAYSIS3* configuration*
--**********************************


--***OUTPUT :SINGLE SEGMENT***

--Please note: 
--Into "BCD_4BIT" you will choose at "BAYSIS_7SEGMENT_BLOCK.vhd what BCD digit of segment you want to output:
--   the  value of units digit,or the 4bit value of dosen digit the 
--"SINGLE_DIGIT_SEGMENT" is the first 7Segment digit from right
--"DOZEN_DIGIT_SEGMENT" is the second digit from the right after the one above
--*** The 7 bit number is the
--representation of the Hex number in 
--Basys3 7Segment,when "0=Cathod is ON"
--and "1=Cathod is OFF" 



library IEEE;
use IEEE.std_logic_1164.all;

entity BAYSIS3_BCD_2_7SEGMENT is
port
(
BCD_4BIT             :in  std_logic_vector(3 downto 0); 
SINGLE_DIGIT_SEGMENT :out std_logic_vector(6 downto 0)  --Every digit of 7SEGMENT consisted from 7 bit 
);
end BAYSIS3_BCD_2_7SEGMENT;

architecture BAYSIS3_BCD_2_7SEGMENT_ARC  of BAYSIS3_BCD_2_7SEGMENT is


begin



with BCD_4BIT select                         --The  ' x"value" ' is the 4bit BCD word
SINGLE_DIGIT_SEGMENT <= "0000001" when x"0",
	      	   "1001111" when x"1", -- "1"
			   "0010010" when x"2", -- "2" 
		       "0000110" when x"3", -- "3" 
			   "1001100" when x"4", -- "4" 
			   "0100100" when x"5", -- "5" 
			   "0100000" when x"6", -- "6" 
			   "0001111" when x"7", -- "7" 
			   "0000000" when x"8", -- "8" 
			   "0000100" when x"9", -- "9"	
               "XXXXXXX" when OTHERS;
			   
			   

end BAYSIS3_BCD_2_7SEGMENT_ARC;

