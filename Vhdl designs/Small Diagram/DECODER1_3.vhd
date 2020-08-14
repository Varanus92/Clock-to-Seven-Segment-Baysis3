--****************
--*1 TO 3 DECODER*
--****************


--
--This decoder allow in the top level design to "allow"
--wich siglal will be changed (the "SEL_SECONDS,MINUTES,HOURS" 
--will next used as clock enbale signals.



library IEEE;
use IEEE.std_logic_1164.all;

entity DECODER1_3 is
port
(
ADRS        				      :in  std_logic_vector(1 downto 0); 
SEL_SECONDS,SEL_MINUTES,SEL_HOURS :out std_logic  --Every digit of 7SEGMENT consisted from 7 bit 
);
end DECODER1_3;

architecture DECODER1_3_ARC  of DECODER1_3 is


begin

--Decoder:
SEL_SECONDS <= '1' when (ADRS = "00") else '0';
SEL_MINUTES <= '1' when (ADRS = "01") else '0';			   
SEL_HOURS   <= '1' when (ADRS = "10") else '0';			   

end DECODER1_3_ARC;

