----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2023 17:44:34
-- Design Name: 
-- Module Name: Forwarding_Unit - Behavioral
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

entity Forwarding_Unit is
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
end Forwarding_Unit;

architecture Behavioral of Forwarding_Unit is

begin
        process(EX_MEM_destinyReg, MEM_WB_destinyReg,
                ID_EX_ReadReg1, ID_EX_ReadReg2, EX_MEM_WriteReg,
                MEM_WB_WriteReg)
        begin
            if EX_MEM_WriteReg = '1' and EX_MEM_destinyReg /= "00000" then
                   if  EX_MEM_destinyReg = ID_EX_ReadReg1 then
            
                        forwardA <= "01";
                        forwardB <= "00";
                        
                    elsif EX_MEM_destinyReg = ID_EX_ReadReg2 then
                        
                        forwardA <= "00";
                        forwardB <= "01";
                   
                    else
                    
                       forwardA <= "00";
                       forwardB <= "00"; 
                    end if;                       
            elsif MEM_WB_WriteReg = '1' and MEM_WB_destinyReg /= "00000" then                 
                if MEM_WB_destinyReg = ID_EX_ReadReg1 then
                    
                    forwardA <= "11";
                    forwardB <= "00";
                    
                elsif MEM_WB_destinyReg = ID_EX_ReadReg2 then
                    
                    forwardA <= "00";
                    forwardB <= "11";
                    
                end if;
            end if;
       
     end process ;     
                
        

end Behavioral;
