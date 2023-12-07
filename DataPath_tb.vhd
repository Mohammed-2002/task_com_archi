library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity DataPath_tb is

end entity DataPath_tb;

-------------------------------------------------------------------------------

architecture arch_Datapath of DataPath_tb is

  -- component ports
  signal clk       : std_logic  := '0';
  signal rst       : std_logic  := '0';

  constant clk_period : time := 50 ns;

begin  -- architecture arch_Datapath

  -- component instantiation
  DUT: entity work.DataPath
    port map (
      clk       => clk,
      rst       => rst
      );

  clk_generation : process
  begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
  end process ; -- clk_generation

  -- waveform generation
  WaveGen_Proc: process
  begin
    wait for clk_period;
    rst <= '1';
    wait;
  end process WaveGen_Proc;

end architecture arch_Datapath;

-------------------------------------------------------------------------------

configuration DataPath_tb_arch_Datapath_cfg of DataPath_tb is
  for arch_Datapath
  end for;
end DataPath_tb_arch_Datapath_cfg;

-------------------------------------------------------------------------------
