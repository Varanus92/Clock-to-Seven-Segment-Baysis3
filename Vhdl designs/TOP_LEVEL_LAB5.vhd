--The component name MUST be equel 
--to the ORIGINAL COMPONENT NAME IN ITS ENTITY

library IEEE;
use IEEE.std_logic_1164.all;

entity TOP_LEVEL_LAB5 is
port
(
RESET      		   	 :in  std_logic;
CLK       			 :in  std_logic;
TESTMOOD   			 :in  std_logic;    --I Must add this signal to input because i want to force it value in the testbench 
LOAD       			 :in  std_logic;
DATA_IN    			 :in  std_logic_vector(5 downto 0);
ADRS      			 :in  std_logic_vector(1 downto 0); 
SEGMENTS_OUT_BAYSIS3 :out std_logic_vector(6 downto 0);
ANODE_OUT_BAYSIS3    :out std_logic_vector(3 downto 0);
SEGMENTS_OUT_PMOD_SSD:out std_logic_vector(6 downto 0);
CATHODS_OUT_PMOD_SSD :out std_logic--_vector(3 downto 0)
);
end TOP_LEVEL_LAB5;


architecture TOP_LEVEL_LAB5_ARC of TOP_LEVEL_LAB5 is

component TIMER_LAB5_BLOCK
port(
RESET      :in  std_logic;
CLK        :in  std_logic;
TESTMOOD   :in  std_logic;    --I Must add this signal to input because i want to force it value in the testbench 
LOAD       :in  std_logic;
DATA_IN    :in  std_logic_vector(5 downto 0);
SEL_SECONDS:in  std_logic;
SEL_MINUTES:in  std_logic;
SEL_HOURS  :in  std_logic;
SECONDS_OUT:out std_logic_vector(5 downto 0);     --to count 0-59
MINUTES_OUT:out std_logic_vector(5 downto 0);     --to count 0-59
HOURS_OUT  :out std_logic_vector(4 downto 0)      --to count 0-23
);
end component;


component DECODER1_3
port(
ADRS        				      :in  std_logic_vector(1 downto 0); 
SEL_SECONDS,SEL_MINUTES,SEL_HOURS :out std_logic  --Every digit of 7SEGMENT consisted from 7 bit 
);
end component;



component BAYSIS3_7SEGMENT_BLOCK 
port(
Q_SECONDS   		 :in std_logic_vector(5 downto 0);
Q_MINUTS    		 :in std_logic_vector(5 downto 0);
TESTMOOD   		     :in std_logic;
CLK        		     :in std_logic;
RESET	         	 :in std_logic;
SEGMENTS_OUT_BAYSIS3 :out std_logic_vector(6 downto 0);
ANODES_OUT_BAYSIS3   :out std_logic_vector(3 downto 0)
);
end component;


component PMOD_SSD_7SEGMENT_BLOCK 
port(
Q_HOURS  		      :in std_logic_vector(4 downto 0);
TESTMOOD   		      :in std_logic;
CLK        		      :in std_logic;
RESET	         	  :in std_logic;
SEGMENTS_OUT_PMOD_SSD :out std_logic_vector(6 downto 0);
CATHODS_OUT_PMOD_SSD  :out std_logic--_vector(3 downto 0)
);
end component;

signal S_SEL_SECONDS    :std_logic;
signal S_SEL_MINUTES    :std_logic;
signal S_SEL_HOURS      :std_logic;
signal Q_6BIT_SECONDS :std_logic_vector(5 downto 0);
signal Q_6BIT_MINUTES :std_logic_vector(5 downto 0);
signal Q_5BIT_HOURS   :std_logic_vector(4 downto 0);


begin



U1:TIMER_LAB5_BLOCK        port map (RESET,CLK,TESTMOOD,LOAD,DATA_IN,S_SEL_SECONDS,S_SEL_MINUTES,S_SEL_HOURS,Q_6BIT_SECONDS,Q_6BIT_MINUTES,Q_5BIT_HOURS);

U2:DECODER1_3              port map (ADRS,S_SEL_SECONDS,S_SEL_MINUTES,S_SEL_HOURS);

U3:BAYSIS3_7SEGMENT_BLOCK  port map (Q_6BIT_SECONDS,Q_6BIT_MINUTES,TESTMOOD,CLK,RESET,SEGMENTS_OUT_BAYSIS3,ANODE_OUT_BAYSIS3);

U4:PMOD_SSD_7SEGMENT_BLOCK port map (Q_5BIT_HOURS,TESTMOOD,CLK,RESET,SEGMENTS_OUT_PMOD_SSD,CATHODS_OUT_PMOD_SSD);

end TOP_LEVEL_LAB5_ARC;

