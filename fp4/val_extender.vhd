library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity extend is
    generic(width: integer);
    Port(tobeExtend: in STD_LOGIC_VECTOR((width/2)-1 downto 0 );
         newVal: out STD_LOGIC_VECTOR(width-1 downto 0));
end extend;

architecture Behavioral of extend is
    signal neg_vect: STD_LOGIC_VECTOR(width-1 downto 0) := (others => '1');
    signal zero_vect: STD_LOGIC_VECTOR(width-1 downto 0) := (others => '0');
begin
    process(tobeExtend, neg_vect, zero_vect)
    begin
        if tobeExtend((width/2)-1) = '0' then
            newVal <= zero_vect(width-1 downto width/2) & tobeExtend;
        else 
            newVal <= neg_vect(width-1 downto width/2) & tobeExtend;
        end if;
    end process;
end Behavioral;
