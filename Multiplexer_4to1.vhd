----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2023 09:56:43
-- Design Name: 
-- Module Name: Multiplexer_4to1 - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplexer_4to1 is
    Port ( muxIn0 : in STD_LOGIC_VECTOR(31 downto 0);
           muxIn1 : in STD_LOGIC_VECTOR(31 downto 0);
           muxIn2 : in STD_LOGIC_VECTOR(31 downto 0);
           Selector : in STD_LOGIC_VECTOR(1 downto 0);
           muxOut : out STD_LOGIC_VECTOR(31 downto 0));
end Multiplexer_4to1;

architecture Behavioral of Multiplexer_4to1 is
begin
    process (muxIn0, muxIn1, muxIn2, Selector)
    begin
        case Selector is
            when "00" =>
                muxOut <= muxIn0;
            when "01" =>
                muxOut <= muxIn1;
            when "10" =>
                muxOut <= muxIn2;
            when others =>
                muxOut <= (others => '0'); -- Default case, can be modified based on your requirements
        end case;
    end process;
end Behavioral;

