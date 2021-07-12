library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pt_floppy is
    generic(width: integer := 32);
    Port(CLK, reset: in STD_LOGIC;
         pc : inout STD_LOGIC_VECTOR(width-1 downto 0);
         instr: in STD_LOGIC_VECTOR(width-1 downto 0));
end pt_floppy;

architecture Behavioral of pt_floppy is
    component control_unit
        Port ( 
        op : in std_logic_vector(3 downto 0);
        zero : in std_logic;
        pcsrc, branch2, alusrc : out std_logic;
        regdst, regwrite : out std_logic;
        jump : out std_logic;
        alucontrol : out std_logic_vector(3 downto 0));
    end component;
    
    component Dpu_top generic(width: integer);
        Port(CLK, reset: in STD_LOGIC;
         pcsrc, branch, alusrc, regdst, regwrite, jump: in STD_LOGIC;
         alu_control: in STD_LOGIC_VECTOR(3 downto 0);
         zero: out STD_LOGIC;
         pc: inout STD_LOGIC_VECTOR(width-1 downto 0);
         instr: in STD_LOGIC_VECTOR(width-1 downto 0));
     end component;
          
     signal zero: STD_LOGIC;
     signal alu_control: STD_LOGIC_VECTOR(3 downto 0);
     signal branch2: STD_LOGIC;
     signal alusrc, regdst, regwrite, jump, pcsrc: STD_LOGIC;
begin    
    controlDeMind: control_unit port map(op => instr(width-1 downto 28),
                                         zero => zero,
                                         pcsrc => pcsrc, branch2 => branch2, alusrc => alusrc,
                                         regdst => regdst, regwrite => regwrite,
                                         jump => jump,
                                         alucontrol => alu_control);
                                         
    DatathisPath: Dpu_top generic map(width) port map(CLK => CLK, reset => reset,
                                                       pcsrc => pcsrc, branch => branch2,
                                                       alusrc => alusrc, regdst => regdst,
                                                       regwrite => regwrite, jump => jump,
                                                       alu_control => alu_control,
                                                       zero => zero,
                                                       pc => pc,
                                                       instr => instr);
    

end Behavioral;
