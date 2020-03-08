----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2019 08:20:54 PM
-- Design Name: 
-- Module Name: Clock - Behavioral
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
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock is
    Port ( Clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           LED_activating_counter: out std_logic_vector(1 downto 0));
end Clock;

architecture Behavioral of Clock is

signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);



begin

process(Clock,reset)
begin
if(reset='1') then
refresh_counter <= (others => '0');
elsif(rising_edge(Clock)) then
refresh_counter <= refresh_counter + 1;
end if;
end process;
LED_activating_counter <= refresh_counter(19 downto 18);

end Behavioral;
