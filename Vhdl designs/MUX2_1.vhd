--**7BIT INPUT**

library IEEE;
use IEEE.std_logic_1164.all;

entity MUX2_1 is
port
(
SEL:in  std_logic;
IN0:in  std_logic_vector(6 downto 0);
IN1:in  std_logic_vector(6 downto 0);
OT :out std_logic_vector(6 downto 0)
);
end MUX2_1;

architecture MUX2_1_ARC of MUX2_1 is
begin

with SEL select
OT <=   IN0 when '0',
		IN1 when '1',
		"XXXXXXX" when OTHERS;

end MUX2_1_ARC;