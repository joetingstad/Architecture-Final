library IEEE;
use IEEE.std_logic_1164.all;

entity main_decoder is
    port(
        op : in std_logic_vector(3 downto 0);
        branch, alusrc : out std_logic;
        regdst, regwrite : out std_logic;
        jump : out std_logic;
        aluop : out std_logic_vector(3 downto 0)
    );
end main_decoder;

architecture Behavioral of main_decoder is
    signal controls : std_logic_vector(8 downto 0);
begin
    process(op) begin
        case op is
            when "0000" => controls <= "101000000"; -- ADI
            
            -- not sure what you defined as the different operations in the ALU for bottom 3 bits
            when "0001" => controls <= "110000000"; -- ADD
            when "0010" => controls <= "110000001"; -- AND
            when "0011" => controls <= "110000010"; -- ORR
            when "0100" => controls <= "110000011"; -- XOR
            when "0101" => controls <= "0X0100011"; -- BEQ
            when "0110" => controls <= "0XXX1XXXX"; -- JMP
            when "0111" => controls <= "110000100"; -- SLL
            when "1000" => controls <= "110000101"; -- SRL
            when "1001" => controls <= "110000111"; -- SUB
            when "1010" => controls <= "110001000"; -- ILT
            when others => controls <= "---------"; -- illegal op
        end case;
    end process;
    
    regwrite    <= controls(8);
    regdst      <= controls(7);     
    alusrc      <= controls(6);
    branch      <= controls(5);
    jump        <= controls(4);
    aluop       <= controls(3 downto 0);
                        
end Behavioral;