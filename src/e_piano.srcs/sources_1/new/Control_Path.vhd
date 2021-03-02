----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/22/2021 04:27:10 PM
-- Design Name: 
-- Module Name: Control_Path - Behavioral
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

entity Control_Path is
    Port ( play : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           rx_done : in STD_LOGIC;
           ascii_r : in STD_LOGIC_VECTOR (7 downto 0);
           clr_counter : out STD_LOGIC;
           inc_counter : out STD_LOGIC;
           ram_write : out STD_LOGIC;
           ascii_t : in STD_LOGIC_VECTOR (7 downto 0);
           td_on : out STD_LOGIC;
           td_done : in STD_LOGIC;
           function_out : out STD_LOGIC;
           mute : out STD_LOGIC);
end Control_Path;

architecture Behavioral of Control_Path is

    type FSM is (IDLE, RECORDING, WRITING, PLAYING);
    signal state_reg, state_next : FSM;
    signal int_value : Integer;


-- function asciiIsValid(value : STD_LOGIC_VECTOR (7 downto 0)) return BOOLEAN is
--     variable int_value : Integer := to_integer(unsigned(value));
-- begin
--     return (
--     int_value = 97 or -- a
--     int_value = 119 or -- w
--     int_value = 115 or -- s
--     int_value = 101 or -- e
--     int_value = 100 or -- d
--     int_value = 102 or -- f
--     int_value = 116 or -- t
--     int_value = 103 or -- g
--     int_value = 121 or -- y
--     int_value = 104 or -- h
--     int_value = 117 or -- u
--     int_value = 106 or -- j
--     int_value = 65 or -- A
--     int_value = 87 or -- W
--     int_value = 83 or -- S
--     int_value = 69 or -- E
--     int_value = 68 or -- D
--     int_value = 70 or -- F
--     int_value = 84 or -- T
--     int_value = 71 or -- G
--     int_value = 89 or -- Y
--     int_value = 72 or -- H
--     int_value = 85 or -- U
--     int_value = 74 or -- J
--     int_value = 112 or --p
--     int_value = 32 or --space
--     int_value = 120); --x
-- end function;
begin
    process (clk, rst)
    begin
        if (rst = '1') then
            state_reg <= IDLE;
        elsif rising_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;

    int_value <= to_integer(unsigned(ascii_r));

    process (state_reg, ascii_r, rx_done, play, td_done)
    begin
        state_next <= state_reg;
        mute <= '0';
        td_on <= '0';
        ram_write <= '0';
        inc_counter <= '0';
        clr_counter <= '0';

        case state_reg is
            when IDLE =>
                clr_counter <= '1';
                if (rx_done = '1') then
                    if (ascii_r = "01111000") then -- the ascii value is 'x'
                        state_next <= RECORDING;
                    else
                        ram_write <= '1';
                    end if;
                end if;
            when RECORDING =>
                if (play = '1') then
                    clr_counter <= '1';
                    state_next <= PLAYING;
                else
                    if (rx_done = '1') then
                        state_next <= WRITING;
                        inc_counter <= '1';
                    end if;
                end if;
            --Writes currect note to ram
            when WRITING =>
                ram_write <= '1';
                state_next <= RECORDING;
            when PLAYING =>
                if (play = '1') then
                    if (ascii_t = "11111111") then --empty ram value
                        clr_counter <= '1';
                    else
                        if (ascii_t = "01110000") then -- ascii p which means pause
                            mute <= '1';
                            td_on <= '1';
                            if (td_done = '1') then
                                inc_counter <= '1';
                            end if;
                        else
                            td_on <= '1';
                            if (td_done = '1') then
                                inc_counter <= '1';
                            end if;
                        end if;
                    end if;
                else
                    state_next <= IDLE;
                end if;
            when others =>

        end case;

    end process;

end Behavioral;
