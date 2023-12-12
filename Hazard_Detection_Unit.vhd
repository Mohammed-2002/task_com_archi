----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2023 10:13:15
-- Design Name: 
-- Module Name: Hazard_Detection_Unit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Hazard_Detection_Unit is
      Port ( 
            PCSrc            : in std_logic;
            IF_ID_ReadReg1   : in std_logic_vector(4 downto 0);
            IF_ID_ReadReg2   : in std_logic_vector(4 downto 0);
            ID_EX_Mem_read   : in std_logic;
            ID_EX_DestinyReg : in std_logic_vector(4 downto 0);

            
            PC_Write         : out std_logic;
            PC_reset         : out std_logic; 
            IF_ID_Write      : out std_logic;
            IF_ID_reset      : out std_logic;  
            ID_EX_Write      : out std_logic;
            ID_EX_reset      : out std_logic

      );
end Hazard_Detection_Unit;

architecture Behavioral of Hazard_Detection_Unit is

begin
    process(PCSrc, ID_EX_Mem_read, ID_EX_DestinyReg,IF_ID_ReadReg1,IF_ID_ReadReg2)
         begin            
            if  ID_EX_Mem_read = '1' then
                if  ID_EX_DestinyReg = IF_ID_ReadReg1 or ID_EX_DestinyReg = IF_ID_ReadReg2  then
                    PC_Write         <= '0';
                    PC_reset         <= '1'; 
                    IF_ID_Write      <= '0';
                    IF_ID_reset      <= '1';
                    ID_EX_Write      <= '0'; 
                    ID_EX_reset      <= '0';
                 
                 else 
                    PC_Write         <= '1';
                    PC_reset         <= '1'; 
                    IF_ID_Write      <= '1';
                    IF_ID_reset      <= '1';
                    ID_EX_Write      <= '1'; 
                    ID_EX_reset      <= '1';
                end if;
            elsif PCSrc = '1' then 
                    PC_Write         <= '1';
                    PC_reset         <= '1'; 
                    IF_ID_Write      <= '0';
                    IF_ID_reset      <= '0';
                    ID_EX_Write      <= '0'; 
                    ID_EX_reset      <= '0';
            else 
                    PC_Write         <= '1';
                    PC_reset         <= '1'; 
                    IF_ID_Write      <= '1';
                    IF_ID_reset      <= '1';
                    ID_EX_Write      <= '1'; 
                    ID_EX_reset      <= '1';
            end if;
         end process ; 
         
end Behavioral;
