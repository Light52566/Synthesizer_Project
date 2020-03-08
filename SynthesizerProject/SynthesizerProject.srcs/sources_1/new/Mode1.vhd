----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/04/2019 01:15:53 AM
-- Design Name: 
-- Module Name: Mode1 - Behavioral
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

entity Mode1 is
    Port ( N : in STD_LOGIC_VECTOR(11 downto 0);
           Octave :in STD_LOGIC;
           output : out STD_LOGIC;
           Clock: in std_logic;
           Reset: in std_logic;
           Display: out std_logic_vector(6 downto 0);
           Digit: out std_logic_vector(3 downto 0);
           amp: inout integer);
end Mode1;

architecture Behavioral of Mode1 is
---------------------For Display----------------------
signal R1: std_logic_vector(3 downto 0);
signal R2: std_logic_vector(3 downto 0);
signal R3: std_logic_vector(3 downto 0);
signal R4: std_logic_vector(3 downto 0);

begin
Display1: entity work.segmentDisplay port map( R1, R2, R3, R4, Clock, Reset, Display, Digit);
Synth1: entity work.Synth port map(Clock, N, Octave, output, amp);

--------------------Display Select----------------
Process(Clock)
begin
    case N is
    when "000000000001" => R3 <= "1100";--c
                           R2 <= "0000";
    when "000000000010" => R3 <= "1100";--cs
                           R2 <= "0101"; 
    when "000000000100" => R3 <= "1101";--d
                           R2 <= "0000"; 
    when "000000001000" => R3 <= "1101";--ds
                           R2 <= "0101";
    when "000000010000" => R3 <= "1110";--e
                           R2 <= "0000";
    when "000000100000" => R3 <= "1111";--f
                           R2 <= "0000";
    when "000001000000" => R3 <= "1111";--fs
                           R2 <= "0101";
    when "000010000000" => R3 <= "1001";--g
                           R2 <= "0000";
    when "000100000000" => R3 <= "1001";--gs
                           R2 <= "0101";
    when "001000000000" => R3 <= "1010";--a
                           R2 <= "0000";
    when "010000000000" => R3 <= "1010";--as
                           R2 <= "0101";
    when "100000000000" => R3 <= "1011";--b
                           R2 <= "0000";
    when others => R3 <= "0000";
                   R2 <= "0000";
                   
    end case;
    
    case Octave is
    when '0' => R1 <= "0100";
    when others => R1<= "0101";
    
    end case;
end process;

end Behavioral;
