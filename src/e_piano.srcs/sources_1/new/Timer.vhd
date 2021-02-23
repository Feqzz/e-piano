library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Timer is
    generic (
           N: integer := 24;     -- number of bits -- before 26
           M: integer := 9523808); -- mod-M -- before: 38461538
    Port ( timer_on : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           timer_done : out STD_LOGIC);
end Timer;

architecture Behavioral of Timer is

signal r_reg: unsigned (N-1 downto 0);
signal r_next: unsigned (N-1 downto 0);

begin

 -- register
   process(clk, rst, timer_on)
   begin
      if (rst = '1' or timer_on = '0') then
         r_reg <= (others => '0');
      elsif (rising_edge(clk) and timer_on = '1') then
         r_reg <= r_next;
      end if;
   end process;
   
   -- next-state logic
   r_next <= (others => '0') when r_reg=(M-1) else
             r_reg + 1;
             
   -- output logic
   timer_done <= '1' when r_reg=(M-1) else '0';

end Behavioral;

