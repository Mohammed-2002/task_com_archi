library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Reg_File is
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
end entity Reg_File;

architecture arch_Reg_File of Reg_File is

    type Mem is array(0 to 31) of std_logic_vector(31 downto 0);    --Mem is an array of 32 registers of 32 bits
    signal registers : Mem := (others => (others => '0'));          --registers is a Mem

begin
    process(clk, writeReg, sourceReg1, sourceReg2, destinyReg, data, registers)
    begin
        if falling_edge(clk) then
            if writeReg = '1' and destinyReg /= "00000" then
                registers(conv_integer(destinyReg)) <= data;
            end if;
        end if;
    end process;
    
            readData1 <= registers(conv_integer(sourceReg1)) when sourceReg1 /= "00000" else (others => '0');
            readData2 <= registers(conv_integer(sourceReg2)) when sourceReg2 /= "00000" else (others => '0');
            
end arch_Reg_File ; -- arch_Reg_File