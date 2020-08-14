--The component name MUST be equel 
--to the ORIGINAL COMPONENT NAME IN ITS ENTITY

library IEEE;
use IEEE.std_logic_1164.all;

entity SMALL_TOP_LEVEL_LAB5 is
port
(
RESET      :in  std_logic;
CLK        :in  std_logic;
TESTMOOD   :in  std_logic;    --I Must add this signal to input because i want to force it value in the testbench 
LOAD       :in  std_logic;
DATA_IN    :in  std_logic_vector(5 downto 0);
ADRS       :in  std_logic_vector(1 downto 0); 
SECONDS_OUT:out std_logic_vector(5 downto 0);     --to count 0-59
MINUTES_OUT:out std_logic_vector(5 downto 0);     --to count 0-59
HOURS_OUT  :out std_logic_vector(4 downto 0)    
);
end SMALL_TOP_LEVEL_LAB5;


architecture SMALL_TOP_LEVEL_LAB5_ARC of SMALL_TOP_LEVEL_LAB5 is

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




signal S_SEL_SECONDS    :std_logic;
signal S_SEL_MINUTES    :std_logic;
signal S_SEL_HOURS      :std_logic;


begin



U1:TIMER_LAB5_BLOCK        port map (RESET,CLK,TESTMOOD,LOAD,DATA_IN,S_SEL_SECONDS,S_SEL_MINUTES,S_SEL_HOURS,SECONDS_OUT,MINUTES_OUT,HOURS_OUT);

U2:DECODER1_3              port map (ADRS,S_SEL_SECONDS,S_SEL_MINUTES,S_SEL_HOURS);


end SMALL_TOP_LEVEL_LAB5_ARC;
