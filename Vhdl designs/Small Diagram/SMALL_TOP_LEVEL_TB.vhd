--Created by Moshe Peleg 203348040
--Please notice: the tesebench  make clk & reset -ONLY
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb is
end tb;

architecture tb_arc of tb is
COMPONENT SMALL_TOP_LEVEL_LAB5
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
end COMPONENT;

signal tb_reset        :std_logic;
signal tb_clk:std_logic:='0';
signal tb_testmood	   :std_logic;
signal tb_data_in      :std_logic_vector(5 downto 0);
signal tb_load         :std_logic;
signal tb_adrs         :std_logic_vector(1 downto 0);

signal tb_seconds_out  :std_logic_vector(5 downto 0);
signal tb_minutes_out  :std_logic_vector(5 downto 0);
signal tb_hours_out    :std_logic_vector(4 downto 0);



BEGIN 
DUT: SMALL_TOP_LEVEL_LAB5 
port map
(
RESET 		=> tb_reset,
CLK      	=> tb_clk, 
TESTMOOD    => tb_testmood, 
DATA_IN     => tb_data_in,
LOAD        => tb_load,
ADRS        => tb_adrs,
SECONDS_OUT => tb_seconds_out,
MINUTES_OUT => tb_minutes_out,
HOURS_OUT   => tb_hours_out
);

-- 100Mhz internal clk->
tb_clk <=not(tb_clk) after 5 ns;

tb_reset<='1',
          '0' after 113 ns;

tb_testmood<='1';
		  
  

end tb_arc;