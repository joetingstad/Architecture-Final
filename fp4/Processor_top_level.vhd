library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Our_Processor is
    Port(CLK, reset: in STD_LOGIC;
         output_on_port: out STD_LOGIC_VECTOR(31 downto 0));
end Our_Processor;
 
architecture Behavioral of Our_Processor is
    component imem generic(width: integer);
        Port (
        a : in std_logic_vector(7 downto 0);
        rd : out std_logic_vector((width-1) downto 0));
    end component;
    
    component pt_floppy generic(width: integer);
        Port(CLK, reset: in STD_LOGIC;
         pc: inout STD_LOGIC_VECTOR(width-1 downto 0);
         instr: in STD_LOGIC_VECTOR(width-1 downto 0));
     end component;
     --signal zero_vect: STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
     signal readData, instr, pc, dataadder: STD_LOGIC_VECTOR(31 downto 0);
begin

    output_on_port <= instr;
    
    midlvlPoces: pt_floppy generic map(32) port map(CLK => CLK, reset => reset, pc => pc,
                                                    instr => instr);
    instructMemory: imem generic map(32) port map(a => pc(9 downto 2), rd => instr);                                                

end Behavioral;
