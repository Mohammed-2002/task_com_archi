library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataPath is
    port (
        clk         : in std_logic;
        rst         : in std_logic; --reset is button, must be debounced
        ALU_result  : out std_logic_vector(31 downto 0)
    );
end entity DataPath;

architecture arch_DataPath of DataPath is

    component PC
        port (
            PCIn    : in std_logic_vector(31 downto 0);
            clk     : in std_logic;
            rst     : in std_logic;                                                     
            PCOut   : out std_logic_vector(31 downto 0)
        );
    end component;
    
    component if_id 
    port (
		instruction_if_in   :in std_logic_vector(31 downto 0); 
		PC_if_in			:in std_logic_vector(31 downto 0);
        clk					:in std_logic;
		rst					:in std_logic;
		enable				:in std_logic;
        instruction_id_out  :out std_logic_vector(31 downto 0);
		PC_id_out			:out std_logic_vector(31 downto 0) 
    );
    end component;
    
    component ID_EX 
    port (
        	PC_ID_in              :in std_logic_vector(31 downto 0);
            Branch_ID_in          : in std_logic_vector(2 downto 0);
            MemRead_ID_in         : in std_logic;
            ToRegister_ID_in      : in std_logic_vector(2 downto 0);
            ALUOp_ID_in           : in std_logic_vector(2 downto 0);
            MemWrite_ID_in        : in std_logic;
            ALUSrc_ID_in          : in std_logic;
            jump_ID_in            : in std_logic;
            StoreSel_ID_in        : in std_logic;
            halfselect_ID_in      : in std_logic;
            readData1_ID_in       : in std_logic_vector(31 downto 0);     
            readData2_ID_in       : in std_logic_vector(31 downto 0);
            immediate_ID_in         : in std_logic_vector(31 downto 0);
            
            clk					  :in std_logic;
		    rst					  :in std_logic;
		    enable				  :in std_logic;
            
            PC_EX_out              : out std_logic_vector(31 downto 0);
            Branch_EX_out          : out std_logic_vector(2 downto 0);
            MemRead_EX_out         : out std_logic;
            ToRegister_EX_out      : out std_logic_vector(2 downto 0);
            ALUOp_EX_out           : out std_logic_vector(2 downto 0);
            MemWrite_EX_out        : out std_logic;
            ALUSrc_EX_out          : out std_logic;
            jump_EX_out            : out std_logic;
            StoreSel_EX_out        : out std_logic;
            halfselect_EX_out      : out std_logic;
            readData1_EX_out       : out std_logic_vector(31 downto 0);     
            readData2_EX_out       : out std_logic_vector(31 downto 0);
            immediate_EX_out         : out std_logic_vector(31 downto 0)  
          );   
    end component;
    
    component EX_MEM
    Port(
            PC_EX_in             :in std_logic_vector(31 downto 0);
            zero_EX_in           :in std_logic;
            carryOut_EX_in       :in std_logic;
            signo_EX_in  		 :in std_logic;  
            mux4Out_resultMul_EX_in     :in std_logic_vector(31 downto 0);
            result_EX_in                :in std_logic_vector(31 downto 0);
            mux1Out_DataIn_EX_in        : in  std_logic_vector(31 downto 0);
            Branch_EX_in          : in std_logic_vector(2 downto 0);
            MemRead_EX_in         : in std_logic;
            MemWrite_EX_in        : in std_logic;
            ToRegister_EX_in      : in std_logic_vector(2 downto 0);
            
            clk					  :in std_logic;
		    rst					  :in std_logic;
		    enable				  :in std_logic;
		    
            PC_MEM_out            :out std_logic_vector(31 downto 0);
            zero_MEM_out          :out std_logic;
            carryOut_MEM_out      :out std_logic;
            signo_MEM_out  		 :out std_logic;  
            mux4Out_resultMul_MEM_out     :out std_logic_vector(31 downto 0);
            result_MEM_out                :out std_logic_vector(31 downto 0);
            mux1Out_DataIn_MEM_out        :out  std_logic_vector(31 downto 0);
            Branch_MEM_out          :out std_logic_vector(2 downto 0);
            MemRead_MEM_out         :out std_logic;
            MemWrite_MEM_out        :out std_logic;
            ToRegister_MEM_out      :out std_logic_vector(2 downto 0)
    );
    end component;
    
    component MEM_WB
        Port (
        
            PC_MEM_in             :in std_logic_vector(31 downto 0);
            resultMul_MEM_in      :in std_logic_vector(31 downto 0);
            result_MEM_in         :in std_logic_vector(31 downto 0);    
            DataOut_MEM_in        :in std_logic_vector(31 downto 0);
            ToRegister_MEM_in     :in std_logic_vector(2 downto 0);
            
            clk					  :in std_logic;
		    rst					  :in std_logic;
		    enable				  :in std_logic;
		    
            PC_WB_out            :out std_logic_vector(31 downto 0);
            resultMul_WB_out     :out std_logic_vector(31 downto 0);
            result_WB_out        :out std_logic_vector(31 downto 0);
            DataOut_WB_out       :out std_logic_vector(31 downto 0);
            ToRegister_WB_out    :out std_logic_vector(2 downto 0)
    
         );
    end component;

    component multiplier
             port (
        operator1   : in std_logic_vector(31 downto 0);
        operator2   : in std_logic_vector(31 downto 0);
        product     : out std_logic_vector(63 downto 0)
    );
    
    end component;

    component Instruction_Mem
        port (
            Address     :in std_logic_vector(15 downto 0);
            instruction :out std_logic_vector(31 downto 0)
        );
    end component;

    component Reg_File
        port (
            clk         :in std_logic;
            writeReg    :in std_logic;                          --signal for write in register
            sourceReg1  :in std_logic_vector(4 downto 0);       --address of rs1
            sourceReg2  :in std_logic_vector(4 downto 0);       --address of rs2
            destinyReg  :in std_logic_vector(4 downto 0);       --address of rd
            data        :in std_logic_vector(31 downto 0);      --Data to be written
            readData1   :out std_logic_vector(31 downto 0);     --data in rs1
            readData2   :out std_logic_vector(31 downto 0)      --data in rs2    
        );
    end component;

    component Mux
        port (
            muxIn0      :in std_logic_vector(31 downto 0);
            muxIn1      :in std_logic_vector(31 downto 0);
            selector    :in std_logic;
            muxOut      :out std_logic_vector(31 downto 0)    
    );
    end component;

    component ALU_RV32
        port (
            operator1   :in std_logic_vector(31 downto 0);
            operator2   :in std_logic_vector(31 downto 0);
            ALUOp       :in std_logic_vector(2 downto 0);
            result      :out std_logic_vector(31 downto 0);
            zero        :out std_logic;
            carryOut    :out std_logic;
            signo  		:out std_logic
        );
    end component;

    component Data_Mem
        port (
            clk     :in std_logic;
            writeEn :in std_logic;
            readEn  :in std_logic;
            Address :in std_logic_vector(7 downto 0);
            dataIn  :in std_logic_vector(31 downto 0);
            dataOut :out std_logic_vector(31 downto 0)
        );
    end component;

    component Immediate_Generator
        port (
            instruction     : in std_logic_vector(31 downto 0);
            immediate       : out std_logic_vector(31 downto 0)
        );
    end component;

    component Mux_Store
        port (
            muxIn0      :in std_logic_vector(31 downto 0);  --SB
            muxIn1      :in std_logic_vector(31 downto 0);  --SW
            selector    :in std_logic;
            muxOut      :out std_logic_vector(31 downto 0)
    );
    end component;

    component Branch_Control
        port (
            branch      : in std_logic_vector(2 downto 0);
            signo       : in std_logic;
            zero        : in std_logic;
            PCSrc       : out std_logic
        );
    end component;

    component Mux_ToRegFile
        generic (
            busWidth    :integer := 32
            --selWidth    :integer := 3
        );
        port (
            muxIn0     :in std_logic_vector(busWidth-1 downto 0);       --register
            muxIn1     :in std_logic_vector(busWidth-1 downto 0);       --LB
            muxIn2     :in std_logic_vector(busWidth-1 downto 0);       --LW
            muxIn3     :in std_logic_vector(busWidth-1 downto 0);       --PC
            muxIn4     :in std_logic_vector(busWidth-1 downto 0);       --mult
            muxIn5     :in std_logic_vector(busWidth-1 downto 0);       --PC+4
            selector   :in std_logic_vector(2 downto 0);       --ToRegister
            muxOut     :out std_logic_vector(busWidth-1 downto 0)
        );
    end component;

    component Control
        port (
            opcode      : in std_logic_vector(6 downto 0);
            funct3      : in std_logic_vector(2 downto 0);
            funct7      : in std_logic_vector(6 downto 0);
            jump        : out std_logic;
            ToRegister  : out std_logic_vector(2 downto 0);
            MemWrite    : out std_logic;
            MemRead     : out std_logic;
            Branch      : out std_logic_vector(2 downto 0);
            ALUOp       : out std_logic_vector(2 downto 0);
            StoreSel    : out std_logic;
            ALUSrc      : out std_logic;
            WriteReg    : out std_logic;
            halfselect  : out std_logic
        );
    end component;


    signal PCOutPlus            : std_logic_vector(31 downto 0);    --data out from PC register
    signal PCOut_IF ,PCOut_ID, PCOut_EX, PCOut_MEM   : std_logic_vector(31 downto 0);
    signal instruction_IF_in    : std_logic_vector(31 downto 0);  
    signal instruction_ID_out   : std_logic_vector(31 downto 0);    
    signal PCIn                 : std_logic_vector(31 downto 0);    --PC updated
    
    signal toRegister_ID_IN, Branch_ID_IN, ALUOp_ID_IN : std_logic_vector(2 downto 0); 
    signal regData1_ID_IN,regData2_ID_IN               : std_logic_vector(31 downto 0);        
    signal regData1,regData2                           : std_logic_vector(31 downto 0);    --data readed from register file
    signal memWrite_ID_IN, memRead_ID_IN               : std_logic;
    signal StoreSel_ID_IN, ALUSrc_ID_IN, halfselect_ID_IN, jump_ID_IN     : std_logic;
    signal immediate_ID_IN               : std_logic_vector(31 downto 0);
    
    signal Branch_EX_IN, toRegister_EX_IN               : std_logic_vector(2 downto 0);
    signal MemRead_EX_IN, MemWrite_EX_IN                : std_logic;
    
    signal signo, zero, carry   : std_logic;
    signal result, dataIn       : std_logic_vector(31 downto 0);    --alu result and data in to memory
    signal immediate            : std_logic_vector(31 downto 0);    --immediate generated
    signal dataOut              : std_logic_vector(31 downto 0);    --data from memory
    signal jump, memWrite       : std_logic;
    signal StoreSel, ALUSrc     : std_logic;
    signal writeReg, PCSrc      : std_logic;
    signal toRegister, Branch, ALUOp : std_logic_vector(2 downto 0);
    signal dataForReg           : std_logic_vector(31 downto 0);    --data to be written in register File
    signal op2                  : std_logic_vector(31 downto 0);    --operator for ALU(output from mux)
    signal offset               : std_logic_vector(31 downto 0);    --PC+immediate after shift or result(jal)
    signal regData2Anded        : std_logic_vector(31 downto 0);
    signal newAddress           : std_logic_vector(31 downto 0);
    signal shifted              : std_logic_vector(31 downto 0);
    signal mulOut               : std_logic_vector(63 downto 0);
    signal mulOutUpper          : std_logic_vector(31 downto 0);
    signal mulOutLower          : std_logic_vector(31 downto 0);
    signal halfselect           : std_logic;
    signal resultMul            : std_logic_vector(31 downto 0);
    signal memRead              : std_logic;
    
    signal zero_MEM_out          :std_logic;
    signal carryOut_MEM_out      :std_logic;
    signal signo_MEM_out  		 :std_logic;  
    signal mux4Out_resultMul_MEM_out     :std_logic_vector(31 downto 0);
    signal result_MEM_out                :std_logic_vector(31 downto 0);
    signal mux1Out_DataIn_MEM_out        :std_logic_vector(31 downto 0);
    signal Branch_MEM_out          :std_logic_vector(2 downto 0);
    signal MemRead_MEM_out         :std_logic;
    signal MemWrite_MEM_out        :std_logic;
    signal ToRegister_MEM_out      :std_logic_vector(2 downto 0);
    
    signal DataOut_MEM_in          :std_logic_vector(31 downto 0);
    
    signal PC_WB_out            :std_logic_vector(31 downto 0);
    signal resultMul_WB_out     :std_logic_vector(31 downto 0);
    signal result_WB_out        :std_logic_vector(31 downto 0);
    signal DataOut_WB_out       :std_logic_vector(31 downto 0);
    signal ToRegister_WB_out    :std_logic_vector(2 downto 0);
    
    
begin
    
    PCount: PC port map (clk => clk, rst => rst, PCIn => PCIn, PCOut => PCOut_IF);
    
    IF_ID_stage: if_id port map (instruction_if_in => instruction_IF_in ,PC_if_in => PCOut_IF,
    clk => clk,rst => rst,enable => '1',instruction_id_out => instruction_ID_out ,PC_id_out => PCOut_ID); 
    
    
    ID_EX_stage: ID_EX port map ( PC_ID_in => PCOut_ID, Branch_ID_in => Branch_ID_IN, MemRead_ID_in => memRead_ID_IN
    ,ToRegister_ID_in => toRegister_ID_IN, ALUOp_ID_in => ALUOp_ID_IN ,MemWrite_ID_in => memWrite_ID_IN
    ,ALUSrc_ID_in => ALUSrc_ID_IN,jump_ID_in =>jump_ID_IN,  StoreSel_ID_in  => StoreSel_ID_IN ,halfselect_ID_in => halfselect_ID_IN
    ,readData1_ID_in => regData1_ID_IN ,readData2_ID_in => regData2_ID_IN ,immediate_ID_in => immediate_ID_IN      
    ,clk => clk  ,rst => rst  ,enable	=> '1' ,PC_EX_out => PCOut_EX ,Branch_EX_out => Branch_EX_IN, MemRead_EX_out => MemRead_EX_IN
    ,ToRegister_EX_out => toRegister_EX_IN, ALUOp_EX_out => ALUOp, MemWrite_EX_out => MemWrite_EX_IN, ALUSrc_EX_out => ALUSrc
    ,jump_EX_out => jump, StoreSel_EX_out => StoreSel ,halfselect_EX_out => halfselect ,readData1_EX_out => regData1 ,
    readData2_EX_out => regData2 ,immediate_EX_out => immediate ); 
    
    
    
    EX_MEM_stage: EX_MEM port map (
             PC_EX_in             => PCOut_EX
            ,zero_EX_in           => zero
            ,carryOut_EX_in       => carry
            ,signo_EX_in  		 =>  signo
            ,mux4Out_resultMul_EX_in     => resultMul
            ,result_EX_in                => result
            ,mux1Out_DataIn_EX_in        => Datain
            ,Branch_EX_in          => Branch_EX_IN
            ,MemRead_EX_in         => MemRead_EX_in
            ,MemWrite_EX_in        => MemWrite_EX_in
            ,ToRegister_EX_in      => ToRegister_EX_in
            
            ,clk					  => clk
		    ,rst					  => rst
		    ,enable				  => '1'
		    
            ,PC_MEM_out            => PCOut_MEM
            ,zero_MEM_out          => zero_MEM_out
            ,carryOut_MEM_out      => carryOut_MEM_out
            ,signo_MEM_out  		  => signo_MEM_out 
            ,mux4Out_resultMul_MEM_out     => mux4Out_resultMul_MEM_out
            ,result_MEM_out                => result_MEM_out
            ,mux1Out_DataIn_MEM_out        => mux1Out_DataIn_MEM_out
            ,Branch_MEM_out          => Branch_MEM_out
            ,MemRead_MEM_out         => MemRead_MEM_out
            ,MemWrite_MEM_out        => MemWrite_MEM_out
            ,ToRegister_MEM_out      => ToRegister_MEM_out
    );
    
    MEM_WB_stage: MEM_WB port map(
        
             PC_MEM_in             => PCOut_MEM
            ,resultMul_MEM_in     => result_MEM_out
            ,result_MEM_in        => result_MEM_out    
            ,DataOut_MEM_in       => DataOut_MEM_in
            ,ToRegister_MEM_in    => ToRegister_MEM_out
            
            ,clk				  => clk
		    ,rst				  => rst
		    ,enable				  => '1'
		    
            ,PC_WB_out            => PC_WB_out 
            ,resultMul_WB_out     => resultMul_WB_out
            ,result_WB_out        => result_WB_out 
            ,DataOut_WB_out       => DataOut_WB_out
            ,ToRegister_WB_out    => ToRegister_WB_out
    
         );
        
               
    ROM: Instruction_Mem port map (Address => PCOut_IF(15 downto 0), instruction => instruction_IF_in);

    RFILE: Reg_File port map (clk => clk, writeReg => writeReg, sourceReg1 => instruction_ID_out(19 downto 15),
    sourceReg2 => instruction_ID_out(24 downto 20), destinyReg => instruction_ID_out(11 downto 7), data => dataForReg,
    readData1 => regData1_ID_IN, readData2 => regData2_ID_IN);
    
    -- wat is de relatie tussen het signaal offset en het signaal immediate?? 
    Mux0: Mux port map (muxIn0 => immediate, muxIn1 => regData2, selector => ALUSrc, muxOut => op2);
    
    ALU: ALU_RV32 port map (operator1 => regData1, operator2 => op2, ALUOp => ALUOp, 
    result => result, zero => zero, carryOut => carry, signo => signo);

    Mux1: Mux port map (muxIn0 => regData2, muxIn1 => regData2Anded, selector => StoreSel, muxOut => dataIn);
    
    Mul: multiplier port map (operator1 => regData1, operator2 => regData2, product => mulOut);
    
    Mux4: Mux port map (muxIn0 => mulOutLower, muxIn1 => mulOutUpper, selector => halfselect, muxOut => resultMul );
    
    RAM: Data_Mem port map (clk => clk, writeEn => MemWrite_MEM_out, Address => result_MEM_out(7 downto 0),
     dataIn => mux1Out_DataIn_MEM_out, dataOut => DataOut_MEM_in, readEn => MemRead_MEM_out);

    BRControl: Branch_Control port map (branch => Branch_MEM_out, signo => signo_MEM_out,
     zero => zero_MEM_out,PCSrc => PCSrc);
    
    MuxReg: Mux_ToRegFile port map (muxIn0 => result_WB_out, muxIn1 => DataOut_WB_out, muxIn2 => DataOut_WB_out, muxIn3 => PC_WB_out,
    muxIn4 => resultMul_WB_out, muxIn5 => PCOutPlus, selector => ToRegister_WB_out, muxOut => dataForReg);

    Ctrl: Control port map (opcode => instruction_ID_out(6 downto 0), funct3 => instruction_ID_out(14 downto 12), funct7 => instruction_ID_out(31 downto 25),
    jump => jump_ID_IN, MemWrite => memWrite_ID_IN, Branch => Branch_ID_IN, ALUOp => ALUOp_ID_IN, StoreSel => StoreSel_ID_IN, ALUSrc => ALUSrc_ID_IN, 
    WriteReg => WriteReg, ToRegister => toRegister_ID_IN, halfselect => halfselect_ID_in, MemRead => memRead_ID_IN );

    Mux2: Mux port map (muxIn0 => immediate, muxIn1 => result, selector => jump, muxOut => offset);

    Mux3: Mux port map (muxIn0 => PCOutPlus, muxIn1 => newAddress, selector => PCSrc, muxOut => PCIn);
    
    Imm: Immediate_Generator port map (instruction => instruction_ID_out, immediate => immediate_ID_IN);
    

    
    
    
    mulOutUpper <= mulOut(63 downto 32);
    mulOutLower <= mulOut(31 downto 0);
    regData2Anded <= regData2 and X"000000FF";
    PCOutPlus <= PCOut_IF + 4;
    shifted <= offset(30 downto 0) & '0';
    newAddress <= PCOut_EX + shifted;
    
    ALU_result <= result;

end architecture arch_DataPath;
