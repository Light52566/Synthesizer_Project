----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2019 12:44:32 AM
-- Design Name: 
-- Module Name: Timer - Behavioral
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

entity Timer is
    Port ( Attack, Decay, Sustain, Release: integer;
           Clock: in std_logic;
           t: inout integer;
           bu, bd: std_logic);
end Timer;

architecture Behavioral of Timer is

signal unit_time: unsigned(24 downto 0);
signal counter: integer:=0;
signal ti: integer;

begin
process(Clock)
begin
    if(rising_edge(Clock) and (bu = '0') and (bd = '0')) then
        unit_time <= unit_time + 1;
        if(unit_time = to_unsigned(0, 25)) then
        counter <= counter + 1;
            if(counter < Attack) then
                ti <= ti + (24 / Attack);
--            end if; 
            elsif(counter < Decay) then
                ti <= ti - (12 / Decay);
--            end if;
            elsif((counter < Release) and (counter >= Sustain)) then
                ti <= ti - (12 / Release);
            end if;
            if(counter > Attack + Sustain + Decay + Release) then
                counter <= 0;
            end if;
        end if;
        t <= ti;
    end if;
end process;

end Behavioral;
