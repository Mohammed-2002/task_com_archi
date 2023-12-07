-- if you like to program your own code, just use following website to translate the instruction
-- https://luplab.gitlab.io/rvcodecjs/ 	 	  
-- this site DOES not work for branching!!	
--	https://venus.cs61c.org/ does work!

---- In this file the instruction are hardcoded
---- During the course it showed that this should be saved into SRAM, but to make it easier we hardcode it here

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Mem is
    port (
        Address     :in std_logic_vector(15 downto 0);
        instruction :out std_logic_vector(31 downto 0) 
    );
end entity Instruction_Mem;

architecture arch_Instruction_Mem of Instruction_Mem is
    
    type ROM_ARRAY is array (0 to 65535) of std_logic_vector(7 downto 0);      --declaring size of memory. 128 elements of 32 bits
    constant ROM : ROM_ARRAY := (  
		X"00",X"00",X"00",X"93",  --addi x1, x0, 0 #i = 0                                PC 00
		X"01",X"40",X"02",X"13",  --addi x4, x0, 20 #matrix 1 ==> 20 elements            PC 04
		X"00",X"F0",X"02",X"93",  --addi x5, x0, 15 #matrix 2 ==> 15 elements            PC 08
		X"00",X"20",X"0F",X"93",  --addi x31, x0, 2 #shift for word address              PC 0C
		
		
		
		------ loopm1
		X"01",X"F0",X"91",X"33",  --sll x2, x1, x31 #i --> word address  (no SSLI)       PC 10
		X"00",X"10",X"80",X"93",  --addi x1,x1,1 #i+1                                    PC 14
		X"00",X"11",X"20",X"23",  --sw x1, 0(x2)                                         PC 18
		X"FE",X"12",X"1A",X"E3",  --bne x4, x1, loop_m1                                  PC 1C
		X"00",X"00",X"03",X"93",  --addi x7, x0, 0 #j                                    PC 20
		------ loop m2
		X"01",X"F0",X"91",X"33",  --sll x2, x1, x31 #i --> word address  (no SSLI)       PC 24
		X"00",X"10",X"80",X"93",  -- addi x1, x1, 1  #i = i+1                            PC 28
		X"40",X"72",X"84",X"33",  -- sub x8, x5, x7                                      PC 2C
		X"00",X"13",X"83",X"93",  -- addi x7, x7, 1  #j=j+1                              PC 30
		X"00",X"81",X"20",X"23",  -- sw x8, 0(x2)                                        PC 34
		X"FE",X"72",X"96",X"E3",  -- bne x5, x7, loop_m2                                 PC 38
		
		X"00",X"04",X"84",X"93",  --addi x9, x9, 0                                       PC 3C
		X"00",X"15",X"05",X"13",  --addi x10, x10, 1                                     PC 40
		X"00",X"00",X"0A",X"13",  --addi x20, x0, 0 #I input address starting point      PC 44
		X"05",X"00",X"0A",X"93",  --addi x21, x0, 80 #W input address starting point     PC 48 
		X"08",X"C0",X"0B",X"13",  --addi x22, x0, 0 #O output address starting point     PC 4C
		X"00",X"50",X"02",X"13",  --addi x4, x0, 5 C loop size                           PC 50             
		X"00",X"30",X"02",X"93",  --addi x5, x0, 3 K loop size                           PC 54
		X"00",X"40",X"05",X"93",  --addi x11, x0, 4 B loop size                          PC 58
		X"00",X"00",X"0B",X"93",  --addi x23, x0, 0 C loop index starts with 0           PC 5C
		X"00",X"00",X"0C",X"13",  --addi x24, x0, 0  K loop index starts with 0          PC 60
		X"00",X"00",X"0C",X"93",  --addi x25, x0, 0  B loop index starts with 0          PC 64
		X"00",X"00",X"05",X"13",  --addi x10, x0, 0  #acc result                         PC 68
		X"00",X"10",X"0D",X"93",   --addi x27, x0, 1  ##program start                    PC 6C
		----- START COUNTING CYCLES FROM HERE -----------
		--- INSERT YOUR CODE HERE
		



		----- STOP COUNTING CYCLES -----------
		X"00",X"00",X"0D",X"93",   --addi x27, x0, 0  #indication of program end!        PC 
		others => X"00"	
    );
begin
    instruction <= ROM(conv_integer(Address)) & ROM(conv_integer(Address + 1)) &
                   ROM(conv_integer(Address + 2)) & ROM(conv_integer(Address + 3)); 
    --instruction <= ROM(conv_integer(Address + 3)) & ROM(conv_integer(Address + 2))
      --           & ROM(conv_integer(Address + 1)) & ROM(conv_integer(Address));
 

end architecture arch_Instruction_Mem;	
	
	
	 