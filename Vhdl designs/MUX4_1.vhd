--

library IEEE;
use IEEE.std_logic_1164.all;

entity MUX4_1 is
port
(
SEL:in  std_logic_vector(1 downto 0);
IN0:in  std_logic_vector(6 downto 0);
IN1:in  std_logic_vector(6 downto 0);
IN2:in  std_logic_vector(6 downto 0);
IN3:in  std_logic_vector(6 downto 0);
OT :out std_logic_vector(6 downto 0)
);
end MUX4_1;

architecture MUX4_1_ARC of MUX4_1 is
begin

with SEL select
OT <=   IN0 when "00",
		IN1 when "01",
		IN2 when "10",
		IN3 when "11",
		"XXXXXXX" when OTHERS;

end MUX4_1_ARC;