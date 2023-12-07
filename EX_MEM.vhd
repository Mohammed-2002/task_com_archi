----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2023 13:08:29
-- Design Name: 
-- Module Name: EX_MEM - Behavioral
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

entity EX_MEM is
--  Port ( );
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
end EX_MEM;

architecture Behavioral of EX_MEM is

begin
	process(clk)
	begin
		if rising_edge(clk) then 	
			if rst = '0' then        
                PC_MEM_out             <= X"00000000";
                resultMul_Mem_out      <= X"00000000";
                result_MEM_out         <= X"00000000";
                DataIn_Mem_out         <= X"00000000";
                MemRead_MEM_out        <= '0';
                ToRegister_MEM_out     <= "000";
                MemWrite_MEM_out       <= '0';
                writeReg_MEM_out       <= '0';
                DestinyReg_MEM_out     <= "00000";
			 elsif enable = '1' then
                PC_MEM_out             <= PC_EX_in;
                resultMul_Mem_out      <= resultMul_EX_in;
                result_MEM_out         <= result_EX_in;
                DataIn_Mem_out         <= DataIn_EX_in;
                MemRead_MEM_out        <= MemRead_EX_in;
                ToRegister_MEM_out     <= ToRegister_EX_in;
                MemWrite_MEM_out       <= MemWrite_EX_in;
                writeReg_MEM_out       <= writeReg_Ex_in;
                DestinyReg_MEM_out     <= DestinyReg_Ex_in;
            end if;
       end if;
     end process;

end Behavioral;
