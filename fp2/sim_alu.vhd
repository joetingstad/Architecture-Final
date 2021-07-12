library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sim_alu is
--  Port ( );
end sim_alu;

architecture Behavioral of sim_alu is
    component alu is
        port (
         alusel : in STD_LOGIC_VECTOR(3 downto 0);
         a, b : in STD_LOGIC_VECTOR( 31 downto 0 );
         nf: out STD_LOGIC;
         zf: out STD_LOGIC;
         cf: out STD_LOGIC;
         ovf: out STD_LOGIC;
         Y : out STD_LOGIC_VECTOR( 31 downto 0 ) );
    end component;
    --inputs
    signal alusel : STD_LOGIC_VECTOR(3 downto 0);
    signal a, b : STD_LOGIC_VECTOR( 31 downto 0 );
    --outputs
    signal nf: STD_LOGIC;
    signal zf: STD_LOGIC;
    signal cf: STD_LOGIC;
    signal ovf: STD_LOGIC;
    signal Y : STD_LOGIC_VECTOR( 31 downto 0 );
begin

    -- implement the ALU
    alu_block : alu port map( a => a, b => b, nf => nf, Y => Y, zf => zf, cf => cf, ovf => ovf, alusel => alusel);

    -- Stimulus process
    stim_proc: process
    begin	
        -- hold reset state for 100 ms.
        
        -- not
        alusel <= "0000";
        a <= "00000000000000000000000011111111";
        b <= "00000000000000000000000000000000";
        wait for 2ns;
        assert Y = "11111111111111111111111100000000" report "Failed for not "&integer'image(to_integer(signed(Y)));
        
        -- and
        alusel <= "0001";
        a <= "00000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000010000000100000000000001000" report "Failed for and "&integer'image(to_integer(signed(Y)));
        
        -- or
        alusel <= "0010";
        a <= "00000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000110000110110001000011111111" report "Failed for or "&integer'image(to_integer(signed(Y)));
        
        -- xor
        alusel <= "0011";
        a <= "00000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000100000110010001000011110111" report "Failed for xor "&integer'image(to_integer(signed(Y)));
        
        -- nor
        alusel <= "0100";
        a <= "00000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "11111001111001001110111100000000" report "Failed for nor "&integer'image(to_integer(signed(Y)));
        
        -- >
        alusel <= "0101";
        a <= "01000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for > "&integer'image(to_integer(signed(Y)));
        alusel <= "0101";
        a <= "00000110000000110000000011111111";
        b <= "01000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for > "&integer'image(to_integer(signed(Y)));
        
        -- <
        alusel <= "0110";
        a <= "00000110000000110000000011111111";
        b <= "10000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for < "&integer'image(to_integer(signed(Y)));
        alusel <= "0110";
        a <= "10000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for < "&integer'image(to_integer(signed(Y)));
        
        -- >=
        alusel <= "0111";
        a <= "01000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for >= "&integer'image(to_integer(signed(Y)));
        alusel <= "0111";
        a <= "00000110000000110000000011111111";
        b <= "01000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for >= "&integer'image(to_integer(signed(Y)));
        alusel <= "0111";
        a <= "01010101010101101010101010101010";
        b <= "01010101010101101010101010101010";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for >= "&integer'image(to_integer(signed(Y)));
        
        -- <=
        alusel <= "1000";
        a <= "00000110000000110000000011111111";
        b <= "10000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for <= "&integer'image(to_integer(signed(Y)));
        alusel <= "1000";
        a <= "10000110000000110000000011111111";
        b <= "00000010000110100001000000001000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for <= "&integer'image(to_integer(signed(Y)));
        alusel <= "1000";
        a <= "01010101010101101010101010101010";
        b <= "01010101010101101010101010101010";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for <= "&integer'image(to_integer(signed(Y)));
        
        -- =
        alusel <= "1001";
        a <= "01010101010101101010101010101010";
        b <= "01010101010101101010101010101010";
        wait for 2ns;
        assert Y = "00000000000000000000000000000001" report "Failed for = "&integer'image(to_integer(signed(Y)));
        alusel <= "1001";
        a <= "01010101111101101010101010101010";
        b <= "01010101010101101010101010101010";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for = "&integer'image(to_integer(signed(Y)));
        
        -- addition       
        alusel <= "1010";
        a <= "00000000000000000000000000000000";
        b <= "00000000000000000000000000000000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for + "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for + carry Flag ";
        assert ovf = '0' report "Failed for + overflow ";
        alusel <= "1010";
        a <= "00000000000111000100000000000000";
        b <= "00001100000000000000010001100000";
        wait for 2ns;
        assert Y = "00001100000111000100010001100000" report "Failed for + "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for + carry Flag ";
        assert ovf = '0' report "Failed for + overflow ";        
        alusel <= "1010";
        a <= "01111111111111111111111111111111";
        b <= "10000000000000000000000000000000";
        wait for 2ns;
        assert Y = "11111111111111111111111111111111" report "Failed for + "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for + carry Flag";
        assert ovf = '0' report "Failed for + overflow ";       
        alusel <= "1010";
        a <= "01111111111111111111111111111111";
        b <= "11000000000000000000000000000000";
        wait for 2ns;
        assert Y = "00111111111111111111111111111111" report "Failed for + "&integer'image(to_integer(signed(Y)));
        assert cf = '1' report "Failed for + carry Flag";
        assert ovf = '0' report "Failed for + overflow ";       
        alusel <= "1010";
        a <= "10000000000000000000000000000011";
        b <= "11000000000000000000000000000000";
        wait for 2ns;
        assert Y = "01000000000000000000000000000011" report "Failed for + "&integer'image(to_integer(signed(Y)));
        assert cf = '1' report "Failed for + carry Flag";
        assert ovf = '1' report "Failed for + overflow";      
        alusel <= "1010";
        a <= "00000000000000000000000000000011";
        b <= "11000000000000000000000000000000";
        wait for 2ns;
        assert Y = "11000000000000000000000000000011" report "Failed for + "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for + carry Flag";
        assert ovf = '0' report "Failed for + overflow";
        
        -- subtraction     
        alusel <= "1011";
        a <= "00000000000000000000000000000000";
        b <= "00000000000000000000000000000000";
        wait for 2ns;
        assert Y = "00000000000000000000000000000000" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for - carry Flag";
        assert ovf = '0' report "Failed for - overflow";       
        alusel <= "1011";
        a <= "00000000000000000000000000000000";
        b <= "10000000000000001111000000000000";
        wait for 2ns;
        assert Y = "01111111111111110001000000000000" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '1' report "Failed for - carry Flag ";
        assert ovf = '0' report "Failed for - overflow ";        
        alusel <= "1011";
        a <= "00000000000000000000000000000000";
        b <= "00000000000000000001100000000000";
        wait for 2ns;
        assert Y = "11111111111111111110100000000000" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '1' report "Failed for - carry Flag ";
        assert ovf = '0' report "Failed for - overflow ";
        alusel <= "1011";
        a <= "00000000000000000001100000000000";
        b <= "00000000000000000000000000000000";
        wait for 2ns;
        assert Y = "00000000000000000001100000000000" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for - carry Flag";
        assert ovf = '0' report "Failed for - overflow";       
        alusel <= "1011";                                                                                                           
        a <= "10000000000000000001100000000000";                                                                                    
        b <= "00000000000000000000000000000000";                                                                                    
        wait for 2ns;                                                                                                               
        assert Y = "10000000000000000001100000000000" report "Failed for - "&integer'image(to_integer(signed(Y)));                  
        assert cf = '0' report "Failed for - carry Flag";                                                                           
        assert ovf = '0' report "Failed for - overflow";                                                                            
        alusel <= "1011";
        a <= "00000000000000000001100000000000";
        b <= "00000000010000000000000000000100";
        wait for 2ns;
        assert Y = "11111111110000000001011111111100" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '1' report "Failed for - carry Flag";
        assert ovf = '0' report "Failed for - overflow";               
        alusel <= "1011";
        a <= "10011000011000110001100110110001";
        b <= "00000100000001100000000000000000";
        wait for 2ns;
        assert Y = "10010100010111010001100110110001" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for - carry Flag";
        assert ovf = '0' report "Failed for - overflow";               
        alusel <= "1011";
        a <= "00000000000000000001100000000000";
        b <= "10000000010000000000000000000100";
        wait for 2ns;
        assert Y = "01111111110000000001011111111100" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '1' report "Failed for - carry Flag";
        assert ovf = '0' report "Failed for - overflow";        
        alusel <= "1011";
        a <= "10001110011011000001100011000000";
        b <= "10000000010110000110111011100100";
        wait for 2ns;
        assert Y = "00001110000100111010100111011100" report "Failed for - "&integer'image(to_integer(signed(Y)));
        assert cf = '0' report "Failed for - carry Flag";
        assert ovf = '0' report "Failed for - overflow";
        
        
        
    end process;
end Behavioral;
