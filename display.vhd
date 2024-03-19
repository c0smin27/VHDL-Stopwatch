library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity display is
 Port ( refreshClock: in STD_LOGIC; -- semnal sincronizare afisaj
 clockDig1: in STD_LOGIC; -- semnal sincronizare afisaj
 butoane: in STD_LOGIC_VECTOR (1 downto 0); -- semnal butoane
 anod: out STD_LOGIC_VECTOR (3 downto 0); -- semnal afisaj anod comun
 catod: out STD_LOGIC_VECTOR (7 downto 0)); -- semnal afisaj catod comun
end display;

architecture Behavioral of display is
 signal rs, afisare: std_logic:= '0'; -- semnale afisaj
 signal buton_start, buton_reset: integer:=0; -- semnal butoane
 signal dig1Count, dig2Count, dig3Count, dig4Count, use1, use2, use3, use4 : integer:= 0; -- semnal pt numerele de pe afisaj

begin

 display : process (refreshClock, clockDig1, butoane, rs) is
 begin
 if (butoane(1) = '1' and rs = '0') then -- verificare buton reset
    use1 <= 0;
    use2 <= 0;
    use3 <= 0;
    use4 <= 0;
    dig1Count <= 0;
    dig2Count <= 0;
    dig3Count <= 0;
    dig4Count <= 0;
 end if;

 if (afisare = '1' and rs = '0') then -- control afisaj dupa semnalul 'afisaj'
 end if;
 if (rising_edge(clockDig1)) then
 if (rs = '1') then -- verificare stare de functionare cronometru
 use1 <= dig1Count;
 use2 <= dig2Count;
 use3 <= dig3Count;
 use4 <= dig4Count;

 dig1Count <= dig1Count + 1;
 if (dig1Count = 9) then
 dig1Count <= 0;
 dig2Count <= dig2Count + 1;
 if (dig2Count = 9) then
 dig2Count <= 0;
 dig3Count <= dig3Count + 1;
 if (dig3Count = 9) then
 dig3Count <= 0;
 dig4Count <= dig4Count + 1;
 if (dig4Count = 9) then
 dig4Count <= 0;
 end if;
 end if;
 end if;
 end if;
 end if;
 end if;
 end process display;

 process (refreshClock)
 variable cifra : unsigned (1 downto 0) := "00"; -- variabila pt selectarea cifrei pe afisaj
 begin
 if(rising_edge(refreshClock)) then
 case cifra is
 when "00" =>
 case (use1) is -- selectare cifra si valoare pt anod si catod
 when 0 =>
 anod <= "1110";
 catod <= "00000011";
 when 1 =>
 anod <= "1110";
 catod <= "11110011";
 when 2 =>
 anod <= "1110";
 catod <= "00100101";
 when 3 =>
 anod <= "1110";
 catod <= "00001101";
 when 4 =>
 anod <= "1110";
 catod <= "10011001";
 when 5 =>
 anod <= "1110";
 catod <= "01001001";
 when 6 =>
 anod <= "1110";
 catod <= "11000001";
 when 7 =>
 anod <= "1110";
 catod <= "00011111";
 when 8 =>
 anod <= "1110";
 catod <= "00000001";
 when 9 =>
 anod <= "1110";
 catod <= "00011001";
 when others =>
 anod <= "1110";
 catod <= "00000000";
 end case;
 when "01" =>
 case (use2) is
 when 0 =>
 anod <= "1101";
 catod <= "00000011";
 when 1 =>
 anod <= "1101";
 catod <= "11110011";
 when 2 =>
 anod <= "1101";
 catod <= "00100101";
 when 3 =>
 anod <= "1101";
 catod <= "00001101";
 when 4 =>
 anod <= "1101";
 catod <= "10011001";
 when 5 =>
 anod <= "1101";
 catod <= "01001001";
 when 6 =>
 anod <= "1101";
 catod <= "11000001";
 when 7 =>
 anod <= "1101";
 catod <= "00011111";
 when 8 =>
 anod <= "1101";
 catod <= "00000001";
 when 9 =>
 anod <= "1101";
 catod <= "00011001";
 when others =>
 anod <= "1101";
 catod <= "00000000";
 end case;
 when "10" =>
 case (use3) is
 when 0 =>
 anod <= "1011";
 catod <= "00000010";
 when 1 =>
 anod <= "1011";
 catod <= "11110010";
 when 2 =>
 anod <= "1011";
 catod <= "00100100";
 when 3 =>
 anod <= "1011";
 catod <= "00001100";
 when 4 =>
 anod <= "1011";
 catod <= "10011000";
 when 5 =>
 anod <= "1011";
 catod <= "01001000";
 when 6 =>
 anod <= "1011";
 catod <= "11000000";
 when 7 =>
 anod <= "1011";
 catod <= "00011110";
 when 8 =>
 anod <= "1011";
 catod <= "00000000";
 when 9 =>
 anod <= "1011";
 catod <= "00011000";
 when others =>
 anod <= "1011";
 catod <= "00000000";
 end case;
 when "11" =>
 case (use4) is
 when 0 =>
 anod <= "0111";
 catod <= "00000011";
 when 1 =>
 anod <= "0111";
 catod <= "11110011";
 when 2 =>
 anod <= "0111";
 catod <= "00100101";
 when 3 =>
 anod <= "0111";
 catod <= "00001101";
 when 4 =>
 anod <= "0111";
 catod <= "10011001";
 when 5 =>
 anod <= "0111";
 catod <= "01001001";
 when 6 =>
 anod <= "0111";
 catod <= "11000001";
 when 7 =>
 anod <= "0111";
 catod <= "00011111";
 when 8 =>
 anod <= "0111";
 catod <= "00000001";
 when 9 =>
 anod <= "0111";
 catod <= "00011001";
 when others =>
 anod <= "0111";
 catod <= "00000000";
 end case;
 end case;
 cifra := cifra + 1; -- trecerea la cifra urmatoare
 end if;
 end process;

 process(clockDig1)
 begin
 if (rising_edge(clockDig1)) then
 if (butoane(0) = '1') then -- verificare buton de start/stop
 buton_start <= 1;
 elsif (butoane(0) = '0') then
 buton_start <= 0;
 end if;
 buton_reset <= buton_start;
 if (buton_reset = 0 and buton_start = 1) then
 rs <= not rs; -- comutarea starii de functionare a cronometrului
 end if;
 end if;
 end process;

end Behavioral;
