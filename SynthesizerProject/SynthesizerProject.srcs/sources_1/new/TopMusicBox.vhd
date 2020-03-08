----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2019 03:09:50 PM
-- Design Name: 
-- Module Name: TopMusicBox - Behavioral
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

entity TopMusicBox is
    Port ( Mode: in std_logic_vector(1 downto 0);
    
           N: in STD_LOGIC_VECTOR(11 downto 0);
           Octave :in STD_LOGIC;
           output : out STD_LOGIC;
           Clock: in std_logic;
           Reset: in std_logic;
           Display: out std_logic_vector(6 downto 0);
           Digit: out std_logic_vector(3 downto 0);
--           amp: signed(9 downto 0);
           
           
           but: in std_logic;
           bdt: in std_logic
           );
end TopMusicBox;

architecture Behavioral of TopMusicBox is
---------------ADSR Parameters------------
signal Attack, Decay, Sustain, Release: integer;

signal t: integer;

--------------Mode Parameters------------
signal Dis1: std_logic_vector(6 downto 0);
signal Dis2: std_logic_vector(6 downto 0);
signal Dig1: std_logic_vector(3 downto 0);
signal Dig2: std_logic_vector(3 downto 0);

signal S: std_logic_vector(1 downto 0);
signal Notes: std_logic_vector(11 downto 0);
signal bu: std_logic;
signal bd: std_logic;
begin

m1: entity work.Mode1 port map ( Notes, Octave, output, Clock, Reset, Dis1, Dig1 , t);
m2: entity work.Mode2 port map (S, bu, bd, t, Clock, Reset, Dis2, Dig2, Attack, Decay, Sustain, Release);

process(Clock)
begin
    case Mode is
    when "00" =>    Display <= Dis1;
                    Digit <= Dig1;
                    Notes <= N;
                    S <= "00";
                    bu <= '0';
                    bd <= '0';
    when "01" =>    Display <= Dis2;
                    Digit <= Dig2;
                    Notes <= "000000000000";
                    S <= N(11 downto 10);
                    bu <= but;
                    bd <= bdt;
    when others => Display <= "0000000";
                    Digit <= "0000";
                    Notes <= N;
                    S <= "00";
                    bu <= '0';
                    bd <= '0';
    end case;
end process;
end Behavioral;
