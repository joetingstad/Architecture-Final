--------------------
-- this is a similar piece of code to the adder from mips 1
-- used to modularize the alu
--------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity generic_adder is
    generic(size: integer := 32);
    port( val1, val2: in std_logic_vector(size-1 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(size-1 downto 0);
        cout: out std_logic);
end generic_adder;

architecture Behavioral of generic_adder is
    signal finResult: std_logic_vector(size downto 0);
begin
    finResult <= ("0" & val1) + ("0" & val2) + cin;
    sum <= finResult(size-1 downto 0);
    cout <= finResult(size);  
end Behavioral;
