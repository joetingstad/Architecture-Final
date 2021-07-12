library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity generic_left_shift is
    generic(width: integer);
    Port(valToShift: in STD_LOGIC_VECTOR(width-1 downto 0);
        output: out STD_LOGIC_VECTOR(width-1 downto 0));
end generic_left_shift;

architecture Behavioral of generic_left_shift is
begin
    output <= valToShift( (width)-1 downto 0);
end Behavioral;
