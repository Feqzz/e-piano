----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2021 05:26:10 PM
-- Design Name: 
-- Module Name: Toggle_Flip_Flop - Behavioral
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

entity Toggle_Flip_Flop is
    Port ( mute : in STD_LOGIC;
           tick : in STD_LOGIC;
           q : out STD_LOGIC);
end Toggle_Flip_Flop;

architecture Behavioral of Toggle_Flip_Flop is

signal music : STD_LOGIC := '0';

begin

process (mute, tick)
begin
    if (mute = '1') then
        music <= '0';
    elsif (rising_edge(tick)) then
        music <= not music;
    end if;
end process;

q <= music;

end Behavioral;
