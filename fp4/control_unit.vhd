library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;

entity control_unit is
    Port ( 
        op : in std_logic_vector(3 downto 0);
        zero : in std_logic;
        pcsrc, branch2, alusrc : out std_logic;
        regdst, regwrite : out std_logic;
        jump : out std_logic;
        alucontrol : out std_logic_vector(3 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    component main_decoder
        port(
            op : in std_logic_vector(3 downto 0);
            branch, alusrc : out std_logic;
            regdst, regwrite : out std_logic;
            jump : out std_logic;
            aluop : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component alu_decoder
        port(
            aluop : in std_logic_vector(3 downto 0);
            alucontrol : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal aluop : std_logic_vector(3 downto 0);
    signal branch : std_logic;
    
begin
    md : main_decoder port map( op => op, branch => branch, alusrc => alusrc, regdst => regdst,
                           regwrite => regwrite, jump => jump, aluop => aluop);

    ad : alu_decoder port map( aluop => aluop, alucontrol => alucontrol);
    
    branch2 <= branch;
    pcsrc <= branch and zero;

end Behavioral;
