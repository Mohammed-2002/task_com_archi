----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2023 11:53:58
-- Design Name: 
-- Module Name: ID_EX - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID_EX is
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
end ID_EX;

architecture Behavioral of ID_EX is

begin	
	process(clk)
	begin
		if rising_edge(clk) then 	
			if rst = '0' then
			    PC_EX_out              <=  X"00000000";
                Branch_EX_out          <= "000";
                MemRead_EX_out         <= '0';
                ToRegister_EX_out      <= "000";
                ALUOp_EX_out           <= "000";
                MemWrite_EX_out        <= '0';
                ALUSrc_EX_out          <= '0';
                jump_EX_out            <= '0';
                StoreSel_EX_out        <= '0';
                halfselect_EX_out      <= '0';
                writeReg_EX_out        <= '0';
                readData1_EX_out       <= X"00000000";     
                readData2_EX_out       <= X"00000000";
                sourceReg1_EX_out      <= "00000";
                sourceReg2_EX_out      <= "00000";
                immediate_EX_out       <= X"00000000";
                destinyReg_EX_out      <= "00000";
                
			 elsif enable = '1' then
                PC_EX_out             <= PC_ID_in;
                Branch_EX_out         <= Branch_ID_in;
                MemRead_EX_out        <= MemRead_ID_in;
                ToRegister_EX_out     <= ToRegister_ID_in;
                ALUOp_EX_out          <= ALUOp_ID_in;
                MemWrite_EX_out       <= MemWrite_ID_in;
                ALUSrc_EX_out         <= ALUSrc_ID_in;
                jump_EX_out           <= jump_ID_in;
                StoreSel_EX_out       <= StoreSel_ID_in;
                halfselect_EX_out     <= halfselect_ID_in;
                writeReg_EX_out       <= writeReg_ID_in;
                readData1_EX_out      <= readData1_ID_in;
                readData2_EX_out      <= readData2_ID_in;
                sourceReg1_EX_out     <= sourceReg1_ID_in;
                sourceReg2_EX_out     <= sourceReg2_ID_in;
                immediate_EX_out      <= immediate_ID_in;
                destinyReg_EX_out     <= destinyReg_ID_in;
            end if;
       end if;
     end process;
end Behavioral;
