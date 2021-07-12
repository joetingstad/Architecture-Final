library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity register_file is
    generic(width: integer);
    Port (
        clk : in std_logic;
        control_signal : in std_logic;
        src1 : in std_logic_vector(5 downto 0);
        src2 : in std_logic_vector(5 downto 0);
        dest : in std_logic_vector(5 downto 0);
        write : in std_logic_vector((width-1) downto 0);
        readdata1, readdata2 : out std_logic_vector((width-1) downto 0)
        );
end register_file;

architecture Behavioral of register_file is
    type ramtype is array ((width-1) downto 0) of std_logic_vector((width-1) downto 0);
    signal mem : ramtype;
begin
    process(clk) begin
        if rising_edge(clk) then
            if control_signal = '1' then
                mem(to_integer(unsigned(dest))) <= write;
            end if;
        end if;
    end process;
    
    process(src1, src2, mem) begin
--        if (mem(width-1 downto 0)(to_integer(unsigned(src1))) = "U") then
--            mem(to_integer(unsigned(src1))) <= (others => '0');
--        elsif(mem(width-1 downto 0)(to_integer(unsigned(src1))) = "X") then
--            mem(to_integer(unsigned(src1))) <= (others => '0');
--        end if;
        if (to_integer(unsigned(src1)) = 0) then
            readdata1 <= (others => '0');
        else
            readdata1 <= mem(to_integer(unsigned(src1)));
        end if;
        
        if (to_integer(unsigned(src2)) = 0) then
            readdata2 <= (others => '0');
        else
            readdata2 <= mem(to_integer(unsigned(src2)));
        end if;
    end process;
end Behavioral;




