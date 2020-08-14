-- This contactor component for  LAB 4
-- In "SECOND TOP LEVEL : BAYSIS3_SEVEN_SEGMENT.VHD"
-- i will use this component TWICE :
-- (one for SECONDS one for MINUTES)


library IEEE;
use IEEE.std_logic_1164.all;

entity CONTACTOR_2BIT_MSB is
port
(
VALUE_6BIT   : in  std_logic_vector (5 downto 0);
VALUE_8BIT   : out std_logic_vector (7 downto 0)
);
end CONTACTOR_2BIT_MSB;

architecture CONTACTOR_2BIT_MSB_ARC of CONTACTOR_2BIT_MSB is
begin

VALUE_8BIT <= "00" & VALUE_6BIT ;

end CONTACTOR_2BIT_MSB_ARC;



