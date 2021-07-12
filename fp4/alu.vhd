-------------------------------------------------
-- Module Name:    alu - FP2 
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.all;

entity alu is
    generic(width: integer := 32);
    port(ReadData1, ReadData2: in STD_LOGIC_VECTOR(width-1 downto 0);
         aluControl: in STD_LOGIC_VECTOR(3 downto 0);
         result: inout STD_LOGIC_VECTOR(width-1 downto 0);
         shamt: in STD_LOGIC_VECTOR(15 downto 0);
         zf: out STD_LOGIC);
end alu;

architecture Behavioral of alu is
    signal ShiftLeft, ShiftRight, addition, additionILT, ReadData2Hold, ReadData1Hold, ILT: STD_LOGIC_VECTOR(width-1 downto 0);
    signal negTest: STD_LOGIC_VECTOR(1 downto 0);
    signal zero_vect: STD_LOGIC_VECTOR(width-1 downto 0) := (others => '0');
    begin
        
    ReadData2Hold <= not ReadData2 when aluControl = "1001" else ReadData2;
    --ReadData2Hold <= not ReadData2 when aluControl = "1010" else ReadData2;
    negTest <= "01" when aluControl = ("1001") else "00";
    --negTest <= "01" when aluControl = ("1010") else "00";
    --ReadData1Hold <= not ReadData1 when aluControl = ("1010") else ReadData1;
    
    addition <= ReadData1 + ReadData2Hold + negTest;
    --additionILT <=  ReadData2 + ReadData1Hold + negTest;
    
    --addition <= ReadData2 - ReadData1 + negtest;
    
    --ILT <= ( zero_vect(width-1 downto 1) & '1'); --when not addition((width-1)) = '1' else (others =>'0');
    
    process(ReadData1, ReadData2, result)
    begin
        if(ReadData2 < ReadData1) then
            ILT <= zero_vect(width-1 downto 1) & '1';
        else
            ILT <= zero_vect;
        end if;
    end process;
    
    process(ReadData2, shamt)
    begin
        for shiftAMT in 0 to width-1 loop
            if (shamt = STD_LOGIC_VECTOR(to_unsigned(shiftAMT, width))) then
                ShiftLeft <= STD_LOGIC_VECTOR(unsigned(ReadData2) sll ShiftAMT);
            end if;
        end loop;
        for shiftAMT in 0 to width-1 loop
            if (shamt = STD_LOGIC_VECTOR(to_unsigned(shiftAMT, width))) then
                ShiftRight <= STD_LOGIC_VECTOR(unsigned(ReadData2) srl ShiftAMT);
            end if;
        end loop;
    end process;
    
    with aluControl(3 downto 0) select result <= 
        addition when "0000" | "0001" | "1001",
        ShiftLeft when "0111",
        ShiftRight when "1000",
        ReadData1 and ReadData2 when "0010",
        ReadData1 or ReadData2 when "0011",
        ILT when "1010",
        ReadData1 xor ReadData2 when others;
    -- if the result or arithmatic operation is a zero then set the zero flag
    zf <= '1' when result = zero_vect else '0';

end Behavioral;
