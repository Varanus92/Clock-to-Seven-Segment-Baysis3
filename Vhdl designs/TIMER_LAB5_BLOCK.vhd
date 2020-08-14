--Created by Moshe Peleg 203348040
--Wish me good luck on this LAB 
--THIS DESIGN WILL HAVE 4 COUNTERS:
--1.TIME_BASE_COUNTER(100 MHz)
--2.SECOND_COUNTER
--3.MINUTS_COUNTER
--4.HOUR_COUNTER

Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity TIMER_LAB5_BLOCK is
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
end TIMER_LAB5_BLOCK;

architecture TIMER_LAB5_BLOCK_arc of TIMER_LAB5_BLOCK is


signal Q_TB      :std_logic_vector(27 downto 0);   --to count 0-100000000 (we have 100Mhz Cristal)
signal TC_TB     :std_logic;                       --the output from tc_TB to other counters
signal Q_SECONDS :std_logic_vector(5  downto 0);
signal Q_MINUTES :std_logic_vector(5  downto 0);
signal Q_HOURS   :std_logic_vector(4  downto 0);



begin

--"One signal one process"
--Time Base counter Process:
process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_TB <= (others => '0');
			TC_TB <= '0';
		else
			if TESTMOOD = '0' then            --TESTMOOD=0 =>  TimeBase count up to 100000000
				if (Q_TB < 99999999) then     --Please note ,this is the "Hidden comperator" i didnt sketch on the notebook
					Q_TB <= Q_TB + 1;
					TC_TB <= '0';
				else
				Q_TB <= (others => '0');
				TC_TB <= '1';
				end if;
			else							   --TESTMOOD=1 =>TimeBase count up to 10 (to make the simulation quicker
				if (Q_TB < 9) then             --Please note ,this is the "Hidden comperator" i didnt sketch on the notebook
					Q_TB <= Q_TB + 1;
					TC_TB <= '0';
				else
				Q_TB <= (others => '0');
				TC_TB <= '1';
				end if;
			end if;
		end if;
end process;
---------------------------------------

--SECONDS COUNTER Process:
process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_SECONDS<= (others => '0');
		else
			if (LOAD = '1') and (SEL_SECONDS = '1') then
					Q_SECONDS <= DATA_IN;
			else
				if (TC_TB = '1')  then
					if (Q_SECONDS < 59) then
					Q_SECONDS <= Q_SECONDS + 1;
					else
					Q_SECONDS <= (others => '0');
					end if;
				end if;
			end if;
		end if;
end process;

SECONDS_OUT <= Q_SECONDS;



--Minutes COUNTER Process:
process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_MINUTES<= (others => '0');
		else
			if (LOAD = '1') and (SEL_MINUTES = '1') then
				Q_MINUTES <= DATA_IN;
			else
				if ((TC_TB = '1') and  (Q_SECONDS = 59)) then
					if (Q_MINUTES < 59) then
					Q_MINUTES <= Q_MINUTES + 1;
					else
					Q_MINUTES <= (others => '0');
					end if;
				end if;
			end if;
		end if;
end process;

MINUTES_OUT <= Q_MINUTES;




--HOURS COUNTER Process:
process
begin
	wait until rising_edge(CLK);
		if (RESET = '1') then
			Q_HOURS <= (others => '0');
		else
			if (LOAD = '1') and (SEL_HOURS = '1') then
				Q_HOURS <= DATA_IN(4 downto 0);
			else
				if ((TC_TB = '1') and (Q_MINUTES = 59) and (Q_SECONDS = 59)) then
					if (Q_HOURS < 23) then
					Q_HOURS <= Q_HOURS + 1;
					else
					Q_HOURS <= (others => '0');
					end if;
				end if;
			end if;
		end if;
end process;

HOURS_OUT <= Q_HOURS;






end TIMER_LAB5_BLOCK_arc;



