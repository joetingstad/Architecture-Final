library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Dpu_top is
    generic(width: integer :=32);
    Port(CLK, reset: in STD_LOGIC;
         pcsrc, branch, alusrc, regdst, regwrite, jump: in STD_LOGIC;
         alu_control: in STD_LOGIC_VECTOR(3 downto 0);
         zero: out STD_LOGIC;
         pc: inout STD_LOGIC_VECTOR(width-1 downto 0);
         instr: in STD_LOGIC_VECTOR(width-1 downto 0));      
end Dpu_top;

architecture Behavioral of Dpu_top is

    -- adder component to deal with pc
    component adder generic(width: integer);
        port(a, b: in STD_LOGIC_VECTOR((width-1) downto 0);
             output: out STD_LOGIC_VECTOR((width-1) downto 0));
    end component;
    
    -- alu component
    component alu generic(width: integer);
        port(ReadData1, ReadData2: in STD_LOGIC_VECTOR(width-1 downto 0);
             aluControl: in STD_LOGIC_VECTOR(3 downto 0);
             shamt: in STD_LOGIC_VECTOR(15 downto 0);
             result: inout STD_LOGIC_VECTOR(width-1 downto 0);
             zf: out STD_LOGIC);
    end component;
         
    -- generic 2 input multiplexer
    component generic_two_input_multiplexer generic(width: integer);
        Port(opt1, opt2: in STD_LOGIC_VECTOR(width-1 downto 0);
             chooser: in STD_LOGIC;
             output: out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    
    -- register file component
    component register_file generic(width: integer);
        Port (
        clk : in std_logic;
        control_signal : in std_logic;
        src1 : in std_logic_vector(5 downto 0);
        src2 : in std_logic_vector(5 downto 0);
        dest : in std_logic_vector(5 downto 0);
        write : in std_logic_vector((width-1) downto 0);
        readdata1, readdata2 : out std_logic_vector((width-1) downto 0)
        );
    end component;
    
    -- left shift for computing addresses for jumps and branches
    component generic_left_shift generic(width: integer);
        Port(valToShift: in STD_LOGIC_VECTOR(width-1 downto 0);
             output: out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    -- sign extender
    component extend generic(width: integer);
        Port(tobeExtend: in STD_LOGIC_VECTOR((width/2)-1 downto 0 );
             newVal: out STD_LOGIC_VECTOR(width-1 downto 0));
    end component;
    
    -- flip flop register
    component Do_the_Flop generic(width: integer);
        Port(CLK, reset: in STD_LOGIC;
             nextPC: in STD_LOGIC_VECTOR(width-1 downto 0);
             newPC: out STD_LOGIC_VECTOR(width-1 downto 0));
     end component;
     
     component gen_sixxer_muxxer
            Port(opt1, opt2: in STD_LOGIC_VECTOR(5 downto 0);
                chooser: in STD_LOGIC;
                output: out STD_LOGIC_VECTOR(5 downto 0));
     end component;
    
    signal writeRegister: STD_LOGIC_VECTOR (5 downto 0);
    signal result, readdata1, readdata2: STD_LOGIC_VECTOR(width-1 downto 0);
    signal src1, src2 : STD_LOGIC_VECTOR(5 downto 0);
    signal immextend, immextendss: STD_LOGIC_VECTOR(width-1 downto 0);
    signal pcJmper, pcNext4bit, nextPCSpot, branchPC, nextPCbranch: STD_LOGIC_VECTOR(width-1 downto 0);
    signal zero_vect: STD_LOGIC_VECTOR(width-1 downto 0) := (others => '0');
    signal incMount: STD_LOGIC_VECTOR(width-1 downto 0);
    signal writedata: STD_LOGIC_VECTOR(width-1 downto 0);
begin
    incMount <= zero_vect(width-1 downto 4) & "0100";
    pcJmper <= pcNext4bit(width-1 downto width-4) & instr(width-5 downto 0);
    pcFlipper: Do_the_Flop generic map(width) port map(CLk => CLK, reset => reset, nextPC => nextPCSpot, newPC => pc);
    pcIncby1: adder generic map(width) port map(a => pc, b => incMount , output => pcNext4Bit);
    immShift: generic_left_shift generic map (width) port map(valToShift => immextend, output => immextendss);
    pcincby2: adder generic map(width) port map(a => pcNext4Bit, b => immextendss, output => branchpc);
    branchPlexer: generic_two_input_multiplexer generic map(width) port map(opt1 => pcNext4Bit,
                                                                            opt2 => branchpc,
                                                                            chooser => pcsrc,
                                                                            output => nextPCbranch);
    PCPlexer: generic_two_input_multiplexer generic map(width) port map(opt1 => nextPCbranch,
                                                                        opt2 => pcJmper,
                                                                        chooser => jump,
                                                                        output => nextPCSpot);                                                                         
    regfile: register_file generic map(width) port map(clk => CLK, 
                                                       src1 => src1,
                                                       src2 => src2,
                                                       dest => instr(27 downto 22),
                                                       control_signal => regwrite,
                                                       write => result,
                                                       readdata1 => readdata1,
                                                       readdata2 => writeData);
                                            
    -- selecter between mem and alu
--    datamux: generic_two_input_multiplexer generic map(width) port map(opt1 => aluOut,
--                                                                       opt2 => readData,
--                                                                       chooser => memtoreg,
--                                                                       output => result);
                                                                     
    -- dest reg selector -- double check!
--    degSelect: generic_two_input_multiplexer generic map (6) port map(opt1 => instr(15 downto 10),
--                                                                          opt2 => instr(27 downto 22),                                                                  
--                                                                          chooser => regdst,
--                                                                          output => writeRegister);
                                                        
    -- sign extend the immediate value
    immext: extend generic map(width) port map(tobeExtend => instr((width/2)-1 downto 0), 
                                               newVal => immextend);
    
                      
    -- determine whcih value is to go to alu
    immMux: generic_two_input_multiplexer generic map(width) port map(opt1 => writeData,
                                                                      opt2 => immextend,
                                                                      chooser => alusrc,
                                                                      output => readdata2);
                                                                      
    -- determine whcih value is to go to src1
    src1Mux: generic_two_input_multiplexer generic map (6) port map(opt1 => instr(15 downto 10),
                                       opt2 => instr(21 downto 16),  
                                       chooser => branch,
                                       output => src1);
                                       
                                       
    src2Mux: generic_two_input_multiplexer generic map (6) port map(opt1 => instr(21 downto 16),
                                       opt2 => instr(27 downto 22),  
                                       chooser => branch,
                                       output => src2);                                  
                                                        
    -- wriirng alu up to everything
    aluBOX: alu generic map(width) port map(ReadData1 => readdata1,
                                             ReadData2 => readdata2,
                                             aluControl => alu_control,
                                             result => result,
                                             shamt => instr(15 downto 0),
                                             zf => zero);

end Behavioral;
