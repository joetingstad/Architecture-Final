library IEEE;
use IEEE.std_logic_1164.all;

entity main_decoder is
    port(
        op : in std_logic_vector(3 downto 0);
        branch, alusrc : out std_logic;
        regdst, regwrite : out std_logic;
        jump : out std_logic;
        aluop : out std_logic_vector(2 downto 0)
    );
end main_decoder;

architecture Behavioral of main_decoder is
    signal controls : std_logic_vector(7 downto 0);
begin
    process(op) begin
        case op is
            when "0000" => controls <= "10100000"; -- ADI
            
            -- not sure what you defined as the different operations in the ALU for bottom 3 bits
            when "0001" => controls <= "11000000"; -- ADD
            when "0010" => controls <= "11000001"; -- AND
            when "0011" => controls <= "11000010"; -- ORR
            when "0100" => controls <= "11000011"; -- XOR
            when "0101" => controls <= "0X010011"; -- BEQ
            when "0110" => controls <= "0XXX1XXX"; -- JMP
            when "0111" => controls <= "11000100"; -- SLL
            when "1000" => controls <= "11000101"; -- SRL
            when "1001" => controls <= "11000111"; -- SUB
            when others => controls <= "--------"; -- illegal op
        end case;
    end process;
    
    regwrite    <= controls(7);
    regdst      <= controls(6);     
    alusrc      <= controls(5);
    branch      <= controls(4);
    jump        <= controls(3);
    aluop       <= controls(2 downto 0);
                        
end Behavioral;