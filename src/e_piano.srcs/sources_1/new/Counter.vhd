----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2021 02:00:58 PM
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity Counter is
    Port ( increment : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR (5 downto 0));
end Counter;

architecture Behavioral of Counter is

signal q_reg, q_next : unsigned (5 downto 0) := (others => '0');

begin

process (clk, rst)
begin
    if (rst = '1') then
        q_reg <= (others => '0');
    elsif (rising_edge(clk)) then
        if(increment = '1') then
            q_reg <= q_next;
        end if;
    end if;
end process;

q_next <= (others => '0') when q_reg = 64-1 else
                  q_reg + 1;

cout <= STD_LOGIC_VECTOR(q_reg);

end Behavioral;
