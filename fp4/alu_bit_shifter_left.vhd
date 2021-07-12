library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity alu_bit_shifter_left is
    generic(width: integer);
    port(a: in std_logic_vector(width-1 downto 0);
        y: out std_logic_vector(width-1 downto 0));
end alu_bit_shifter_left;

architecture Behavioral of alu_bit_shifter_left is

begin
--------------
end Behavioral;
