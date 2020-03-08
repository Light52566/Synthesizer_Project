----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/13/2019 12:38:41 PM
-- Design Name: 
-- Module Name: binaryToHexDisplay - Behavioral
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

entity binaryToHexDisplay is
Port ( A: in STD_LOGIC_VECTOR(3 downto 0);
       Display : out STD_LOGIC_VECTOR(6 downto 0));
end binaryToHexDisplay;
architecture Behavioral of binaryToHexDisplay is
begin

process(A)
begin
case A is
    when "0000" => Display <= "1111111";--null
    when "0001" => Display <= "1001111";--1
    when "0010" => Display <= "0010010";--2
    when "0011" => Display <= "0000110";--3
    when "0100" => Display <= "1001100";--4
    when "0101" => Display <= "0100100";--5 , S
    when "0110" => Display <= "0100000";--6
    when "0111" => Display <= "1111010";--r
    when "1000" => Display <= "0000000";--8
    when "1001" => Display <= "0000100";--9 , g
    when "1010" => Display <= "0000010";--a
    when "1011" => Display <= "1100000";--b
    when "1100" => Display <= "0110001";--c
    when "1101" => Display <= "1000010";--d
    when "1110" => Display <= "0110000";--e
    when "1111" => Display <= "0111000";--f
    when others => Display <= "0000001";--0
end case;

end process;

end Behavioral;

