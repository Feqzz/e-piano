----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2021 05:20:03 PM
-- Design Name: 
-- Module Name: New_Mod_M_Counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity New_Mod_M_Counter is
    Port ( cin : in STD_LOGIC_VECTOR (17 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           max_tick : out STD_LOGIC);
end New_Mod_M_Counter;

architecture Behavioral of New_Mod_M_Counter is

signal r_reg: unsigned (17 downto 0);
signal r_next: unsigned (17 downto 0);

begin

process(clk, rst)
begin
    if (rst = '1') then
        r_reg <= (others => '0');
    elsif (rising_edge(clk)) then
        r_reg <= r_next;
    end if;
end process;

-- next-state logic
r_next <= (others => '0') when r_reg =  unsigned(cin) - 1 else
         r_reg + 1;
-- output logic

max_tick <= '1' when r_reg = unsigned(cin) - 1 else '0';

end Behavioral;
