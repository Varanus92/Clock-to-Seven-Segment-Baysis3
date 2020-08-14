-- This COMPONENT represent full content of the ENTIRE BLOCK of 
-- 7 SEGMENT as shown in "Lab4 Top level Degidn"
-- TO make this Design more ease - i will refer it as  ANOTHER TOP LEVEL 
--
-- so now the hirarcy is:
-- MASTER TOP LEVEL : TOP_LEVEL.VHD
-- SECOND TOP LEVEL : LAB3.vhd,  BAYSIS3_7SEGMENT_BLOCK.VHD,  PMODSSD_7SEGMENT_BLOCK.VHD (NOT YET WRITTEN)
-- THIRD  TOP LEVEL : all the components

--
-- The Design COMPONENTS:
-- 2xCONTACTATORS (one for SECONDS one for MINUTES)
-- 2xBIN2BCD 	  (one for SECONDS one for MINUTES)
-- 4xBCD2SEG      (two (MSB,LSB) for each, SECONDS and MINUTES)
-- 2xMUX4_1       (one for SEGMENT one for ANODES_OUT_BAYSIS3) 
-- COUNTER

library IEEE;
use IEEE.std_logic_1164.all;

entity BAYSIS3_7SEGMENT_BLOCK is 
port(
Q_SECONDS   		 :in std_logic_vector(5 downto 0);
Q_MINUTS    		 :in std_logic_vector(5 downto 0);
TESTMOOD   		     :in std_logic;
CLK        		     :in std_logic;
RESET	         	 :in std_logic;
SEGMENTS_OUT_BAYSIS3 :out std_logic_vector(6 downto 0);
ANODES_OUT_BAYSIS3   :out std_logic_vector(3 downto 0)
);
end BAYSIS3_7SEGMENT_BLOCK;


architecture BAYSIS3_7SEGMENT_BLOCK_ARC of BAYSIS3_7SEGMENT_BLOCK is

--1
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
component BAYSIS3_BCD_2_7SEGMENT
port(
BCD_4BIT             :in  std_logic_vector(3 downto 0); 
SINGLE_DIGIT_SEGMENT :out std_logic_vector(6 downto 0)  --Every digit of 7SEGMENT consisted from 7 bit 
);
end component;

--4
component MUX4_1
port(
SEL:in  std_logic_vector(1 downto 0);
IN0:in  std_logic_vector(6 downto 0);
IN1:in  std_logic_vector(6 downto 0);
IN2:in  std_logic_vector(6 downto 0);
IN3:in  std_logic_vector(6 downto 0);
OT :out std_logic_vector(6 downto 0)
);
end component;

--5
component COUNTER    --(NEED TO MAKE)
port(
RESET       :in std_logic;
CLK         :in std_logic;
TESTMOOD    :in std_logic;
COUNTER_OUT:out std_logic_vector(1 downto 0)
);
end component;



signal SECONDS_8BIT       :std_logic_vector(7 downto 0);
signal MINUTES_8BIT       :std_logic_vector(7 downto 0);
signal BIN2BCD_OUT_SEC    :std_logic_vector(7 downto 0);
signal BIN2BCD_OUT_MIN    :std_logic_vector(7 downto 0);
signal BCD_SEC_4BIT_UNITS :std_logic_vector(3 downto 0);
signal BCD_SEC_4BIT_DOZENS:std_logic_vector(3 downto 0);
signal BCD_MIN_4BIT_UNITS :std_logic_vector(3 downto 0);
signal BCD_MIN_4BIT_DOZENS:std_logic_vector(3 downto 0);
signal UNITS_SEGMENT_SEC  :std_logic_vector(6 downto 0);
signal DOZENS_SEGMENT_SEC :std_logic_vector(6 downto 0);
signal UNITS_SEGMENT_MIN  :std_logic_vector(6 downto 0);
signal DOZENS_SEGMENT_MIN :std_logic_vector(6 downto 0);
signal ANOD0              :std_logic_vector(6 downto 0); 
signal ANOD1              :std_logic_vector(6 downto 0);
signal ANOD2              :std_logic_vector(6 downto 0);
signal ANOD3              :std_logic_vector(6 downto 0);
signal COUNTER_OUT        :std_logic_vector(1 downto 0);
signal S_MUX_ANODES_OUT_BAYSIS3   :std_logic_vector(6 downto 0);




begin 




------------------------ 2xCONTACTATORS 
-- SECOND:
U1: CONTACTOR_2BIT_MSB
port map
(
VALUE_6BIT => Q_SECONDS,
VALUE_8BIT => SECONDS_8BIT
);

-- MINUTES:
U2: CONTACTOR_2BIT_MSB
port map
(
VALUE_6BIT => Q_MINUTS,
VALUE_8BIT   => MINUTES_8BIT
);


-------------------------------2xBIN2BCD  
--SECOND:
U3: BIN2BCD
port map
(
COUNTER_IN => SECONDS_8BIT,
BCD_OUT    => BIN2BCD_OUT_SEC
);

--MINUTES:
U4: BIN2BCD
port map
(
COUNTER_IN => MINUTES_8BIT,
BCD_OUT    => BIN2BCD_OUT_MIN
);



-------------------------------4xBCD2SEG 
BCD_SEC_4BIT_UNITS  <= BIN2BCD_OUT_SEC(3 downto 0);  
BCD_SEC_4BIT_DOZENS	<= BIN2BCD_OUT_SEC(7 downto 4);  
BCD_MIN_4BIT_UNITS  <= BIN2BCD_OUT_MIN(3 downto 0);
BCD_MIN_4BIT_DOZENS <= BIN2BCD_OUT_MIN(7 downto 4);





--two (MSB,LSB) for each, SECONDS and MINUTES)

--Units digit, seconds:
U5: BAYSIS3_BCD_2_7SEGMENT   
port map
(
BCD_4BIT              => BCD_SEC_4BIT_UNITS,
SINGLE_DIGIT_SEGMENT  => UNITS_SEGMENT_SEC
);

--Dozen digit, second
U6: BAYSIS3_BCD_2_7SEGMENT  
port map
(
BCD_4BIT              => BCD_SEC_4BIT_DOZENS,
SINGLE_DIGIT_SEGMENT  => DOZENS_SEGMENT_SEC
);


--Units digit, minutes:
U7: BAYSIS3_BCD_2_7SEGMENT  
port map
(
BCD_4BIT              => BCD_MIN_4BIT_UNITS,
SINGLE_DIGIT_SEGMENT  => UNITS_SEGMENT_MIN
);

--Dozen digit, minutes:
U8: BAYSIS3_BCD_2_7SEGMENT  
port map
(
BCD_4BIT              => BCD_MIN_4BIT_DOZENS,
SINGLE_DIGIT_SEGMENT  => DOZENS_SEGMENT_MIN
);


--------------------------------2xMUX4_1:

--MUX Segments out
U9:MUX4_1
port map
(
SEL => COUNTER_OUT,
IN0 => UNITS_SEGMENT_SEC,
IN1 => DOZENS_SEGMENT_SEC,
IN2 => UNITS_SEGMENT_MIN,
IN3 => DOZENS_SEGMENT_MIN,
OT  => SEGMENTS_OUT_BAYSIS3
);



--MUX ANODES_OUT_BAYSIS3

ANOD0<= "0001110";
ANOD1<= "0001101";
ANOD2<= "0001011";
ANOD3<= "0000111";

U10:MUX4_1
port map
(
SEL => COUNTER_OUT,
IN0 => ANOD0,
IN1 => ANOD1,
IN2 => ANOD2,
IN3 => ANOD3,
OT  => S_MUX_ANODES_OUT_BAYSIS3  
);

ANODES_OUT_BAYSIS3<= S_MUX_ANODES_OUT_BAYSIS3(3 downto 0);
--------------------------------------

--To practice i will do INSTANTIATION BY POSITION
U11: COUNTER port map(RESET,CLK,TESTMOOD,COUNTER_OUT);



end BAYSIS3_7SEGMENT_BLOCK_ARC;