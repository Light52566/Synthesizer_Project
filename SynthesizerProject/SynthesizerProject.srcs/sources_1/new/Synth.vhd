----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2019 11:25:56 PM
-- Design Name: 
-- Module Name: Synth - Behavioral
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

entity Synth is
    Port ( CLK : in STD_LOGIC; 
           N : in STD_LOGIC_VECTOR(11 downto 0);
           Octave :in STD_LOGIC;
           output : out STD_LOGIC;
           amp: inout integer);
end Synth;

architecture Behavioral of Synth is

    component Wave_Generator is
        Port ( Trigger : in STD_LOGIC;
           Freq_Cnt : in STD_LOGIC_VECTOR(15 downto 0);
           wavegenCLK : in STD_LOGIC;
           WaveOut : out STD_LOGIC_VECTOR(9 downto 0);
           t: inout integer);
    end component;

---------------------------output signals from wave generator-----------------------
    signal WaveC4, WaveCs4, WaveD4, WaveDs4, WaveE4, WaveF4, WaveFs4, WaveG4, WaveGs4, WaveA4, WaveAs4, WaveB4, WaveC5, WaveCs5, WaveD5, WaveDs5, WaveE5, WaveF5, WaveFs5, WaveG5, WaveGs5, WaveA5, WaveAs5, WaveB5, WaveC6  : signed(9 downto 0);


--------------------------------for note selection logic--------------------
    signal C4, Cs4, D4, Ds4, E4, F4, Fs4, G4, Gs4, A4, As4, B4, C5, Cs5, D5, Ds5, E5, F5, Fs5, G5, Gs5, A5, As5, B5, C6 : unsigned(4 downto 0);
    signal cntC4, cntCs4, cntD4, cntDs4, cntE4, cntF4, cntFs4, cntG4, cntGs4, cntA4, cntAs4, cntB4, cntC5, cntCs5, cntD5, cntDs5, cntE5, cntF5, cntFs5, cntG5, cntGs5, cntA5, cntAs5, cntB5, cntC6 : unsigned(4 downto 0);
    signal error : STD_LOGIC;
    

-----------------------------------for adding sine waves--------------------------
    signal Wave0, Wave1, Wave2, Wave3 : signed(9 downto 0); --signals from Wave Generator module output
    
    signal WaveSum : STD_LOGIC_VECTOR(9 downto 0); --signal for summed sine waves (2's compliment -512 to 511)
    signal positiveWaveSum : STD_LOGIC_VECTOR(9 downto 0); --unsigned 0 to 1023, for use in PWM generator
    
    
-----------------------------------for generating PWM-------------------------------
    signal ping_length : unsigned (9 downto 0) := unsigned(positiveWaveSum);
    signal PWM : unsigned (9 downto 0) := to_unsigned(0, 10);

-----------------------------------for distinctive notes----------------------------

signal O4 : STD_LOGIC_VECTOR(11 downto 0);
signal O5 : STD_LOGIC_VECTOR(12 downto 0);

begin 

process(CLK, Octave)
begin
if(rising_edge(CLK)) then
    if (Octave = '1') then 
        O5(0) <= N(0);
        O5(1) <= N(1);
        O5(2) <= N(2);
        O5(3) <= N(3);
        O5(4) <= N(4);
        O5(5) <= N(5);
        O5(6) <= N(6);
        O5(7) <= N(7);
        O5(8) <= N(8);
        O5(9) <= N(9);
        O5(10) <= N(10);
        O5(11) <= N(11);
    end if;
    if(Octave = '0') then
        O4(0) <= N(0);
        O4(1) <= N(1);
        O4(2) <= N(2);
        O4(3) <= N(3);
        O4(4) <= N(4);
        O4(5) <= N(5);
        O4(6) <= N(6);
        O4(7) <= N(7);
        O4(8) <= N(8);
        O4(9) <= N(9);
        O4(10) <= N(10);
        O4(11) <= N(11);
    end if;
end if;
end process;


----------Frequency counter values are in Hex------------------------------
    Note_C4  : Wave_Generator port map (Trigger => O4(0), Freq_Cnt => X"1755", wavegenCLK => CLK, signed(WaveOut) => WaveC4, t => amp); --5973, 261.63 Hz
    Note_Cs4 : Wave_Generator port map (Trigger => O4(1), Freq_Cnt => X"1606", wavegenCLK => CLK, signed(WaveOut) => WaveCs4, t => amp);--5638, 277.18 Hz
    Note_D4  : Wave_Generator port map (Trigger => O4(2), Freq_Cnt => X"14C9", wavegenCLK => CLK, signed(WaveOut) => WaveD4, t => amp); --5321, 293.66 Hz
    Note_Ds4 : Wave_Generator port map (Trigger => O4(3), Freq_Cnt => X"139F", wavegenCLK => CLK, signed(WaveOut) => WaveDs4, t => amp);--5023, 311.13 Hz
    Note_E4  : Wave_Generator port map (Trigger => O4(4), Freq_Cnt => X"1285", wavegenCLK => CLK, signed(WaveOut) => WaveE4, t => amp); --4741, 329.63 Hz
    Note_F4  : Wave_Generator port map (Trigger => O4(5), Freq_Cnt => X"117B", wavegenCLK => CLK, signed(WaveOut) => WaveF4, t => amp); --4475, 349.23 Hz
    Note_Fs4 : Wave_Generator port map (Trigger => O4(6), Freq_Cnt => X"1080", wavegenCLK => CLK, signed(WaveOut) => WaveFs4, t => amp);--4224, 369.99 Hz
    Note_G4  : Wave_Generator port map (Trigger => O4(7), Freq_Cnt => X"0F92", wavegenCLK => CLK, signed(WaveOut) => WaveG4, t => amp); --3986, 392.00 Hz
    Note_Gs4 : Wave_Generator port map (Trigger => O4(8), Freq_Cnt => X"0EB3", wavegenCLK => CLK, signed(WaveOut) => WaveGs4, t => amp);--3763, 415.30 Hz
    Note_A4  : Wave_Generator port map (Trigger => O4(9), Freq_Cnt => X"0DE0", wavegenCLK => CLK, signed(WaveOut) => WaveA4, t => amp); --3552, 440.00 Hz
    Note_As4 : Wave_Generator port map (Trigger => O4(10),Freq_Cnt => X"0D18", wavegenCLK => CLK, signed(WaveOut) => WaveAs4, t => amp);--3352, 466.16 Hz
    Note_B4  : Wave_Generator port map (Trigger => O4(11),Freq_Cnt => X"0C5C", wavegenCLK => CLK, signed(WaveOut) => WaveB4, t => amp); --3164, 493.88 Hz

-------------------------------------------------------------------------------------------------------------------------    
                                                                
    Note_C5  : Wave_Generator port map (Trigger => O5(0), Freq_Cnt => X"0BAB", wavegenCLK => CLK, signed(WaveOut) => WaveC5, t => amp); --2987, 523.25 Hz
    Note_Cs5 : Wave_Generator port map (Trigger => O5(1), Freq_Cnt => X"0B03", wavegenCLK => CLK, signed(WaveOut) => WaveCs5, t => amp);--2819, 554.37 Hz
    Note_D5  : Wave_Generator port map (Trigger => O5(2), Freq_Cnt => X"0A65", wavegenCLK => CLK, signed(WaveOut) => WaveD5, t => amp); --2661, 587.33 Hz
    Note_Ds5 : Wave_Generator port map (Trigger => O5(3), Freq_Cnt => X"09D0", wavegenCLK => CLK, signed(WaveOut) => WaveDs5, t => amp);--2512, 622.25 Hz
    Note_E5  : Wave_Generator port map (Trigger => O5(4), Freq_Cnt => X"0943", wavegenCLK => CLK, signed(WaveOut) => WaveE5, t => amp); --2371, 659.25 Hz
    Note_F5  : Wave_Generator port map (Trigger => O5(5), Freq_Cnt => X"08Be", wavegenCLK => CLK, signed(WaveOut) => WaveF5, t => amp); --2238, 698.46 Hz
    Note_Fs5 : Wave_Generator port map (Trigger => O5(6), Freq_Cnt => X"0840", wavegenCLK => CLK, signed(WaveOut) => WaveFs5, t => amp);--2112, 739.99 Hz
    Note_G5  : Wave_Generator port map (Trigger => O5(7), Freq_Cnt => X"07CA", wavegenCLK => CLK, signed(WaveOut) => WaveG5, t => amp); --1994, 783.99 Hz
    Note_Gs5 : Wave_Generator port map (Trigger => O5(8), Freq_Cnt => X"075A", wavegenCLK => CLK, signed(WaveOut) => WaveGs5, t => amp);--1882, 830.61 Hz
    Note_A5  : Wave_Generator port map (Trigger => O5(9), Freq_Cnt => X"06F0", wavegenCLK => CLK, signed(WaveOut) => WaveA5, t => amp); --1776, 880.00 Hz
    Note_As5 : Wave_Generator port map (Trigger => O5(10),Freq_Cnt => X"068C", wavegenCLK => CLK, signed(WaveOut) => WaveAs5, t => amp);--1676, 932.33 Hz
    Note_B5  : Wave_Generator port map (Trigger => O5(11),Freq_Cnt => X"062E", wavegenCLK => CLK, signed(WaveOut) => WaveB5, t => amp); --1582, 987.77 Hz
    Note_C6  : Wave_Generator port map (Trigger => O5(12),Freq_Cnt => X"05D6", wavegenCLK => CLK, signed(WaveOut) => WaveC6, t => amp); --1494, 1046.5 Hz





------------note selection logic------------
--Take trigger inputs, turn into 5-bit signals for adding
    C4  <= "0000" & O4(0);
    Cs4 <= "0000" & O4(1);
    D4  <= "0000" & O4(2);
    Ds4 <= "0000" & O4(3);
    E4  <= "0000" & O4(4);
    F4  <= "0000" & O4(5);
    Fs4 <= "0000" & O4(6);
    G4  <= "0000" & O4(7);
    Gs4 <= "0000" & O4(8);
    A4  <= "0000" & O4(9);
    As4 <= "0000" & O4(10);
    B4  <= "0000" & O4(11);
    C5  <= "0000" & O5(0);
    Cs5 <= "0000" & O5(1);
    D5  <= "0000" & O5(2);
    Ds5 <= "0000" & O5(3);
    E5  <= "0000" & O5(4);
    F5  <= "0000" & O5(5);
    Fs5 <= "0000" & O5(6);
    G5  <= "0000" & O5(7);
    Gs5 <= "0000" & O5(8);
    A5  <= "0000" & O5(9);
    As5 <= "0000" & O5(10);
    B5  <= "0000" & O5(11);
    C6  <= "0000" & O5(12);
    
    
    --these variables represent how many notes lower than the target note have been played, including the target note.
    --For example, if C4, E4, G4, A#4, and D5 are played (C9 chord) cntC4 will be 1, cntE4 will be 2, cntG4 will be 3, etc.
    cntC4 <= C4;
    cntCs4 <= C4 + Cs4;
    cntD4  <= C4 + Cs4 + D4;
    cntDs4 <= C4 + Cs4 + D4 + Ds4;
    cntE4  <= C4 + Cs4 + D4 + Ds4 + E4;
    cntF4  <= C4 + Cs4 + D4 + Ds4 + E4 + F4;
    cntFs4 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4;
    cntG4  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4;
    cntGs4 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4;
    cntA4  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4;
    cntAs4 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4;
    cntB4  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4;
    cntC5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5;
    cntCs5 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5;
    cntD5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5;
    cntDs5 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5;
    cntE5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5;
    cntF5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5;
    cntFs5 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5;
    cntG5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5 + G5;
    cntGs5 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5 + G5 + Gs5;
    cntA5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5 + G5 + Gs5 + A5;
    cntAs5 <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5 + G5 + Gs5 + A5 + As5;
    cntB5  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5 + G5 + Gs5 + A5 + As5 + B5;
    cntC6  <= C4 + Cs4 + D4 + Ds4 + E4 + F4 + Fs4 + G4 + Gs4 + A4 + As4 + B4 + C5 + Cs5 + D5 + Ds5 + E5 + F5 + Fs5 + G5 + Gs5 + A5 + As5 + B5 + C6;
 
    Selection : process (WaveC4, WaveCs4, WaveD4, WaveDs4, WaveE4, WaveF4, WaveFs4, WaveG4, WaveGs4, WaveA4, WaveAs4, WaveB4, 
                         WaveC5, WaveCs5, WaveD5, WaveDs5, WaveE5, WaveF5, WaveFs5, WaveG5, WaveGs5, WaveA5, WaveAs5, WaveB5, WaveC6)
    begin
    
        if (cntC6 = "00000") then ---------------if no signals being generated
            Wave0 <= "0000000000";
            Wave1 <= "0000000000";
            Wave2 <= "0000000000";
            Wave3 <= "0000000000";
        else
            if (O4(0) = '1') then -------------------note C4 played
                Wave0 <= WaveC4;
            end if;
            if (O4(1) = '1') then -------------------note Cs5 played
                case(cntCs4) is
                    when "00001" => Wave0 <= WaveCs4;
                    when "00010" => Wave1 <= WaveCs4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(2) = '1') then--------------------note D4 played
                case(cntD4) is
                    when "00001" => Wave0 <= WaveD4;
                    when "00010" => Wave1 <= WaveD4;
                    when "00011" => Wave2 <= WaveD4;
                    when others => error <= '1';
                end case;
            end if;
-------------------------------------------------------------------------------------------------------------------------
            if (O4(3) = '1') then--------------------note Ds4 played
                case(cntDs4) is
                    when "00001" => Wave0 <= WaveDs4;
                    when "00010" => Wave1 <= WaveDs4;
                    when "00011" => Wave2 <= WaveDs4;
                    when "00100" => Wave3 <= WaveDs4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(4) = '1') then--------------------note E4 played
                case(cntE4) is
                    when "00001" => Wave0 <= WaveE4;
                    when "00010" => Wave1 <= WaveE4;
                    when "00011" => Wave2 <= WaveE4;
                    when "00100" => Wave3 <= WaveE4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(5) = '1') then--------------------note F4 played
                case(cntF4) is
                    when "00001" => Wave0 <= WaveF4;
                    when "00010" => Wave1 <= WaveF4;
                    when "00011" => Wave2 <= WaveF4;
                    when "00100" => Wave3 <= WaveF4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(6) = '1') then--------------------note Fs4 played
                case(cntFs4) is
                    when "00001" => Wave0 <= WaveFs4;
                    when "00010" => Wave1 <= WaveFs4;
                    when "00011" => Wave2 <= WaveFs4;
                    when "00100" => Wave3 <= WaveFs4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(7) = '1') then--------------------note G4 played
                case(cntG4) is
                    when "00001" => Wave0 <= WaveG4;
                    when "00010" => Wave1 <= WaveG4;
                    when "00011" => Wave2 <= WaveG4;
                    when "00100" => Wave3 <= WaveG4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(8) = '1') then--------------------note Gs4 played
                case(cntGs4) is
                    when "00001" => Wave0 <= WaveGs4;
                    when "00010" => Wave1 <= WaveGs4;
                    when "00011" => Wave2 <= WaveGs4;
                    when "00100" => Wave3 <= WaveGs4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(9) = '1') then--------------------note A4 played
                case(cntA4) is
                    when "00001" => Wave0 <= WaveA4;
                    when "00010" => Wave1 <= WaveA4;
                    when "00011" => Wave2 <= WaveA4;
                    when "00100" => Wave3 <= WaveA4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(10) = '1') then--------------------note As4 played
                case(cntAs4) is
                    when "00001" => Wave0 <= WaveAs4;
                    when "00010" => Wave1 <= WaveAs4;
                    when "00011" => Wave2 <= WaveAs4;
                    when "00100" => Wave3 <= WaveAs4;
                    when others => error <= '1';
                end case;
            end if;
            if (O4(11) = '1') then--------------------note B4 played
                case(cntB4) is
                    when "00001" => Wave0 <= WaveB4;
                    when "00010" => Wave1 <= WaveB4;
                    when "00011" => Wave2 <= WaveB4;
                    when "00100" => Wave3 <= WaveB4;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(0) = '1') then--------------------note C5 played
                case(cntC5) is
                    when "00001" => Wave0 <= WaveC5;
                    when "00010" => Wave1 <= WaveC5;
                    when "00011" => Wave2 <= WaveC5;
                    when "00100" => Wave3 <= WaveC5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(1) = '1') then--------------------note Cs5 played
                case(cntCs5) is
                    when "00001" => Wave0 <= WaveCs5;
                    when "00010" => Wave1 <= WaveCs5;
                    when "00011" => Wave2 <= WaveCs5;
                    when "00100" => Wave3 <= WaveCs5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(2) = '1') then--------------------note D5 played
                case(cntD5) is
                    when "00001" => Wave0 <= WaveD5;
                    when "00010" => Wave1 <= WaveD5;
                    when "00011" => Wave2 <= WaveD5;
                    when "00100" => Wave3 <= WaveD5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(3) = '1') then--------------------note Ds5 played
                case(cntDs5) is
                    when "00001" => Wave0 <= WaveDs5;
                    when "00010" => Wave1 <= WaveDs5;
                    when "00011" => Wave2 <= WaveDs5;
                    when "00100" => Wave3 <= WaveDs5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(4) = '1') then--------------------note E5 played
                case(cntE5) is
                    when "00001" => Wave0 <= WaveE5;
                    when "00010" => Wave1 <= WaveE5;
                    when "00011" => Wave2 <= WaveE5;
                    when "00100" => Wave3 <= WaveE5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(5) = '1') then--------------------note F5 played
                case(cntF5) is
                    when "00001" => Wave0 <= WaveF5;
                    when "00010" => Wave1 <= WaveF5;
                    when "00011" => Wave2 <= WaveF5;
                    when "00100" => Wave3 <= WaveF5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(6) = '1') then--------------------note Fs5 played
                case(cntFs5) is
                    when "00001" => Wave0 <= WaveFs5;
                    when "00010" => Wave1 <= WaveFs5;
                    when "00011" => Wave2 <= WaveFs5;
                    when "00100" => Wave3 <= WaveFs5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(7) = '1') then--------------------note G5 played
                case(cntG5) is
                    when "00001" => Wave0 <= WaveG5;
                    when "00010" => Wave1 <= WaveG5;
                    when "00011" => Wave2 <= WaveG5;
                    when "00100" => Wave3 <= WaveG5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(8) = '1') then--------------------note Gs5 played
                case(cntGs5) is
                    when "00001" => Wave0 <= WaveGs5;
                    when "00010" => Wave1 <= WaveGs5;
                    when "00011" => Wave2 <= WaveGs5;
                    when "00100" => Wave3 <= WaveGs5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(9) = '1') then--------------------note A5 played
                case(cntA5) is
                    when "00001" => Wave0 <= WaveA5;
                    when "00010" => Wave1 <= WaveA5;
                    when "00011" => Wave2 <= WaveA5;
                    when "00100" => Wave3 <= WaveA5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(10) = '1') then--------------------note As5 played
                case(cntAs5) is
                    when "00001" => Wave0 <= WaveAs5;
                    when "00010" => Wave1 <= WaveAs5;
                    when "00011" => Wave2 <= WaveAs5;
                    when "00100" => Wave3 <= WaveAs5;
                    when others => error <= '1';
                end case;
            end if;
            if (O5(11) = '1') then--------------------note B5 played
                case(cntB5) is
                    when "00001" => Wave0 <= WaveB5;
                    when "00010" => Wave1 <= WaveB5;
                    when "00011" => Wave2 <= WaveB5;
                    when "00100" => Wave3 <= WaveB5;
                    when others => error <= '1';
                end case;
            end if;
---------------------------------------------------------------------------------------------------------------------------------    
            if(O5(12) = '1') then--------------------note C6 played
                case(cntC6) is
                    when "00001" => 
                        Wave0 <= WaveC6;
                        Wave1 <= "0000000000";
                        Wave2 <= "0000000000";
                        Wave3 <= "0000000000";
                    when "00010" => 
                        Wave1 <= WaveC6;
                        Wave2 <= "0000000000";
                        Wave3 <= "0000000000";
                    when "00011" => 
                        Wave2 <= WaveC6;
                        Wave3 <= "0000000000";
                    when "00100" => Wave3 <= WaveC6;
                    when others => error <= '1';
                end case;   
            else
                case(cntC6) is--------------------------fill in extra waves
                    when "00001" => 
                        Wave1 <= "0000000000";
                        Wave2 <= "0000000000";
                        Wave3 <= "0000000000";
                    when "00010" => 
                        Wave2 <= "0000000000";
                        Wave3 <= "0000000000";
                    when "00011" => 
                        Wave3 <= "0000000000";
                    when others => error <= '1';
                end case;   
            end if;    
        end if;
        
    end process;        

-------------sine wave adder--------------------
    
   
    WaveSum <= STD_LOGIC_VECTOR(Wave0 + Wave1 + Wave2 + Wave3);
    
 
 
---------make sine wave positive for pwm---------------------

    positiveWaveSum <= not WaveSum(9) & WaveSum(8 downto 0);
    
    
    
-------------PWM generator---------------------
    process(CLK) 
            --variable count : unsigned (1 downto 0) := to_unsigned(0, 2);
        begin
            if (rising_edge(CLK)) then
                --count := count + 1;
                --if (count = to_unsigned(4, 2)) then
                    --count := to_unsigned(0, 2);
                    --if (PWM = to_
                    if (PWM < ping_length) then
                        output <= '1';
                    else
                        output <= '0';
                    end if;
                    PWM <= PWM + 1;
                    ping_length <= unsigned(positiveWaveSum);
                --end if;
            end if;
        
        end process;


end Behavioral;
