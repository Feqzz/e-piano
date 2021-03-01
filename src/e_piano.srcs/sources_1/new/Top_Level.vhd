----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2021 05:29:28 PM
-- Design Name: 
-- Module Name: Top_Level - Behavioral
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

entity Top_Level is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           rxd : in STD_LOGIC;
           play : in STD_LOGIC;
           LED: out std_logic_vector(7 downto 0);
           max_tick_counter : out STD_LOGIC;
           function_out : out STD_LOGIC;
           music : out STD_LOGIC);
end Top_Level;

architecture Behavioral of Top_Level is

signal internal_uart_out : STD_LOGIC_VECTOR (7 downto 0);
signal internal_ram_out : STD_LOGIC_VECTOR (7 downto 0);
signal internal_counter_address : STD_LOGIC_VECTOR (9 downto 0);
signal internal_code_converter_out : STD_LOGIC_VECTOR (17 downto 0);
signal internal_rx_done, internal_counter_increment, internal_ram_write, internal_timer_on,
    internal_timer_done, internal_mod_m_counter_max_tick, internal_mute, internal_counter_clear : STD_LOGIC;

begin

uart: entity work.UART(str_arch)
port map (clk => clk, reset => rst, rx => rxd, r_data => internal_uart_out, rx_done => internal_rx_done);

counter: entity work.Counter(Behavioral)
port map (increment => internal_counter_increment, clk => clk, rst => internal_counter_clear, cout => internal_counter_address);

ram: entity work.RAM(Behavioral)
port map (address => internal_counter_address, cin => internal_uart_out, cout => internal_ram_out,
    write => internal_ram_write, clk => clk, rst => rst);
    
LED <= internal_ram_out;

timer: entity work.Timer(Behavioral)
port map (timer_on => internal_timer_on, clk => clk, rst => rst, timer_done => internal_timer_done);


code_converter: entity work.Code_Converter(Behavioral)
port map (cin => internal_ram_out, clk => clk, rst => rst, cout => internal_code_converter_out);

mod_m_counter: entity work.New_Mod_M_Counter(Behavioral)
port map (cin => internal_code_converter_out, clk => clk, rst => rst, max_tick => internal_mod_m_counter_max_tick);

toggle_flip_flop: entity work.Toggle_Flip_Flop(Behavioral)
port map (mute => internal_mute, tick => internal_mod_m_counter_max_tick, q => music);

control_path: entity work.Control_Path(Behavioral)
port map (play => play, clk => clk, rst => rst, rx_done => internal_rx_done, ascii_r => internal_uart_out,
    clr_counter => internal_counter_clear, inc_counter => internal_counter_increment, ram_write => internal_ram_write,
    ascii_t => internal_ram_out, td_on => internal_timer_on, td_done => internal_timer_done, mute => internal_mute, function_out => function_out);


max_tick_counter <= internal_mod_m_counter_max_tick;


end Behavioral;
