----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2019 12:52:06 AM
-- Design Name: 
-- Module Name: WaveGenerator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity Wave_Generator is
    Port ( Trigger : in STD_LOGIC;                       -- Key press
           Freq_Cnt : in STD_LOGIC_VECTOR(15 downto 0);   -- Counter value = 100MHz / (Note Frequency*64 Divisions of Sine Wave) (round to nearest num)
                                                            -- renamed from Freq
           wavegenCLK : in STD_LOGIC;                       -- Basys3 100MHz CLK
           WaveOut : out STD_LOGIC_VECTOR(9 downto 0);  -- Signed amplitude of wave
           t: integer);
end Wave_Generator;

architecture Behavioral of Wave_Generator is

    signal i : integer range 0 to 64 := 0;                           -- index of amplitude memory bank
    type memory_type is array (0 to 63) of integer range -64 to 63;  -- create memory bank (ROM) to hold amplitude values

    signal amplitude : memory_type := ( 0,  7, 13, 19, 25, 30, 35, 40, 45, 49, 52, 55, 58, 60, 62, 63, 
                                       63, 63, 62, 60, 58, 55, 52, 49, 45, 40, 35, 30, 25, 19, 13,  7, 
                                        0, -7,-13,-19,-25,-30,-35,-40,-45,-49,-52,-55,-58,-60,-62,-63,  
                                      -63,-63,-62,-60,-58,-55,-52,-49,-45,-40,-35,-30,-25,-19,-13, -7); -- amplitude memory bank for sine wave

begin

    process (wavegenCLK, Trigger)
    
        variable counter : unsigned (15 downto 0) := to_unsigned(0, 16); -- clock divider counter
        variable temp: integer;
    begin
    
        if (rising_edge(wavegenCLK)) then
        
            if (Trigger = '1') then -- key is pressed
                
                counter := counter + 1;
                if (counter = unsigned(Freq_Cnt)) then  -- Freq_Cnt = 100Mhz / (note freq * 64 divisions of the sine wave)
                    
                    -- reset counter and assign amplitude data to output
                    counter := to_unsigned(0, 16);
                    temp := amplitude(i)*t/24;
                    WaveOut <= STD_LOGIC_VECTOR (to_signed(temp, 10));
                    
                    -- increment i for next reading
                    i <= i + 1;
                    
                    -- reset i if one sine wave has been completed
                    if(i = 63) then
                        i <= 0;
                    end if;
                    
                end if; -- (counter = unsigned(Freq_Cnt))
                
            else -- key is not pressed
            
                -- reset output, amplitude index, and counter
                WaveOut <= "0000000000";
                i <= 0;
                counter := to_unsigned(0, 16); --output Amplitude = -64 when no note is played
            
            end if; -- (Trigger = '1')
        
        end if; -- (rising_edge(CLK))
        
    end process;

end Behavioral;