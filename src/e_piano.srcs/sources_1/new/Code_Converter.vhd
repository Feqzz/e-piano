library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Code_Converter is
    Port ( cin : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR (9 downto 0));
end Code_Converter;

architecture Behavioral of Code_Converter is

signal int_cout, int_cin : Integer;

begin

int_cin <= to_integer(unsigned(cin));

int_cout <= 261 when int_cin = 97 else
            277 when int_cin = 103 else
            293 when int_cin = 115 else
            311 when int_cin = 101 else
            329 when int_cin = 100 else
            349 when int_cin = 102 else
            369 when int_cin = 116 else
            391 when int_cin = 103 else
            415 when int_cin = 121 else
            440 when int_cin = 104 else
            466 when int_cin = 117 else
            493 when int_cin = 106 else
            523 when int_cin = 65 else
            554 when int_cin = 87 else
            587 when int_cin = 83 else
            622 when int_cin = 69 else
            659 when int_cin = 68 else
            698 when int_cin = 70 else
            739 when int_cin = 84 else
            783 when int_cin = 71 else
            830 when int_cin = 89 else
            880 when int_cin = 72 else
            923 when int_cin = 85 else
            987 when int_cin = 74;

cout <= std_logic_vector(to_unsigned(int_cout, 10));

end Behavioral;
