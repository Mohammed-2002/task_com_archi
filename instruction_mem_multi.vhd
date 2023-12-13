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
                X"00",X"00",X"00",X"93",
                X"01",X"40",X"02",X"13",
                X"00",X"F0",X"02",X"93",
                X"00",X"20",X"0F",X"93",
                X"01",X"F0",X"91",X"33",
                X"00",X"10",X"80",X"93",
                X"00",X"61",X"01",X"B3",
                X"00",X"11",X"A0",X"23",
                X"FE",X"12",X"18",X"E3",
                X"00",X"00",X"03",X"93",
                X"01",X"F0",X"91",X"33",
                X"00",X"10",X"80",X"93",
                X"40",X"72",X"84",X"33",
                X"00",X"13",X"83",X"93",
                X"FE",X"72",X"98",X"E3",
                X"00",X"00",X"0A",X"13",
                X"05",X"00",X"0A",X"93",
                X"08",X"C0",X"0B",X"13",
                X"00",X"50",X"02",X"13",
                X"00",X"30",X"02",X"93",
                X"00",X"40",X"05",X"93",
                X"00",X"00",X"0B",X"93",
                X"00",X"00",X"0C",X"13",
                X"00",X"00",X"0C",X"93",
                X"00",X"00",X"05",X"13",
                X"00",X"10",X"0D",X"93",
                X"00",X"0A",X"22",X"83",
                X"00",X"4A",X"23",X"03",
                X"00",X"8A",X"23",X"83",
                X"00",X"CA",X"24",X"03",
                X"01",X"0A",X"28",X"03",
                X"00",X"0A",X"AE",X"83",
                X"00",X"4A",X"A8",X"83",
                X"00",X"8A",X"A9",X"03",
                X"00",X"CA",X"A9",X"83",
                X"01",X"0A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"20",X"23",
                X"00",X"00",X"05",X"13",
                X"01",X"4A",X"AE",X"83",
                X"01",X"8A",X"A8",X"83",
                X"01",X"CA",X"A9",X"03",
                X"02",X"0A",X"A9",X"83",
                X"02",X"4A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"22",X"23",
                X"00",X"00",X"05",X"13",
                X"02",X"8A",X"AE",X"83",
                X"02",X"CA",X"A8",X"83",
                X"03",X"0A",X"A9",X"03",
                X"03",X"4A",X"A9",X"83",
                X"03",X"8A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"24",X"23",
                X"00",X"00",X"05",X"13",
                X"01",X"4A",X"22",X"83",
                X"01",X"8A",X"23",X"03",
                X"01",X"CA",X"23",X"83",
                X"02",X"0A",X"24",X"03",
                X"02",X"4A",X"28",X"03",
                X"00",X"0A",X"AE",X"83",
                X"00",X"4A",X"A8",X"83",
                X"00",X"8A",X"A9",X"03",
                X"00",X"CA",X"A9",X"83",
                X"01",X"0A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"26",X"23",
                X"00",X"00",X"05",X"13",
                X"01",X"4A",X"AE",X"83",
                X"01",X"8A",X"A8",X"83",
                X"01",X"CA",X"A9",X"03",
                X"02",X"0A",X"A9",X"83",
                X"02",X"4A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"28",X"23",
                X"00",X"00",X"05",X"13",
                X"02",X"8A",X"AE",X"83",
                X"02",X"CA",X"A8",X"83",
                X"03",X"0A",X"A9",X"03",
                X"03",X"4A",X"A9",X"83",
                X"03",X"8A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"2A",X"23",
                X"00",X"00",X"05",X"13",
                X"02",X"8A",X"22",X"83",
                X"02",X"CA",X"23",X"03",
                X"03",X"0A",X"23",X"83",
                X"03",X"4A",X"24",X"03",
                X"03",X"8A",X"28",X"03",
                X"00",X"0A",X"AE",X"83",
                X"00",X"4A",X"A8",X"83",
                X"00",X"8A",X"A9",X"03",
                X"00",X"CA",X"A9",X"83",
                X"01",X"0A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"2C",X"23",
                X"00",X"00",X"05",X"13",
                X"01",X"4A",X"AE",X"83",
                X"01",X"8A",X"A8",X"83",
                X"01",X"CA",X"A9",X"03",
                X"02",X"0A",X"A9",X"83",
                X"02",X"4A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"00",X"AB",X"2E",X"23",
                X"00",X"00",X"05",X"13",
                X"02",X"8A",X"AE",X"83",
                X"02",X"CA",X"A8",X"83",
                X"03",X"0A",X"A9",X"03",
                X"03",X"4A",X"A9",X"83",
                X"03",X"8A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"AB",X"20",X"23",
                X"00",X"00",X"05",X"13",
                X"03",X"CA",X"22",X"83",
                X"04",X"0A",X"23",X"03",
                X"04",X"4A",X"23",X"83",
                X"04",X"8A",X"24",X"03",
                X"04",X"CA",X"28",X"03",
                X"00",X"0A",X"AE",X"83",
                X"00",X"4A",X"A8",X"83",
                X"00",X"8A",X"A9",X"03",
                X"00",X"CA",X"A9",X"83",
                X"01",X"0A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"AB",X"22",X"23",
                X"00",X"00",X"05",X"13",
                X"01",X"4A",X"AE",X"83",
                X"01",X"8A",X"A8",X"83",
                X"01",X"CA",X"A9",X"03",
                X"02",X"0A",X"A9",X"83",
                X"02",X"4A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"AB",X"24",X"23",
                X"00",X"00",X"05",X"13",
                X"02",X"8A",X"AE",X"83",
                X"02",X"CA",X"A8",X"83",
                X"03",X"0A",X"A9",X"03",
                X"03",X"4A",X"A9",X"83",
                X"03",X"8A",X"AE",X"03",
                X"02",X"5E",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"68",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"79",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"89",X"8F",X"33",
                X"01",X"E5",X"05",X"33",
                X"03",X"0E",X"0F",X"33",
                X"01",X"E5",X"05",X"33",
                X"02",X"AB",X"26",X"23",
                X"00",X"00",X"0D",X"93",
                        others => X"00"
    );
begin
    instruction <= ROM(conv_integer(Address)) & ROM(conv_integer(Address + 1)) &
                   ROM(conv_integer(Address + 2)) & ROM(conv_integer(Address + 3)); 
    --instruction <= ROM(conv_integer(Address + 3)) & ROM(conv_integer(Address + 2))
      --           & ROM(conv_integer(Address + 1)) & ROM(conv_integer(Address));
 

end architecture arch_Instruction_Mem_multi;
 