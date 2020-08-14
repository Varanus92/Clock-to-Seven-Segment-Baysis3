-- This COMPONENT represent full content of the ENTIRE BLOCK of 
-- PMODSSD_7SEGMENT_BLOCK  as shown in "Lab4 Top level Degidn"
-- TO make this Design more ease - i will refer it as  ANOTHER TOP LEVEL 
--
-- so now the hirarcy is:
-- MASTER TOP LEVEL : TOP_LEVEL.VHD
-- SECOND TOP LEVEL : LAB3.vhd,  BAYSIS3_7SEGMENT_BLOCK.VHD,  PMODSSD_7SEGMENT_BLOCK.VHD 
-- THIRD  TOP LEVEL : all the components

--
-- The Design COMPONENTS:
-- 1xCONTACTATORS 
-- 1xBIN2BCD 	  
-- 2xBCD2SEG      (units,dozens)   
-- 2xMUX2_1
-- COUNTER

library IEEE;
use IEEE.std_logic_1164.all;

entity PMOD_SSD_7SEGMENT_BLOCK is
port(
Q_HOURS  		     :in std_logic_vector(4 downto 0);
TESTMOOD   		     :in std_logic;
CLK        		     :in std_logic;
RESET	         	 :in std_logic;
SEGMENTS_OUT_PMOD_SSD:out std_logic_vector(6 downto 0);
CATHODS_OUT_PMOD_SSD  :out std_logic--_vector(3 downto 0)
);
end PMOD_SSD_7SEGMENT_BLOCK;

architecture PMOD_SSD_7SEGMENT_BLOCK_ARC of PMOD_SSD_7SEGMENT_BLOCK is--1


component CONTACTOR_2BIT_MSB
port(
VALUE_6BIT   : in  std_logic_vector (5 downto 0);
VALUE_8BIT   : out std_logic_vector (7 downto 0)
);
end component;


--2
component BIN2BCD
port(
COUNTER_IN: in  std_logic_vector(7 downto 0);
BCD_OUT   : out std_logic_vector(7 downto 0)
);
end component;


--3
component PMOD_SSD_BCD_2_7SEGMENT
port(
BCD_4BIT             :in  std_logic_vector(3 downto 0); 
SINGLE_DIGIT_SEGMENT :out std_logic_vector(6 downto 0)  --Every digit of 7SEGMENT consisted from 7 bit 
);
end component;

--4
component MUX2_1
port(
SEL:in  std_logic;
IN0:in  std_logic_vector(6 downto 0);
IN1:in  std_logic_vector(6 downto 0);
OT :out std_logic_vector(6 downto 0)
);
end component;





--5
component PMOD_COUNTER  
port(
RESET       :in std_logic;
CLK         :in std_logic;
TESTMOOD    :in std_logic;
PMOD_COUNTER_OUT:out std_logic
);
end component;






signal HOURS_6BIT       	     :std_logic_vector(5 downto 0);
signal HOURS_8BIT         		 :std_logic_vector(7 downto 0);
signal BIN2BCD_OUT_HR     		 :std_logic_vector(7 downto 0);
signal BCD_HR_4BIT_UNITS  		 :std_logic_vector(3 downto 0);
signal BCD_HR_4BIT_DOZENS 		 :std_logic_vector(3 downto 0);
signal UNITS_SEGMENT_HR   		 :std_logic_vector(6 downto 0);
signal DOZENS_SEGMENT_HR		 :std_logic_vector(6 downto 0);
signal CATHOD0            		 :std_logic_vector(6 downto 0); 
signal CATHOD1           		 :std_logic_vector(6 downto 0);
signal S_MUX_CATHODS_OUT_PMOD_SSD:std_logic_vector(6 downto 0);
signal COUNTER_OUT                      :std_logic;
--signal S_SELECT_MUX_CATHODS      :std_logic;

begin 




------------------------ 1xCONTACTATOR 


HOURS_6BIT<='0' & Q_HOURS;

U1: CONTACTOR_2BIT_MSB
port map
(
VALUE_6BIT => HOURS_6BIT,
VALUE_8BIT => HOURS_8BIT
);



-------------------------------1xBIN2BCD  

U2: BIN2BCD
port map
(
COUNTER_IN => HOURS_8BIT,
BCD_OUT    => BIN2BCD_OUT_HR
);


-------------------------------2xBCD2SEG 



      		
BCD_HR_4BIT_UNITS  <= BIN2BCD_OUT_HR(3 downto 0);
BCD_HR_4BIT_DOZENS <= BIN2BCD_OUT_HR(7 downto 4);

--two (MSB,LSB) for each, HOURS

--Units digit :
U3: PMOD_SSD_BCD_2_7SEGMENT   
port map
(
BCD_4BIT              => BCD_HR_4BIT_UNITS,
SINGLE_DIGIT_SEGMENT  => UNITS_SEGMENT_HR
);

--Dozen digit :
U4:PMOD_SSD_BCD_2_7SEGMENT  
port map
(
BCD_4BIT              => BCD_HR_4BIT_DOZENS,
SINGLE_DIGIT_SEGMENT  => DOZENS_SEGMENT_HR
);




--------------------------------2xMUX2_1:

--MUX Segments out
U5:MUX2_1
port map
(
SEL => COUNTER_OUT,
IN0 => UNITS_SEGMENT_HR,
IN1 => DOZENS_SEGMENT_HR,
OT  => SEGMENTS_OUT_PMOD_SSD
);



--MUX CATHODS_OUT
--Althouth only 2bits need to the cathods
--i used mux4_1 with 7 bits input so i must
--refer is as 7 bits:

CATHOD0<= "0000001";
CATHOD1<= "0000000";

--S_SELECT_MUX_CATHODS<=COUNTER_OUT(0);

U6:MUX2_1
port map
(
SEL => COUNTER_OUT,
IN0 => CATHOD0,
IN1 => CATHOD1,
OT  => S_MUX_CATHODS_OUT_PMOD_SSD  
);

CATHODS_OUT_PMOD_SSD<= S_MUX_CATHODS_OUT_PMOD_SSD(0);
--------------------------------------

--To practice i will do INSTANTIATION BY POSITION
U7: PMOD_COUNTER port map(RESET,CLK,TESTMOOD,COUNTER_OUT);



end PMOD_SSD_7SEGMENT_BLOCK_ARC;