library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

-------------------------------------------------------------------------------

entity Mux_tb is

end entity Mux_tb;

-------------------------------------------------------------------------------

architecture arch_mux of Mux_tb is

  -- component ports
  signal muxIn0   : std_logic_vector(31 downto 0) := (others => '0');
  signal muxIn1   : std_logic_vector(31 downto 0) := (others => '0');
  signal selector : std_logic := '0';
  signal muxOut   : std_logic_vector(31 downto 0);

  constant period : time := 50 ns;

begin  -- architecture arch_mux

  -- component instantiation
  DUT: entity work.Mux
    port map (
      muxIn0   => muxIn0,
      muxIn1   => muxIn1,
      selector => selector,
      muxOut   => muxOut);

  -- waveform generation
  WaveGen_Proc: process
  begin
    wait for period;
    muxIn0 <= muxIn0 + 10;
    muxIn1 <= muxIn1 + 15;
    selector <= not selector;

  end process WaveGen_Proc;

  

end architecture arch_mux;

-------------------------------------------------------------------------------

configuration Mux_tb_arch_mux_cfg of Mux_tb is
  for arch_mux
  end for;
end Mux_tb_arch_mux_cfg;

-------------------------------------------------------------------------------
