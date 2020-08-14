--Testmode ==0 ->long count
--Testmodr ==1 ->fast
-- This counter have internal Q of 20 bits
-- to allow counting in 4ms for a count

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity COUNTER is
port(
RESET       :in std_logic;
CLK         :in std_logic;
TESTMOOD    :in std_logic;
COUNTER_OUT:out std_logic_vector(1 downto 0)
);
end counter;

architecture  COUNTER_ARC of COUNTER is

signal Q :std_logic_vector(19 downto 0);   --20 bits

begin 

process
begin
	wait until rising_edge(CLK);
		if (RESET ='1') then
			Q<= (others =>'0');
		else
			Q<= Q+1;
		end if;
			
		
end process;
   
 COUNTER_OUT<=Q(1 downto 0) when  TESTMOOD ='1' else     -->the two LSB changing every CLK ->fast count
		           
              Q(19 downto 18) ;                          ---> those last MSB changing every(4ms) -> long count 
		
		
	
end COUNTER_ARC;



		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
