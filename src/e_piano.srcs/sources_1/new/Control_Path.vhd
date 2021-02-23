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
--use IEEE.NUMERIC_STD.ALL;

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
           mute : out STD_LOGIC);
end Control_Path;

architecture Behavioral of Control_Path is

type FSM is (IDLE, RECORDING, PLAYING);
signal state_reg, state_next : FSM;

function asciiIsValid(value : STD_LOGIC_VECTOR (7 downto 0)) return BOOLEAN is
begin
    return (
        value = "01100001" or 
        value = "01100111" or
        value = "01110011" or 
        value = "01100101" or 
        value = "01100100" or 
        value = "01100110" or 
        value = "01110100" or 
        value = "01100111" or 
        value = "01111001" or 
        value = "01101000" or 
        value = "01110101" or 
        value = "01101010" or 
        value = "01000001" or 
        value = "01000111" or 
        value = "01010011" or 
        value = "01000101" or 
        value = "01000100" or 
        value = "01000110" or 
        value = "01010100" or 
        value = "01000111" or 
        value = "01011001" or 
        value = "01001000" or 
        value = "01010101" or 
        value = "01001010" or 
        value = "00100000");
end function;

begin

process (clk, rst)
begin
    if (rst = '1') then
        state_reg <= IDLE;
	elsif rising_edge(clk) then
		state_reg <= state_next;
	end if;
end process;

process (state_reg, rx_done, play, td_done)
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
                if (rx_done = '1' and asciiIsValid(ascii_r)) then
                    ram_write <= '1';
                    inc_counter <= '1';
                end if;
            end if;
        when PLAYING =>
            if (play = '1') then
                if (ascii_t = "11111111") then --empty ram value
                    clr_counter <= '1';
                else
                    if (ascii_t = "00100000") then -- ascii space which means pause
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
        end case;
                    
end process;

end Behavioral;
