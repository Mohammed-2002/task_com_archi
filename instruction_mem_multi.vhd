-- if you like to program your own code, just use following website to translate the instruction
-- https://luplab.gitlab.io/rvcodecjs/ 	 	  
-- this site DOES not work for branching!!

---- In this file the instruction are hardcoded
---- During the course it showed that this should be saved into SRAM, but to make it easier we hardcode it here

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Mem_multi is
    port (
        Address     :in std_logic_vector(15 downto 0);
        instruction :out std_logic_vector(31 downto 0) 
    );
end entity Instruction_Mem_multi;

architecture arch_Instruction_Mem_multi of Instruction_Mem_multi is
    
    type ROM_ARRAY is array (0 to 65535) of std_logic_vector(7 downto 0);      --declaring size of memory. 128 elements of 32 bits
    constant ROM : ROM_ARRAY := (
        -----------START LABEL:
 --       "00000000","01110000","10000000","10010011",    --addi x1,x1,0x0     PC:  00H
        "00000000","00110000","10000000","10010011",    --addi x1,x1,3	       00   -- I select Fact program to test the MUL!
        "00000000","00010000","00000000","00100011",    --sb x1,0(x0)          04
        "00000000","01000001","00000001","00010011",    --addi x2, x2, 4       08
        "00000000","00010001","10000001","10010011",    --addi x3,x3,1         0C
        "00000000","00100010","00000010","00010011",    --addi x4,x4,2         10
        "00000000","00110010","10000010","10010011",    --addi x5,x5,3         14
        ------------PICK LABEL:
        "00000000","00000000","00100000","10000011",    --lw x1, 0(x0)         		18 
        "00111111","11110000","11110000","10010011",    --andi x1,x1,0x00003FF		1C
        "00000000","00110000","10001000","01100011",    --beq x1,x3, INSTRUCTIONS	20	 
        "00000110","01000000","10001110","01100011",    --beq x1,x4, BEGIN_FIBB		24	 beq x1, x4, 124 	(address A0 (160dec) - 24 (36dec))
        "00001110","01010000","10000000","01100011",    --beq x1,x5, BEGIN_FACT 	28	 beq x1, x5, 224 	(address 108 (264dec) - 28 (40dec))
        "11111110","11011111","11110000","01101111",    --jal x0, PICK				2C
        -------------INSTRUCTIONS LABEL:
        "00000000","01000000","00100000","10000011",			-- 30
        "00000000","00010001","00000001","00010011",			-- 34
        "00000000","00010001","01110001","00010011",			-- 38
        "11111110","00100000","11001010","11100011",			-- 3C
        "00000000","00110000","10000000","10010011",			-- 40
        "00000000","00010000","10000000","00100011",			-- 44
        "00000000","00100011","10000011","10010011",			-- 48
        "01000000","01110000","10000001","10110011",			-- 4C
        "00000000","00110000","00000001","00100011",			-- 50
        "00000000","11110010","00000010","00010011",			-- 54
        "00000000","00010010","01110010","00110011",			-- 58
        "00000000","01000000","00000001","10100011",			-- 5C
        "00000000","00000011","01110010","10010011",			-- 60
        "00000000","01110011","01000010","10110011",			-- 64
        "00000000","01110011","01000010","10010011",			-- 68
        "00000000","01110011","01100010","10110011",			-- 6C
        "00000000","01110011","01100010","10010011",			-- 70
        "00000000","01110011","00010010","10110011",			-- 74
        "00000000","01110011","01010010","10110011",			-- 78
        "00000000","01110011","00100010","10110011",			-- 7C
        "00000000","00110000","10000000","00100011",			-- 80
        "00000000","01010000","00000001","00100011",			-- 84
        "00000000","01010001","10000001","00000011",			-- 88
        "00000000","01010001","10100010","00000011",			-- 8C
        "00000000","00110000","00000001","00010011",			-- 90
        "00000000","00010100","00000100","00010011",			-- 94
        "11111110","10000001","00011100","11100011",			-- 98
        "11110110","01011111","11110000","01101111",			-- 9C
--------------------FIBONACCI PROGRAM-------------------------------------------------------------
        "00000000","01000101","00000101","00010011",    -- addi x10,x10,4           address for load external inputs    A0H
        -----------BEGIN_FIBB LABEL:                             
        "00000000","00000101","00100000","10000011",    -- lw x1,0(x10)             load the inputs to X1               A4H
        "00111111","11110000","11110000","10010011",    -- andi x1,x1,0x00003FF     mask to keep only the switches      A8H              
        "00000000","00000001","01110001","00010011",    -- andi x2,x2, 0x0          cleaning x2                         ACH
        "11111110","00100000","10001010","11100011",    -- beq x1,x2, BEGIN_FIBB    If the number is 0 the progrma would't start B0H
        "00000000","00000001","11110001","10010011",    -- andi x3,x3, 0x0          second                              B4
		"00000000","00000010","01110010","00010011",    -- andi x4,x4, 0x0          next                                B8
        "00000000","00000010","11110010","10010011",    -- andi x5,x5, 0x0          cleaning previous value of C        BC
        "11111111","11110010","10000010","10010011",    -- starting C = -1                                              C0
        "00000000","00000011","11110011","10010011",    -- andi x7,x7, 0x0          cleaning X7                         C4
        "00000000","00100011","10000011","10010011",    -- addi x7,x7, 0x1          number 2                            C8
        "00000000","00010001","10000001","10010011",    -- addi x3,x3, 0x1          second = 1                          CC
        "00000000","00000100","01110100","00010011",    -- andi x8,x8, 0x0          cleaning register base              D0
        "00000000","00110100","10000100","10010011",    -- addi x9,x9, 0x3          top register                        D4
        -----------FIBONACCI LABEL:
        "00000000","00010010","10000010","10010011",    -- addi x5,x5,1             Increase C so starts in 0 and ++ in every loop D8
        "00000010","01110010","11000000","01100011",    -- blt x5,x7, NEXTC         if(x5(C) < x7(2)) NEXTC             DC
        "00000000","01110010","00000010","00110011",    -- add x4,x2,x3             else {next = first + second         E0
        "00000000","00000001","10000001","00010011",    -- addi x2,x3,0             first = second                      E4
        "00000000","00000010","00000001","10010011",    -- addi x3,x4,0             second = next}                      E8
        -----------PRINT LABEL:
        "00000000","01000100","00000000","00100011",    -- sb x4,0(x8)              store in address                    EC
        "00000000","00010100","00000100","00010011",    -- addi x8,x8,1             increase index in memory            F0
        "00000000","10010100","00001000","01100011",    -- beq x8,x9, END                                               F4
        "11111110","00010010","11000000","11100011",    -- blt x5,x1, FIBONACCI     if(C < n)                           F8
        ------------ NEXTC LABEL:
        "00000000","00000010","10000010","00010011",    -- addi x4,x5,0x0    next = C                                   FC
        "11111110","11011111","11110000","01101111",    -- jal x0, PRINT                                                100
        -------------END LABEL:
        "11110001","10011111","11110000","01101111",    -- jal x0, START												104
        ------------FACTORIAL PROGRAM--------------
        ------------BEGIN FACT:
        "00000000","00000010","01110010","00010011",    --andi x4, x4, 0	108
        "00000000","00010010","00000010","00010011",    --addi x4,x4, 1		10C
        "00000000","00000010","11110010","10010011",    --andi x5,x5,0		110
        "00000000","00010010","10000010","10010011",    --addi x5,x5,1		114
        "00000000","00000001","01110001","00010011",    --andi x2,x2, 0		118
        "00000000","01000001","00000001","00010011",    --addi x2,x2, 4		11C
        "00000000","00000000","00100000","10000011",    --lw x1, 0(x0)  	120
        "00000000","10100000","00000000","10010011",    --addi x1,x0,10     124	  -- it will be FACT(x1); x1 --> 10
        "00000000","00000001","11110001","10010011",    --andi x3,x3 0		128
        "00000000","00010001","10000001","10010011",    --addi x3,x3, 1		12C	  
        "11111100","00000000","10001110","11100011",    --beq x1,x0, BEGIN_FACT	  130
        ---------------FOR LABEL
        "00000010","01000001","10000001","10110011",    --mul x3,x3,x4	 	134
        "00000000","00010010","00000010","00010011",    --addi x4, x4, 1	138
        "11111110","00010010","01001100","11100011",    --bgt x1,x4, FOR	13C		
        "00000010","01000001","10000001","10110011",    --mul x3,x3,x4	 	140			
        "00000000","00110000","00100000","00100011",    --sw x3,0(x0)		144		-- check register x3 to evaluate the output of FACT!
        "00000000","00110010","10100000","00100011",    --sw x3,0(x5)		148		
		-------------- test MUL and MULH
		"00000010","00110001","10000011","00110011",    --mul x6,x3,x3	 	14C
		"00000010","00110001","10010011","10110011",    --mulh x7,x3,x3	 	150		   -- evaluate whether mulh and mul are working in reg x6, x7
--        "11101101","11011111","11110000","01101111",    --jal x0, START		154
        others => X"00"
    );
begin
    instruction <= ROM(conv_integer(Address)) & ROM(conv_integer(Address + 1)) &
                   ROM(conv_integer(Address + 2)) & ROM(conv_integer(Address + 3)); 
    --instruction <= ROM(conv_integer(Address + 3)) & ROM(conv_integer(Address + 2))
      --           & ROM(conv_integer(Address + 1)) & ROM(conv_integer(Address));
 

end architecture arch_Instruction_Mem_multi;
 