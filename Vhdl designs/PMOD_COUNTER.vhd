--Testmode ==0 ->long count
--Testmodr ==1 ->fast
-- This PMOD_COUNTER have internal Q of 20 bits
-- to allow counting in 4ms for a count

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity PMOD_COUNTER is
port(
RESET       :in std_logic;
CLK         :in std_logic;
TESTMOOD    :in std_logic;
PMOD_COUNTER_OUT:out std_logic
);
end PMOD_COUNTER;

architecture  PMOD_COUNTER_ARC of PMOD_COUNTER is

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
   
 PMOD_COUNTER_OUT<=Q(0) when  TESTMOOD ='1' else             -->the two LSB changing every CLK ->fast count
		           
              Q(19) ;                                   ---> this last MSB changing every(4ms) -> long count 
		
		
	
end PMOD_COUNTER_ARC;
