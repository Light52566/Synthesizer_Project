----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2019 11:15:15 AM
-- Design Name: 
-- Module Name: segmentDisplay - Behavioral
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

entity segmentDisplay is
    Port ( R1: in std_logic_vector(3 downto 0);
           R2: in std_logic_vector(3 downto 0);
           R3: in std_logic_vector(3 downto 0);
           R4: in std_logic_vector(3 downto 0);
           Clock: in std_logic;
           Reset: in std_logic;
           Display: out std_logic_vector(6 downto 0);
           Digit: out std_logic_vector(3 downto 0));
end segmentDisplay;

architecture Behavioral of segmentDisplay is

signal counter: std_logic_vector(1 downto 0);


signal D1 : STD_LOGIC_VECTOR(6 downto 0);
signal D2 : STD_LOGIC_VECTOR(6 downto 0);
signal D3 : STD_LOGIC_VECTOR(6 downto 0);
signal D4 : STD_LOGIC_VECTOR(6 downto 0);

begin

BtoH1: entity work.binaryToHexDisplay port map (R1,D1);
BtoH2: entity work.binaryToHexDisplay port map (R2,D2);
BtoH3: entity work.binaryToHexDisplay port map (R3,D3);
BtoH4: entity work.binaryToHexDisplay port map (R4,D4);

C1: entity work.Clock port map(Clock, Reset, counter);


process(counter)
begin
    case counter is
    when "00" => Digit <= "0111";
                 Display <= D4;
    when "01" => Digit <= "1011";
                 Display <= D3;
    when "10" => Digit <= "1101";
                 Display <= D2;
    when "11" => Digit <= "1110";
                 Display <= D1;
    end case;
    
    
end process;


end Behavioral;
