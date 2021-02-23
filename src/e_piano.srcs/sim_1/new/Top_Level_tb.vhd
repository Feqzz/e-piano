----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2021 09:17:41 AM
-- Design Name: 
-- Module Name: Top_Level_tb - Behavioral
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

entity Top_Level_tb is
--  Port ( );
end Top_Level_tb;

architecture Behavioral of Top_Level_tb is

component Top_Level
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           rxd : in STD_LOGIC;
           play : in STD_LOGIC;
           music : out STD_LOGIC);
end component;

signal clk_tb, rst_tb, rxd_tb, play_tb, music_tb : STD_LOGIC;
constant clk_period : time := 10 ns;
constant bit_period : time := 52083ns; -- time for 1 bit.. 1bit/19200bps = 52.08 us

constant rx_data_ascii_a: std_logic_vector(7 downto 0) := x"61"; -- receive a
constant rx_data_ascii_J: std_logic_vector(7 downto 0) := x"4a"; -- receive b
constant rx_data_ascii_c: std_logic_vector(7 downto 0) := x"63"; -- receive c
constant rx_data_ascii_d: std_logic_vector(7 downto 0) := x"64"; -- receive d
constant rx_data_ascii_x: std_logic_vector(7 downto 0) := x"78"; -- receive e

begin

UUT: Top_Level
port map (clk => clk_tb, rst => rst_tb, rxd => rxd_tb, play => play_tb, music => music_tb);

process
begin
    clk_tb <= '0';
    wait for (clk_period / 2);
    clk_tb <= '1';
    wait for (clk_period / 2);
end process;

process
begin
    rxd_tb <= '1'; -- start bit = 0
    rst_tb <= '1';
    wait for clk_period*2;
    rst_tb <= '0';
    wait for clk_period*2;
            -- Test ASCII char m
            
    play_tb <= '0';
    rxd_tb <= '0'; -- start bit = 0
    wait for bit_period;
    for i in 0 to 7 loop
        rxd_tb <= rx_data_ascii_a(i);   -- 8 data bits
        wait for bit_period;
    end loop;
    rxd_tb <= '1'; -- stop bit = 1
   wait for 1ms;
   
   rxd_tb <= '0'; -- start bit = 0
    wait for bit_period;
    for i in 0 to 7 loop
        rxd_tb <= rx_data_ascii_J(i);   -- 8 data bits
        wait for bit_period;
    end loop;
    rxd_tb <= '1'; -- stop bit = 1
   wait for 1ms;
   
   rxd_tb <= '0'; -- start bit = 0
    wait for bit_period;
    for i in 0 to 7 loop
        rxd_tb <= rx_data_ascii_x(i);   -- 8 data bits
        wait for bit_period;
    end loop;
    rxd_tb <= '1'; -- stop bit = 1
   wait for 1ms;
   
   play_tb <= '0';
    rxd_tb <= '0'; -- start bit = 0
    wait for bit_period;
    for i in 0 to 7 loop
        rxd_tb <= rx_data_ascii_a(i);   -- 8 data bits
        wait for bit_period;
    end loop;
    rxd_tb <= '1'; -- stop bit = 1
   wait for 1ms;
   
   rxd_tb <= '0'; -- start bit = 0
    wait for bit_period;
    for i in 0 to 7 loop
        rxd_tb <= rx_data_ascii_J(i);   -- 8 data bits
        wait for bit_period;
    end loop;
    rxd_tb <= '1'; -- stop bit = 1
   wait for 1ms;
   
   play_tb <= '1';
   wait for 1ms;
   rst_tb <= '1';
   wait;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
--                    -- Test ASCII char a
--    rxd_tb <= '0';                      -- start bit = 0
--    wait for bit_period;
--    for i in 0 to 7 loop
--        rxd_tb <= rx_data_ascii_b(i);   -- 8 data bits
--        wait for bit_period;
--    end loop;
--    rxd_tb <= '1';                      -- stop bit = 1
--    wait for 1ms;
--                    -- Test ASCII char k
--    rxd_tb <= '0';                      -- start bit = 0
--    wait for bit_period;
--    for i in 0 to 7 loop
--        rxd_tb <= rx_data_ascii_c(i);   -- 8 data bits
--        wait for bit_period;
--    end loop;
--    rxd_tb <= '1';                      -- stop bit = 1
--    wait for 1ms;
--                    -- Test ASCII char e
--    rxd_tb <= '0';                      -- start bit = 0
--    wait for bit_period;
--    for i in 0 to 7 loop
--        rxd_tb <= rx_data_ascii_d(i);   -- 8 data bits
--        wait for bit_period;
--    end loop;
--    rxd_tb <= '1';                      -- stop bit = 1
--    wait for 1ms;
--                -- Test ACII Enter
--    rxd_tb <= '0';                      -- start bit = 0
--    wait for bit_period;
--    for i in 0 to 7 loop
--        rxd_tb <= rx_data_ascii_e(i);   -- 8 data bits
--        wait for bit_period;
--    end loop;
--    rxd_tb <= '1';                      -- stop bit = 1
--    wait;
end process;






end Behavioral;






