--Created by Moshe Peleg 203348040
--Please notice: the tesebench  make clk & reset -ONLY
Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tb is
end tb;

architecture tb_arc of tb is
COMPONENT TOP_LEVEL_LAB5
port
(
RESET      :in  std_logic;
CLK        :in  std_logic;
TESTMOOD   :in  std_logic;    --I Must add this signal to input because i want to force it value in the testbench 
LOAD       :in  std_logic;
DATA_IN    :in  std_logic_vector(5 downto 0);
ADRS       :in  std_logic_vector(1 downto 0); 
SEGMENTS_OUT_BAYSIS3 :out std_logic_vector(6 downto 0);
ANODE_OUT_BAYSIS3    :out std_logic_vector(3 downto 0);
SEGMENTS_OUT_PMOD_SSD:out std_logic_vector(6 downto 0);
CATHODS_OUT_PMOD_SSD :out std_logic

);
end COMPONENT;

signal tb_reset        :std_logic;
signal tb_clk:std_logic:='0';
signal tb_testmood	   :std_logic;
signal tb_data_in      :std_logic_vector(5 downto 0);
signal tb_load         :std_logic;
signal tb_adrs         :std_logic_vector(1 downto 0);
signal tb_segments_out_baysis3  :std_logic_vector(6 downto 0);
signal tb_anode_out_baysis3     :std_logic_vector(3 downto 0);
signal tb_segments_out_pmod_ssd :std_logic_vector(6 downto 0);
signal tb_cathods_out_pmod_ssd  :std_logic;




BEGIN 
DUT: TOP_LEVEL_LAB5 
port map
(
RESET 		=> tb_reset,
CLK      	=> tb_clk, 
TESTMOOD    => tb_testmood, 
DATA_IN     => tb_data_in,
LOAD        => tb_load,
ADRS        => tb_adrs,
SEGMENTS_OUT_BAYSIS3  => tb_segments_out_baysis3,
ANODE_OUT_BAYSIS3     => tb_anode_out_baysis3,
SEGMENTS_OUT_PMOD_SSD => tb_segments_out_pmod_ssd,
CATHODS_OUT_PMOD_SSD  => tb_cathods_out_pmod_ssd
);

-- 100Mhz internal clk->
tb_clk <=not(tb_clk) after 5 ns;

tb_reset<='1',
          '0' after 113 ns;

tb_testmood<='1';
		  
--to control the times as requier on the exercise		
	process  
	begin
	--Experiment 1
		  tb_load <= '0';        
		  tb_data_in <= "000000";
		  wait for 113 ns;
		
		  tb_load <= '1';    	  --present 23:58:00 -START FROM HOUR -> MIN -> SEC
		  tb_data_in <= "010111";   --hour =23
		  tb_adrs <=    "10" ;      --mux identifire to hours	   -- hour 23  
		  wait for 20 ns;          --enough time to the value to enter the register AND to see the digits refreshed on the 7 Pmod segment (just two digits)(in the simulation)
		 
		  tb_data_in <= "111010"; 	 --min =58
		  tb_adrs <=    "01" ;	   	 --mux identifire to min
		  wait for 40 ns;        	 --the Baysis3 have 4 segments so to see at list on appearance of the min - 40 ns is required
		  
		  tb_data_in <= "000000"; 	 --sec =00
		  tb_adrs <=    "00" ;	     --mux identifire to sec
		  
		  wait for 40 ns;	 
			  
	------------------------------------------	
	--clear all values:
		 
		  tb_load <= '1';    	  --present 00:00:00 -START FROM HOUR -> MIN -> SEC
		  tb_data_in <= "000000";   --hour =00
		  tb_adrs <=    "10" ;      --mux identifire to hours	   -- hour 23  
		  wait for 10 ns;          --enough time to the value to enter the register AND to see the digits refreshed on the 7 Pmod segment (just two digits)(in the simulation)
		 
		  tb_data_in <= "000000"; 	 --min =00
		  tb_adrs <=    "01" ;	   	 --mux identifire to min
		  wait for 10 ns;        	 --the Baysis3 have 4 segments so to see at list on appearance of the min - 40 ns is required
		  
		  tb_data_in <= "110111"; 	 --sec =55 (to see the change in Experiment2
		  tb_adrs <=    "00" ;	     --mux identifire to sec
		  
		  wait for 10 ns;	 
	
	
	-------------------------------------------
	--Experiment 2
		  tb_load <= '1';    	  --present 23:58:00 -START FROM SEC -> MIN -> HUOR
		  tb_data_in <= "000000"; 	 --sec =00
		  tb_adrs <=    "00" ;	     --mux identifire to sec
		  wait for 40 ns;
		  
		  
		  tb_data_in <= "111010"; 	 --min =58
		  tb_adrs <=    "01" ;	   	 --mux identifire to min
		  wait for 40 ns;
		  
		  tb_data_in <= "010111";   --hour =23
		  tb_adrs <=    "10" ;      --mux identifire to hours	   -- hour 23  
		  wait for 20 ns;
		  tb_load <= '0';	
		  wait for 20 ns;
		             
		  wait;   --this mean - continue from this state and on...  		  

	end process; 
	
end tb_arc;