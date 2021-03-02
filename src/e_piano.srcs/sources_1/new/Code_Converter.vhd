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
           cout : out STD_LOGIC_VECTOR (17 downto 0));
end Code_Converter;

architecture Behavioral of Code_Converter is

signal int_cout, int_cin : Integer;

begin

int_cin <= to_integer(unsigned(cin));

int_cout <= 191570 when int_cin = 97 else --261  100,000,000/2*261
            180505 when int_cin = 119 else -- 277
            170648 when int_cin = 115 else -- 293
            160771 when int_cin = 101 else -- 311
            151975 when int_cin = 100 else -- 329
            143266 when int_cin = 102 else -- 349
            135501 when int_cin = 116 else -- 369
            127877 when int_cin = 103 else -- 391
            120481 when int_cin = 121 else -- 415
            113636 when int_cin = 104 else -- 440
            107296 when int_cin = 117 else -- 466
            101419 when int_cin = 106 else -- 493
            95602 when int_cin = 65 else -- 523
            90252 when int_cin = 87 else -- 554
            85178 when int_cin = 83 else -- 587
            80385 when int_cin = 69 else -- 622
            75872 when int_cin = 68 else -- 659
            71633 when int_cin = 70 else -- 698
            67658 when int_cin = 84 else -- 739
            63856 when int_cin = 71 else -- 783
            60240 when int_cin = 89 else -- 830
            56818 when int_cin = 72 else -- 880
            54171 when int_cin = 85 else -- 923
            50658 when int_cin = 74 else -- 987
            191570; --Cannot be zero, because of counter counts to n-1 

cout <= std_logic_vector(to_unsigned(int_cout, 18));

end Behavioral;
