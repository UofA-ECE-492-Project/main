--! \file topmodule_tb.vhd
--! \author Charles Ancheta
--! @cond Doxygen_Suppress
library ieee;
use ieee.std_logic_1164.all;
use std.env.stop;
--! @endcond

--! Test bench for the top module.
entity topmodule_tb is
end topmodule_tb;

architecture test_bench of topmodule_tb is
  signal clk   : std_ulogic := '0';
  signal gpio  : std_ulogic_vector (31 downto 0);
  signal reset : std_ulogic := '1';
  signal done  : std_ulogic := '0';
begin
  drive_clock : process
  begin
    clk <= not clk;
    wait for 10.6383 ns;
  end process drive_clock;

  stop_exec : process(done)
  begin
    if done = '1' then
      stop;
    end if;
  end process stop_exec;

  topmodule_inst : entity work.topmodule(rtl) port map (
    clk   => clk,
    gpio  => gpio,
    done  => done,
    reset => reset);
  process
  begin
    wait for 10.6383 ns;
    reset <= '0';
    wait for 10.6383 ns;
    reset <= '1';
    wait for 10.6383 ns;
    reset <= '0';
    wait for 10.6383 ns;
    reset <= '1';
    wait;
  end process;
end test_bench;
