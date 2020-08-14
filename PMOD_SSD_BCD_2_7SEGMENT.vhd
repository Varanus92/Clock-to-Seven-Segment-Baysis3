--  ********************************
--  *7Segment *PMODSSD* CONFIGURATION*
--  ********************************

--***OUTPUT :SINGLE SEGMENT***

--Please note: 
--Into "BCD_4BIT" you will choose at "PMOD_SSD_7SEGMENT_BLOCK.vhd what BCD digit of segment you want to output:
--   the  value of units digit,or the 4bit value of dosen digit the 
--
--*** The 7 bit number is the
--representation of the Hex number in 
--Basys3 7Segment,when "0=ANOD is OFF"
--and "1=ANODE is ON" 

library IEEE;
use IEEE.std_logic_1164.all;

entity PMOD_SSD_BCD_2_7SEGMENT is
port
(
BCD_4BIT             :in  std_logic_vector(3 downto 0); 
SINGLE_DIGIT_SEGMENT :out std_logic_vector(6 downto 0)  --Every digit of 7SEGMENT consisted from 7 bit 
);
end PMOD_SSD_BCD_2_7SEGMENT;

architecture PMOD_SSD_BCD_2_7SEGMENT_ARC  of PMOD_SSD_BCD_2_7SEGMENT is


begin


with BCD_4BIT select   --right digit of 7Segment
SINGLE_DIGIT_SEGMENT<= "1111110" when x"0",
					   "0110000" when x"1", -- "1"
					   "1101101" when x"2", -- "2" 
					   "1111001" when x"3", -- "3" 
					   "0110011" when x"4", -- "4" 
					   "1011011" when x"5", -- "5" 
					   "1011111" when x"6", -- "6" 
					   "1110000" when x"7", -- "7" 
					   "1111111" when x"8", -- "8" 
					   "1111011" when x"9", -- "9"	
					   "XXXXXXX" when OTHERS;
					   

   
end PMOD_SSD_BCD_2_7SEGMENT_ARC;

