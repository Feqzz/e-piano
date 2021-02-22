----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2021 02:14:05 PM
-- Design Name: 
-- Module Name: RAM - Behavioral
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

entity RAM is
    Port ( address : in STD_LOGIC_VECTOR (9 downto 0);
           cin : in STD_LOGIC_VECTOR (7 downto 0);
           cout : out STD_LOGIC_VECTOR (7 downto 0);
           write : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC);
end RAM;

architecture Behavioral of RAM is

type memory is array (0 to 1023) of std_logic_vector (7 downto 0);
signal ram : memory := (others => (others => '1'));

begin

process (clk, rst, write)
begin
    if (rst = '1') then
        ram <= (others => (others =>'1'));
    elsif (rising_edge(clk)) then
        if (write = '1') then
            ram(to_integer(unsigned(address))) <= cin;
        end if;
    end if;
end process;

cout <= ram(to_integer(unsigned(address)));

end Behavioral;
