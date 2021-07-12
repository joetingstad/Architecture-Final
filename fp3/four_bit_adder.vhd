library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
entity adder is
    generic(width: integer);
    port(a, b: in STD_LOGIC_VECTOR((width-1) downto 0);
        output: out STD_LOGIC_VECTOR((width-1) downto 0));
end adder;

architecture Behavioral of adder is
begin
    output <= a + b;
end Behavioral;
