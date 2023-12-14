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

                    X"00",X"00",X"00",X"93", --addi x1 x0 0
                    X"01",X"40",X"02",X"13", --addi x4 x0 20
                    X"00",X"F0",X"02",X"93", --addi x5 x0 15
                    X"00",X"20",X"0F",X"93", --addi x31 x0 2
                    X"01",X"F0",X"91",X"33", --sll x2 x1 x31
                    X"00",X"10",X"80",X"93", --addi x1 x1 1
                    X"00",X"61",X"01",X"B3", --add x3 x2 x6
                    X"00",X"11",X"A0",X"23", --sw x1 0(x3)
                    X"FE",X"12",X"18",X"E3", --bne x4 x1 -16
                    X"00",X"00",X"03",X"93", --addi x7 x0 0
                    X"01",X"F0",X"91",X"33", --sll x2 x1 x31
                    X"00",X"10",X"80",X"93", --addi x1 x1 1
                    X"40",X"72",X"84",X"33", --sub x8 x5 x7
                    X"00",X"13",X"83",X"93", --addi x7 x7 1
                    X"FE",X"72",X"98",X"E3", --bne x5 x7 -16
                    X"00",X"00",X"0A",X"13", --addi x20 x0 0
                    X"05",X"00",X"0A",X"93", --addi x21 x0 80
                    X"08",X"C0",X"0B",X"13", --addi x22 x0 140
                    X"00",X"50",X"02",X"13", --addi x4 x0 5
                    X"00",X"30",X"02",X"93", --addi x5 x0 3 
                    X"00",X"40",X"05",X"93", --addi x11 x0 4
                    X"00",X"00",X"0B",X"93", --addi x23 x0 0
                    X"00",X"00",X"0C",X"13", --addi x24 x0 0
                    X"00",X"00",X"0C",X"93", --addi x25 x0 0
                    X"00",X"00",X"05",X"13", --addi x10 x0 0 
                    X"00",X"10",X"0D",X"93", --addi x27 x0 1
                    X"00",X"0A",X"22",X"83", --lw x5 0(x20)
                    X"00",X"4A",X"23",X"03", --lw x6 4(x20)
                    X"00",X"8A",X"23",X"83", --lw x7 8(x20)
                    X"00",X"CA",X"24",X"03", --lw x8 12(x20)
                    X"01",X"0A",X"28",X"03", --lw x16 16(x20)
                    X"00",X"0A",X"AE",X"83", --lw x29 0(x21) 
                    X"00",X"4A",X"A8",X"83", --lw x17 4(x21) 
                    X"00",X"8A",X"A9",X"03", --lw x18 8(x21)
                    X"00",X"CA",X"A9",X"83", --lw x19 12(x21)
                    X"01",X"0A",X"AE",X"03", --lw x28 16(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8 
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"20",X"23", --sw x10 0(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0 
                    X"01",X"4A",X"AE",X"83", --lw x29 20(x21)
                    X"01",X"8A",X"A8",X"83", --lw x17 24(x21)
                    X"01",X"CA",X"A9",X"03", --lw x18 28(x21)
                    X"02",X"0A",X"A9",X"83", --lw x19 32(x21)
                    X"02",X"4A",X"AE",X"03", --lw x28 36(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"22",X"23", --sw x10 4(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"02",X"8A",X"AE",X"83", --lw x29 40(x21)
                    X"02",X"CA",X"A8",X"83", --lw x17 44(x21)
                    X"03",X"0A",X"A9",X"03", --lw x18 48(x21) 
                    X"03",X"4A",X"A9",X"83", --lw x19 52(x21)
                    X"03",X"8A",X"AE",X"03", --lw x28 56(x21) 
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"24",X"23", --sw x10 8(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"01",X"4A",X"22",X"83", --lw x5 20(x20)
                    X"01",X"8A",X"23",X"03", --lw x6 24(x20)
                    X"01",X"CA",X"23",X"83", --lw x7 28(x20)
                    X"02",X"0A",X"24",X"03", --lw x8 32(x20)
                    X"02",X"4A",X"28",X"03", --lw x16 36(x20)
                    X"00",X"0A",X"AE",X"83", --lw x29 0(x21)
                    X"00",X"4A",X"A8",X"83", --lw x17 4(x21)
                    X"00",X"8A",X"A9",X"03", --lw x18 8(x21)
                    X"00",X"CA",X"A9",X"83", --lw x19 12(x21)
                    X"01",X"0A",X"AE",X"03", --lw x28 16(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"26",X"23", --sw x10 12(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"01",X"4A",X"AE",X"83", --lw x29 20(x21)
                    X"01",X"8A",X"A8",X"83", --lw x17 24(x21)
                    X"01",X"CA",X"A9",X"03", --lw x18 28(x21)
                    X"02",X"0A",X"A9",X"83", --lw x19 32(x21)
                    X"02",X"4A",X"AE",X"03", --lw x28 36(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"28",X"23", --sw x10 16(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"02",X"8A",X"AE",X"83", --lw x29 40(x21)
                    X"02",X"CA",X"A8",X"83", --lw x17 44(x21)
                    X"03",X"0A",X"A9",X"03", --lw x18 48(x21)
                    X"03",X"4A",X"A9",X"83", --lw x19 52(x21)
                    X"03",X"8A",X"AE",X"03", --lw x28 56(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"2A",X"23", --sw x10 20(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"02",X"8A",X"22",X"83", --lw x5 40(x20)
                    X"02",X"CA",X"23",X"03", --lw x6 44(x20)
                    X"03",X"0A",X"23",X"83", --lw x7 48(x20)
                    X"03",X"4A",X"24",X"03", --lw x8 52(x20)
                    X"03",X"8A",X"28",X"03", --lw x16 56(x20)
                    X"00",X"0A",X"AE",X"83", --lw x29 0(x21)
                    X"00",X"4A",X"A8",X"83", --lw x17 4(x21)
                    X"00",X"8A",X"A9",X"03", --lw x18 8(x21)
                    X"00",X"CA",X"A9",X"83", --lw x19 12(x21)
                    X"01",X"0A",X"AE",X"03", --lw x28 16(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"2C",X"23", --sw x10 24(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"01",X"4A",X"AE",X"83", --lw x29 20(x21)
                    X"01",X"8A",X"A8",X"83", --lw x17 24(x21)
                    X"01",X"CA",X"A9",X"03", --lw x18 28(x21)
                    X"02",X"0A",X"A9",X"83", --lw x19 32(x21)
                    X"02",X"4A",X"AE",X"03", --lw x28 36(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"00",X"AB",X"2E",X"23", --sw x10 28(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"02",X"8A",X"AE",X"83", --lw x29 40(x21)
                    X"02",X"CA",X"A8",X"83", --lw x17 44(x21)
                    X"03",X"0A",X"A9",X"03", --lw x18 48(x21)
                    X"03",X"4A",X"A9",X"83", --lw x19 52(x21)
                    X"03",X"8A",X"AE",X"03", --lw x28 56(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"AB",X"20",X"23", --sw x10 32(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"03",X"CA",X"22",X"83", --lw x5 60(x20)
                    X"04",X"0A",X"23",X"03", --lw x6 64(x20)
                    X"04",X"4A",X"23",X"83", --lw x7 68(x20)
                    X"04",X"8A",X"24",X"03", --lw x8 72(x20)
                    X"04",X"CA",X"28",X"03", --lw x16 76(x20)
                    X"00",X"0A",X"AE",X"83", --lw x29 0(x21)
                    X"00",X"4A",X"A8",X"83", --lw x17 4(x21)
                    X"00",X"8A",X"A9",X"03", --lw x18 8(x21)
                    X"00",X"CA",X"A9",X"83", --lw x19 12(x21)
                    X"01",X"0A",X"AE",X"03", --lw x28 16(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"AB",X"22",X"23", --sw x10 36(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"01",X"4A",X"AE",X"83", --lw x29 20(x21)
                    X"01",X"8A",X"A8",X"83", --lw x17 24(x21)
                    X"01",X"CA",X"A9",X"03", --lw x18 28(x21)
                    X"02",X"0A",X"A9",X"83", --lw x19 32(x21)
                    X"02",X"4A",X"AE",X"03", --lw x28 36(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"AB",X"24",X"23", --sw x10 40(x22)
                    X"00",X"00",X"05",X"13", --addi x10 x0 0
                    X"02",X"8A",X"AE",X"83", --lw x29 40(x21)
                    X"02",X"CA",X"A8",X"83", --lw x17 44(x21)
                    X"03",X"0A",X"A9",X"03", --lw x18 48(x21)
                    X"03",X"4A",X"A9",X"83", --lw x19 52(x21)
                    X"03",X"8A",X"AE",X"03", --lw x28 56(x21)
                    X"02",X"5E",X"8F",X"33", --mul x30 x29 x5
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"68",X"8F",X"33", --mul x30 x17 x6
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"79",X"0F",X"33", --mul x30 x18 x7
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"89",X"8F",X"33", --mul x30 x19 x8
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"03",X"0E",X"0F",X"33", --mul x30 x28 x16
                    X"01",X"E5",X"05",X"33", --add x10 x10 x30
                    X"02",X"AB",X"26",X"23", --sw x10 44(x22)
                    X"00",X"00",X"0D",X"93", --addi x27 x0 0
                            others => X"00"
                         --X"40",X"30",X"81",X"33"
                         --,X"00",X"51",X"76",X"33"
                         --,X"00",X"23",X"66",X"B3"
                         --,X"00",X"21",X"07",X"33"
                         --,X"06",X"F1",X"22",X"23" 
                         --,others => X"00"
                        --  0x0	0x40308133	sub x2 x1 x3	sub x2, x1,x3
                        --0x4	0x00517633	and x12 x2 x5	and x12,x2,x5
                        --0x8	0x002366B3	or x13 x6 x2	or x13,x6,x2
                        --0xc	0x00210733	add x14 x2 x2	add x14,x2,x2
                        --0x10	0x06F12223	sw x15 100(x2)	sw x15,100(x2)

                         
    );
begin
    instruction <= ROM(conv_integer(Address)) & ROM(conv_integer(Address + 1)) &
                   ROM(conv_integer(Address + 2)) & ROM(conv_integer(Address + 3)); 
    --instruction <= ROM(conv_integer(Address + 3)) & ROM(conv_integer(Address + 2))
      --           & ROM(conv_integer(Address + 1)) & ROM(conv_integer(Address));
 

end architecture arch_Instruction_Mem_multi;
 