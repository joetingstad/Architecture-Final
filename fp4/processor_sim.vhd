library IEEE; 
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

entity processor_sim is
end processor_sim;

architecture Behavioral of processor_sim is
    component Our_Processor is
        Port(CLK, reset: in STD_LOGIC;
         output_on_port: out STD_LOGIC_VECTOR(31 downto 0));
     end component;

    signal clk : STD_LOGIC;
    signal reset : STD_LOGIC;
    signal output_on_port : STD_LOGIC_VECTOR(31 downto 0);
begin

    clkproc: process begin
    clk <= '1';
    wait for 1 ns; 
    clk <= '0';
    wait for 1 ns;
  end process;
  
  -- Generate reset for first few clock cycles
  reproc: process begin
    reset <= '1';
    wait for 1 ns;
    reset <= '0';
    wait;
  end process;
  
  -- instantiate device to be tested
  dut: Our_processor port map( 
       CLK => clk, 
       reset => reset,
       output_on_port => output_on_port );
end Behavioral;
