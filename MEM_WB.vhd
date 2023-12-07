----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2023 12:45:58
-- Design Name: 
-- Module Name: MEM_WB - Behavioral
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

entity MEM_WB is
        Port (
        
            PC_MEM_in             :in std_logic_vector(31 downto 0);
            resultMul_MEM_in      :in std_logic_vector(31 downto 0);
            result_MEM_in         :in std_logic_vector(31 downto 0);    
            DataOut_MEM_in        :in std_logic_vector(31 downto 0);
            ToRegister_MEM_in     :in std_logic_vector(2 downto 0);
            writeReg_MEM_in       :in std_logic;
            destinyReg_MEM_in        :in std_logic_vector(4 downto 0);

            
            clk					  :in std_logic;
		    rst					  :in std_logic;
		    enable				  :in std_logic;
		    
            PC_WB_out            :out std_logic_vector(31 downto 0);
            resultMul_WB_out     :out std_logic_vector(31 downto 0);
            result_WB_out        :out std_logic_vector(31 downto 0);
            DataOut_WB_out       :out std_logic_vector(31 downto 0);
            ToRegister_WB_out    :out std_logic_vector(2 downto 0);
            writeReg_WB_out      :out std_logic;
            destinyReg_WB_out       :out std_logic_vector(4 downto 0)
    
         );
end MEM_WB;

architecture Behavioral of MEM_WB is

begin

    process(clk)
    begin
        if rising_edge(clk) then     
            if rst = '0' then        
                PC_WB_out             <= X"00000000";
                resultMul_WB_out      <= X"00000000";
                result_WB_out         <= X"00000000";
                DataOut_WB_out        <= X"00000000";
                ToRegister_WB_out     <= "000";
                writeReg_WB_out       <= '0';
                destinyReg_WB_out        <= "00000";
            elsif enable = '1' then
                PC_WB_out             <= PC_MEM_in;
                resultMul_WB_out      <= resultMul_MEM_in;
                result_WB_out         <= result_MEM_in;
                DataOut_WB_out        <= DataOut_MEM_in;
                ToRegister_WB_out     <= ToRegister_MEM_in;
                writeReg_WB_out       <= writeReg_MEM_in;
                destinyReg_WB_out        <= destinyReg_MEM_in;
            end if;
        end if;
    end process;

end Behavioral;
