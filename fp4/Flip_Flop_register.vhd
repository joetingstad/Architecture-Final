library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Do_the_Flop is
    generic(width: integer);
    Port(CLK, reset: in STD_LOGIC;
         nextPC: in STD_LOGIC_VECTOR(width-1 downto 0);
         newPC: out STD_LOGIC_VECTOR(width-1 downto 0));
end Do_the_Flop;

architecture asynchronous of Do_the_Flop is
begin
    process(CLK, reset)
    begin
        if reset = '1' then
            newPC <= (others => '0');
        elsif (CLK'event and CLK = '1') then
            newPC <= nextPC;
        end if;
    end process;
end asynchronous;
