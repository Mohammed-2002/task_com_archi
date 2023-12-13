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
            enable  : in std_logic;
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
            writeReg_ID_in        : in std_logic;
            readData1_ID_in       : in std_logic_vector(31 downto 0);     
            readData2_ID_in       : in std_logic_vector(31 downto 0);
            sourceReg1_ID_in      : in std_logic_vector(4 downto 0);
            sourceReg2_ID_in      : in std_logic_vector(4 downto 0);
            immediate_ID_in       : in std_logic_vector(31 downto 0);
            destinyReg_ID_in      :in std_logic_vector(4 downto 0);
            
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
            writeReg_EX_out        : out std_logic;
            readData1_EX_out       : out std_logic_vector(31 downto 0);     
            readData2_EX_out       : out std_logic_vector(31 downto 0);
            sourceReg1_EX_out      : out std_logic_vector(4 downto 0);
            sourceReg2_EX_out      : out std_logic_vector(4 downto 0);
            immediate_EX_out       : out std_logic_vector(31 downto 0);
            destinyReg_EX_out      : out std_logic_vector(4 downto 0)  
          );   
    end component;
    
    component EX_MEM
    Port(
            PC_EX_in              :in std_logic_vector(31 downto 0); 
            resultMul_EX_in       :in std_logic_vector(31 downto 0);
            result_EX_in          :in std_logic_vector(31 downto 0);
            DataIn_EX_in          : in  std_logic_vector(31 downto 0);
            MemRead_EX_in         : in std_logic;
            ToRegister_EX_in      : in std_logic_vector(2 downto 0);
            MemWrite_EX_in        : in std_logic;
            writeReg_Ex_in        : in std_logic;
            DestinyReg_Ex_in      : in std_logic_vector(4 downto 0);

            clk					    :in std_logic;
		    rst					    :in std_logic;
		    enable				    :in std_logic;
		    
            PC_MEM_out              :out std_logic_vector(31 downto 0);
            resultMul_Mem_out       :out std_logic_vector(31 downto 0);
            result_MEM_out          :out std_logic_vector(31 downto 0);
            DataIn_Mem_out          :out  std_logic_vector(31 downto 0);
            MemRead_MEM_out         :out std_logic;
            ToRegister_MEM_out      :out std_logic_vector(2 downto 0);
            MemWrite_MEM_out        :out std_logic;
            writeReg_MEM_out        :out std_logic;
            DestinyReg_MEM_out      :out std_logic_vector(4 downto 0)
    );
    end component;
    
    component MEM_WB
        Port (
        
            PC_MEM_in             :in std_logic_vector(31 downto 0);
            resultMul_MEM_in      :in std_logic_vector(31 downto 0);
            result_MEM_in         :in std_logic_vector(31 downto 0);    
            DataOut_MEM_in        :in std_logic_vector(31 downto 0);
            ToRegister_MEM_in     :in std_logic_vector(2 downto 0);
            writeReg_MEM_in       :in std_logic;
            destinyReg_MEM_in     :in std_logic_vector(4 downto 0);

            
            clk					  :in std_logic;
		    rst					  :in std_logic;
		    enable				  :in std_logic;
		    
            PC_WB_out            :out std_logic_vector(31 downto 0);
            resultMul_WB_out     :out std_logic_vector(31 downto 0);
            result_WB_out        :out std_logic_vector(31 downto 0);
            DataOut_WB_out       :out std_logic_vector(31 downto 0);
            ToRegister_WB_out    :out std_logic_vector(2 downto 0);
            writeReg_WB_out      :out std_logic;
            destinyReg_WB_out    :out std_logic_vector(4 downto 0)
    
         );
    end component;
    
    component Forwarding_Unit
             Port ( 
        
        EX_MEM_destinyReg : in  std_logic_vector(4 downto 0);
        MEM_WB_destinyReg : in  std_logic_vector(4 downto 0);
        EX_MEM_WriteReg   : in  std_logic;
        MEM_WB_WriteReg   : in  std_logic;
        ID_EX_ReadReg1    : in  std_logic_vector(4 downto 0);
        ID_EX_ReadReg2    : in  std_logic_vector(4 downto 0);
        
        forwardA          : out std_logic_vector(1 downto 0);
        forwardB          : out std_logic_vector(1 downto 0)
            
     );
        end component;
     
     component Hazard_Detection_Unit 
      Port ( 
            PCSrc            : in std_logic;
            ID_EX_Mem_read   : in std_logic;
            ID_EX_DestinyReg : in std_logic_vector(4 downto 0);
            IF_ID_ReadReg1   : in std_logic_vector(4 downto 0);
            IF_ID_ReadReg2   : in std_logic_vector(4 downto 0);
            
            PC_Write         : out std_logic;
            PC_reset         : out std_logic;   
            ID_EX_Write      : out std_logic;
            ID_EX_reset      : out std_logic;
            IF_ID_Write      : out std_logic;
            IF_ID_reset      : out std_logic
      );
      
      end component;

    component multiplier
             port (
        operator1   : in std_logic_vector(31 downto 0);
        operator2   : in std_logic_vector(31 downto 0);
        product     : out std_logic_vector(63 downto 0)
    );
    
    end component;

    component Instruction_Mem_multi
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
    
    component Multiplexer_4to1 
    
    Port ( 
            
            muxIn0 : in STD_LOGIC_VECTOR(31 downto 0);
            muxIn1 : in STD_LOGIC_VECTOR(31 downto 0);
            muxIn2 : in STD_LOGIC_VECTOR(31 downto 0);
            Selector : in STD_LOGIC_VECTOR(1 downto 0);
            muxOut : out STD_LOGIC_VECTOR(31 downto 0)
            
          );
    end component;


    signal PCOutPlus                                            : std_logic_vector(31 downto 0);    --data out from PC register
    signal PC_IF ,PC_ID, PC_EX, PC_MEM, PC_WB       : std_logic_vector(31 downto 0);
    signal instruction_IF_in                                    : std_logic_vector(31 downto 0);  
    signal instruction                                          : std_logic_vector(31 downto 0);    
    signal PCIn                                                 : std_logic_vector(31 downto 0);    --PC updated
    
    

    signal toRegister_ID_IN, Branch_ID_IN, ALUOp_ID_IN          :std_logic_vector(2 downto 0); 
    signal memWrite_ID_IN, memRead_ID_IN                        :std_logic;
    signal StoreSel_ID_IN, ALUSrc_ID_IN                         :std_logic;
    signal writeReg_ID_IN, halfselect_ID_IN, jump_ID_IN         :std_logic;
    signal regData1_ID_IN,regData2_ID_IN                        :std_logic_vector(31 downto 0); 
    signal immediate_ID_IN                                      :std_logic_vector(31 downto 0);
    signal destinyReg_ID_IN                                     :std_logic_vector(4 downto 0); 
         
    signal resultMul_EX_IN, result_EX_IN, Datain_EX_IN          :std_logic_vector(31 downto 0);     
    signal Branch_EX_IN, toRegister_EX_IN                       :std_logic_vector(2 downto 0);
    signal MemRead_EX_IN, MemWrite_EX_IN, writeReg_EX_IN        :std_logic;
    signal destinyReg_EX_IN                                     :std_logic_vector(4 downto 0);
    
    
    
    signal regData1,regData2                                    : std_logic_vector(31 downto 0);    --data readed from register file    
    signal signo, zero, carry                                   : std_logic;
    signal immediate                                            : std_logic_vector(31 downto 0);    --immediate generated
    signal jump,halfselect                                      : std_logic;
    signal StoreSel, ALUSrc                                     : std_logic;
    signal Branch, ALUOp                                        : std_logic_vector(2 downto 0);
    signal op2                                                  : std_logic_vector(31 downto 0);    --operator for ALU(output from mux)
    signal offset                                               : std_logic_vector(31 downto 0);    --PC+immediate after shift or result(jal)
    signal regData2Anded                                        : std_logic_vector(31 downto 0);
    signal mulOut                                               : std_logic_vector(63 downto 0);
    signal mulOutUpper, mulOutLower                             : std_logic_vector(31 downto 0);
    signal newAddress                                           : std_logic_vector(31 downto 0);
    signal shifted                                               : std_logic_vector(31 downto 0);
    
    signal resultMul_MEM_IN,result_MEM_IN, DataOut_MEM_in       : std_logic_vector(31 downto 0);
    signal ToRegister_MEM_IN                                    : std_logic_vector(2 downto 0);
    signal writeReg_MEM_IN                                      : std_logic;
    signal destinyReg_MEM_IN                                    : std_logic_vector(4 downto 0);
    
    signal dataIn                                               : std_logic_vector(31 downto 0);    --alu result and data in to memory
    signal memRead, memWrite                                    : std_logic;

    signal dataOut, result                                      : std_logic_vector(31 downto 0);    --data from memory
    signal dataForReg                                           : std_logic_vector(31 downto 0);    --data to be written in register File
    signal resultMul                                            : std_logic_vector(31 downto 0);
    
    signal toRegister                                           : std_logic_vector(2 downto 0);
    signal writeReg, PCSrc                                      : std_logic;
    signal destinyReg                                           : std_logic_vector(4 downto 0);
    
    signal sourceReg1_EX_out, sourceReg2_EX_out                 : std_logic_vector(4 downto 0);
    
    signal forwardA, forwardB                                   : std_logic_vector(1 downto 0);
    
    signal dataForReg_EX_MEM                                    : std_logic_vector(31 downto 0);
    
    signal muxOutforwardA, muxOutforwardB                       : std_logic_vector(31 downto 0);
    
    signal PC_Write ,PC_reset, ID_EX_Write,ID_EX_reset          : std_logic;    
    signal IF_ID_Write, IF_ID_reset                             : std_logic;
           
    
    
    
begin
    
    PCount: PC port map (
    
             clk => clk
            ,rst => rst
            ,enable => PC_Write
            ,PCIn => PCIn
            ,PCOut => PC_IF
            
    );
    
    IF_ID_stage: if_id port map (
    
            instruction_if_in => instruction_IF_in 
            ,PC_if_in => PC_IF
            
            ,clk => clk
            ,rst => IF_ID_reset
            ,enable => IF_ID_write
            
            ,instruction_id_out => instruction 
            ,PC_id_out => PC_ID
    
    ); 
       
    ID_EX_stage: ID_EX port map ( 
    
        	 PC_ID_in              => PC_ID 
            ,Branch_ID_in          => Branch_ID_in
            ,MemRead_ID_in         => MemRead_ID_in
            ,ToRegister_ID_in      => ToRegister_ID_in
            ,ALUOp_ID_in           => ALUOp_ID_in
            ,MemWrite_ID_in        => MemWrite_ID_in
            ,ALUSrc_ID_in          => ALUSrc_ID_in
            ,jump_ID_in            => jump_ID_in
            ,StoreSel_ID_in        => StoreSel_ID_in
            ,halfselect_ID_in      => halfselect_ID_in
            ,writeReg_ID_in        => writeReg_ID_in
            ,readData1_ID_in       => regData1_ID_in  
            ,readData2_ID_in       => regData2_ID_in
            ,sourceReg1_ID_in      => instruction(19 downto 15)
            ,sourceReg2_ID_in      => instruction(24 downto 20)
            ,immediate_ID_in       => immediate_ID_in
            ,destinyReg_ID_in      => instruction(11 downto 7)
            
            ,clk				   => clk
		    ,rst				   => ID_EX_Reset
		    ,enable				   => ID_EX_write
            
            ,PC_EX_out             => PC_EX
            ,Branch_EX_out         => Branch
            ,MemRead_EX_out        => MemRead_EX_IN
            ,ToRegister_EX_out     => ToRegister_EX_IN
            ,ALUOp_EX_out          => ALUOp
            ,MemWrite_EX_out       => MemWrite_EX_IN
            ,ALUSrc_EX_out         => ALUSrc
            ,jump_EX_out           => jump
            ,StoreSel_EX_out       => StoreSel
            ,halfselect_EX_out     => halfselect
            ,writeReg_EX_out       => writeReg_EX_IN
            ,readData1_EX_out      => RegData1     
            ,readData2_EX_out      => RegData2
            ,sourceReg1_EX_out     => sourceReg1_EX_out
            ,sourceReg2_EX_out     => sourceReg2_EX_out
            ,immediate_EX_out      => immediate
            ,destinyReg_EX_out     => destinyReg_EX_IN
    
    ); 
    
    forw_unit: Forwarding_Unit  Port map (
 
        
         EX_MEM_destinyReg => DestinyReg_Mem_in
        ,MEM_WB_destinyReg => DestinyReg
        ,EX_MEM_WriteReg   => WriteReg_MEM_in
        ,MEM_WB_WriteReg   => writeReg
        ,ID_EX_ReadReg1    => sourceReg1_EX_out
        ,ID_EX_ReadReg2    => sourceReg2_EX_out
        
        ,forwardA          => forwardA
        ,forwardB          => forwardB 
            
     );
     
    Hazard_unit: component Hazard_Detection_Unit Port map ( 
    
             PCSrc            => PCSrc
            ,ID_EX_Mem_read   => MemRead_EX_IN
            ,ID_EX_DestinyReg => destinyReg_EX_IN
            ,IF_ID_ReadReg1   => instruction(19 downto 15)
            ,IF_ID_ReadReg2   => instruction(24 downto 20)
            
            ,PC_Write         => PC_Write
            ,PC_reset         => PC_reset
            ,ID_EX_Write      => ID_EX_Write
            ,ID_EX_reset      => ID_EX_reset
            ,IF_ID_Write      => IF_ID_Write
            ,IF_ID_reset      => IF_ID_reset
            
      );
     
     Mux_forwardA: Multiplexer_4to1  Port map ( 
     
            muxIn0 => RegData1
           ,muxIn1 => dataForReg_EX_MEM
           ,muxIn2 => dataForReg
           ,Selector => forwardA
           ,muxOut => muxOutforwardA
    );
     Mux_forwardB: Multiplexer_4to1  Port map ( 
     
            muxIn0 => RegData2
           ,muxIn1 => dataForReg_EX_MEM
           ,muxIn2 => dataForReg
           ,Selector => forwardB
           ,muxOut => muxOutforwardB
    );
    
    
    EX_MEM_stage: EX_MEM port map (
             PC_EX_in              => PC_EX 
            ,resultMul_EX_in       => resultMul_EX_in
            ,result_EX_in          => result_EX_in
            ,DataIn_EX_in          => DataIn_EX_in
            ,MemRead_EX_in         => MemRead_EX_in
            ,ToRegister_EX_in      => ToRegister_EX_in
            ,MemWrite_EX_in        => MemWrite_EX_in
            ,writeReg_Ex_in        => writeReg_Ex_in
            ,DestinyReg_Ex_in      => DestinyReg_Ex_in

            ,clk				   =>  clk
		    ,rst				   =>  rst
		    ,enable				   =>  '1'
		    
            ,PC_MEM_out            =>  PC_MEM  
            ,resultMul_Mem_out     =>  resultMul_Mem_IN
            ,result_MEM_out        =>  result_MEM_IN
            ,DataIn_Mem_out        =>  DataIn
            ,MemRead_MEM_out       =>  MemRead
            ,ToRegister_MEM_out    =>  ToRegister_MEM_IN
            ,MemWrite_MEM_out      =>  MemWrite
            ,writeReg_MEM_out      =>  writeReg_MEM_in
            ,DestinyReg_MEM_out    =>  DestinyReg_MEM_IN
    );
    
    MEM_WB_stage: MEM_WB port map(
        
        
             PC_MEM_in              => PC_MEM
            ,resultMul_MEM_in       => resultMul_MEM_in
            ,result_MEM_in          => result_MEM_in  
            ,DataOut_MEM_in         => DataOut_MEM_in
            ,ToRegister_MEM_in      => ToRegister_MEM_in
            ,writeReg_MEM_in        => writeReg_MEM_in
            ,destinyReg_MEM_in      => destinyReg_MEM_IN

            
            ,clk					=> clk
		    ,rst					=> rst
		    ,enable				    => '1'
		    
            ,PC_WB_out              => PC_WB
            ,resultMul_WB_out       => resultMul
            ,result_WB_out          => result
            ,DataOut_WB_out         => DataOut
            ,ToRegister_WB_out      => ToRegister
            ,writeReg_WB_out        => writeReg
            ,destinyReg_WB_out      => destinyReg    
         );
        
               
    ROM: Instruction_Mem_multi port map (Address => PC_IF(15 downto 0), instruction => instruction_IF_in);

    RFILE: Reg_File port map (clk => clk, writeReg => writeReg, sourceReg1 => instruction(19 downto 15),
    sourceReg2 => instruction(24 downto 20), destinyReg => destinyReg, data => dataForReg,
    readData1 => regData1_ID_IN, readData2 => regData2_ID_IN);
    
    -- wat is de relatie tussen het signaal offset en het signaal immediate?? 
    Mux0: Mux port map (muxIn0 => offset, muxIn1 => muxOutforwardB, selector => ALUSrc, muxOut => op2);
    
    ALU: ALU_RV32 port map (operator1 => muxOutforwardA, operator2 => op2, ALUOp => ALUOp, 
    result => result_EX_IN, zero => zero, carryOut => carry, signo => signo);

    Mux1: Mux port map (muxIn0 => muxOutforwardB, muxIn1 => regData2Anded, selector => StoreSel, muxOut => dataIn_EX_IN);
    
    Mul: multiplier port map (operator1 => muxOutforwardA, operator2 => muxOutforwardB, product => mulOut);
    
    Mux4: Mux port map (muxIn0 => mulOutLower, muxIn1 => mulOutUpper, selector => halfselect, muxOut => resultMul_EX_IN);
    
    RAM: Data_Mem port map (clk => clk, writeEn => MemWrite, Address => result_MEM_IN(7 downto 0),
     dataIn => dataIn, dataOut => DataOut_MEM_in, readEn => MemRead);

    BRControl: Branch_Control port map (branch => Branch, signo => signo,
     zero => zero,PCSrc => PCSrc);
    
    MuxReg: Mux_ToRegFile port map (muxIn0 => result, muxIn1 => DataOut, muxIn2 => DataOut, muxIn3 => PC_WB,
    muxIn4 => resultMul, muxIn5 => PCOutPlus, selector => ToRegister, muxOut => dataForReg);
    
    MuxReg_MEM: Mux_ToRegFile port map (muxIn0 => result_MEM_in, muxIn1 => DataOut_MEM_In , muxIn2 => DataOut_MEM_In, muxIn3 => PC_MEM,
    muxIn4 => resultMul_MEM_In, muxIn5 => PCOutPlus, selector => ToRegister_MEM_In, muxOut => dataForReg_EX_MEM);

    Ctrl: Control port map (opcode => instruction(6 downto 0), funct3 => instruction(14 downto 12), funct7 => instruction(31 downto 25),
    jump => jump_ID_IN, MemWrite => memWrite_ID_IN, Branch => Branch_ID_IN, ALUOp => ALUOp_ID_IN, StoreSel => StoreSel_ID_IN, ALUSrc => ALUSrc_ID_IN, 
    WriteReg => WriteReg_ID_IN, ToRegister => toRegister_ID_IN, halfselect => halfselect_ID_in, MemRead => memRead_ID_IN );

    Mux2: Mux port map (muxIn0 => immediate, muxIn1 => result_EX_IN, selector => jump, muxOut => offset);

    Mux3: Mux port map (muxIn0 => PCOutPlus, muxIn1 => newAddress, selector => PCSrc, muxOut => PCIn);
    
    Imm: Immediate_Generator port map (instruction => instruction, immediate => immediate_ID_IN);
    

    
    
    
    mulOutUpper <= mulOut(63 downto 32);
    mulOutLower <= mulOut(31 downto 0);
    regData2Anded <= muxOutforwardB and X"000000FF";
    PCOutPlus <= PC_IF + 4;
    shifted <= offset(30 downto 0) & '0';
    newAddress <= PC_EX + shifted;
    ALU_result <= result_EX_IN;

end architecture arch_DataPath;
