library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity uart is
   generic(
     -- Default setting:
     -- 19,200 baud, 8 data bis, 1 stop its, 2^2 FIFO
     DBIT: integer:=8;     -- # data bits
      SB_TICK: integer:=16; -- # ticks for stop bits, 16/24/32
                            --   for 1/1.5/2 stop bits
      DVSR: integer:= 326;  -- baud rate divisor
                            -- DVSR = 50M/(16*baud rate)
      DVSR_BIT: integer:=9 -- # bits of DVSR
   );
   port(
      clk, reset: in std_logic;
      rx: in std_logic;
      rx_done: out std_logic;
      r_data: out std_logic_vector(7 downto 0)
   );
end uart;
architecture str_arch of uart is
   signal tick: std_logic;
   signal rx_done_tick: std_logic;
   signal rx_data_out: std_logic_vector(7 downto 0);
   signal led_reg, led_next : std_logic_vector(7 downto 0);
begin
   baud_gen_unit: entity work.mod_m_counter(arch)
      generic map(M=>DVSR, N=>DVSR_BIT)
      port map(clk=>clk, reset=>reset,
               q=>open, max_tick=>tick);
   uart_rx_unit: entity work.uart_rx(arch)
      generic map(DBIT=>DBIT, SB_TICK=>SB_TICK)
      port map(clk=>clk, reset=>reset, rx=>rx,
               s_tick=>tick, rx_done_tick=>rx_done_tick,
               dout=>rx_data_out);
      process(clk, reset)
      begin
         if(reset = '1') then
            led_reg <= (others => '0');
         elsif(rising_edge(clk)) then
            led_reg <= led_next;
         end if;
      end process;
      process(rx_done_tick, rx_data_out)
      begin
         if(rx_done_tick = '1') then
            led_next <= rx_data_out;
         else
            led_next <= led_reg;
         end if;
      end process;
      r_data <= rx_data_out;
      rx_done <= rx_done_tick;
end str_arch;