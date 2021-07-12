library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity alu_decoder is
    Port ( 
        aluop : in std_logic_vector(3 downto 0);
        alucontrol : out std_logic_vector(3 downto 0)
    );
end alu_decoder;

architecture Behavioral of alu_decoder is
begin
    process(aluop) begin
        case aluop is
            when "0000" => alucontrol <= "0000"; -- Addition
            when "0111" => alucontrol <= "1001"; -- Subtraction
            when "0001" => alucontrol <= "0010"; -- AND
            when "0010" => alucontrol <= "0011"; -- ORR
            when "0011" => alucontrol <= "0100"; -- XOR
            when "0100" => alucontrol <= "0111"; -- SLL
            when "0101" => alucontrol <= "1000"; -- SRL
            when "1000" => alucontrol <= "1010"; -- ILT
            when others => alucontrol <= "----"; -- invalid operation
        end case;
    end process;

end Behavioral;
