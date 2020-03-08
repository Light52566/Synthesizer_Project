----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2019 09:07:27 PM
-- Design Name: 
-- Module Name: Mode2 - Behavioral
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

entity Mode2 is
    Port ( S: in std_logic_vector(1 downto 0);
           bu: in std_logic;
           bd: in std_logic;
           t: inout integer;
           Clock: in std_logic;
           Reset: in std_logic;
           Display: out std_logic_vector(6 downto 0);
           Digit: out std_logic_vector(3 downto 0);
           Attack, Decay, Sustain, Release: inout integer:= 1);
           
end Mode2;

architecture Behavioral of Mode2 is

-------------------ADSR Settings-----------------
--signal Attack, Decay, Sustain, Release: unsigned(3 downto 0):= "0001";

---------------------For Display-----------------
signal R1: std_logic_vector(3 downto 0);
signal R2: std_logic_vector(3 downto 0);
signal R3: std_logic_vector(3 downto 0);
signal R4: std_logic_vector(3 downto 0);


begin
--------------------ADSR Display--------------------
Display2: entity work.segmentDisplay port map( R1, R2, R3, R4, Clock, Reset, Display, Digit);
------------------------ADSR------------------------
ADSR: entity work.Timer port map(Attack, Decay, Sustain, Release, Clock, t, bu, bd);

---------------------ADSR Select--------------------
process(bu, bd)
begin
    if(rising_edge(bu) or rising_edge(bd)) then
    case S is
    when "00" => if(bu = '1' and Attack < 4) then Attack <= Attack + 1;   --A
                 end if;
                 if(bd = '1' and Attack > 1) then Attack <= Attack - 1;
                 end if;
    when "01" => if(bu = '1' and Decay < 4) then Decay <= Decay + 1;      --D
                 end if;
                 if(bd = '1' and Decay > 1) then Decay <= Decay - 1;
                 end if;
    when "10" => if(bu = '1' and Sustain < 4) then Sustain <= Sustain + 1;--S
                 end if;
                 if(bu = '1' and Sustain > 1) then Sustain <= Sustain - 1;
                 end if;
    when others=>if(bu = '1' and Release < 4) then Release <= Release + 1;--R
                 end if;
                 if(bu = '1' and Release > 1) then Release <= Release - 1;
                 end if;
    end case;
    end if;
    

    
end process;


-------------------Display and ADSR limit check-----------------
process(Clock)
begin
    if(rising_edge(clock)) then
    case S is
    when "00" => R3 <= "1010"; --a
                 R1 <= std_logic_vector(to_unsigned(Attack, 4));
    when "01" => R3 <= "1101"; --d
                 R1 <= std_logic_vector(to_unsigned(Decay, 4));
    when "10" => R3 <= "0101"; --s
                 R1 <= std_logic_vector(to_unsigned(Sustain, 4));
    when others=>R3 <= "0111"; --r
                 R1 <= std_logic_vector(to_unsigned(Sustain, 4));
    end case;
    end if;
    
    if( Attack > 4) then Attack <= 4;
    elsif( Attack < 1) then Attack <= 1;
    elsif( Release > 4) then Release <= 4;
    elsif( Release < 1) then Release <= 1;
    elsif( Sustain > 4) then Sustain <= 4;
    elsif( Sustain < 1) then Sustain <= 1;
    elsif( Decay > 4) then Decay <= 4;
    elsif( Decay < 1) then Decay <= 1;
    end if;
end process;

end Behavioral;
