--Created by Moshe Peleg 203348040
--Please notice: the tesebench  make clk & reset -ONLY
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb is
end tb;

architecture tb_arc of tb is
COMPONENT COUNTER
port
(
RESET      :in  std_logic;
CLK        :in  std_logic;
TESTMOOD   :in  std_logic;    --I Must add this signal to input because i want to force it value in the testbench 
COUNTER_OUT:out std_logic_vector(1 downto 0)
);
end COMPONENT;

signal tb_reset       :std_logic;
signal tb_clk:std_logic:='0';
signal tb_testmood	  :std_logic;
signal tb_counter_out :std_logic_vector(1 downto 0);


BEGIN 
DUT: COUNTER
port map
(
RESET 		=> tb_reset,
CLK      	=> tb_clk, 
TESTMOOD    => tb_testmood, 
COUNTER_OUT => tb_counter_out

);

-- 100Mhz internal clk->
tb_clk <=not(tb_clk) after 5 ns;

tb_reset<='1',
          '0' after 113 ns;

tb_testmood<='0';	
		  
  

end tb_arc;