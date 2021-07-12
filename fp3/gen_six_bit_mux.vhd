library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_two_input_multiplexer is
    Port(opt1, opt2: in STD_LOGIC_VECTOR(5 downto 0);
         chooser: in STD_LOGIC;
         output: out STD_LOGIC_VECTOR(5 downto 0));
end generic_two_input_multiplexer;
architecture Behavioral of generic_two_input_multiplexer is
begin
    output <= opt1 when chooser = '0' else opt2;
end Behavioral;
