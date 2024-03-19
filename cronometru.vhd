library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cronometru is
    Port ( butoane: in STD_LOGIC_VECTOR (1 downto 0); -- semnal butoane
           CLK: in STD_LOGIC; -- semnal de ceas
           anod: out STD_LOGIC_VECTOR (3 downto 0); -- semnal afisaj anod comun
           catod: out STD_LOGIC_VECTOR (7 downto 0)); -- semnal afisaj catod comun
end cronometru;

architecture Behavioral of cronometru is

component clockDivider port (CLK: in STD_LOGIC; -- semnal de ceas
                             refreshClock, clockDig1: out STD_LOGIC); -- semnale pt divizor de frecv
end component;

signal refreshSig, dig1Sig: STD_LOGIC; -- semnale intermediare pt semnale de divizor de frecv
component display port (refreshClock, clockDig1: in STD_LOGIC; -- semnale de divizor de frecv
                        butoane: in STD_LOGIC_VECTOR(1 downto 0); -- semnal butoane
                        catod: out STD_LOGIC_VECTOR(7 downto 0); -- semnal afisaj anod comun
                        anod: out STD_LOGIC_VECTOR(3 downto 0)); -- semnal afisaj catod comun
end component;

begin
part0: clockDivider port map (CLK => CLK, refreshClock => refreshSig, clockDig1 => dig1Sig); -- instantiere divizor de frecv
part1: display port map (refreshClock => refreshSig, clockDig1 => dig1Sig, butoane => butoane, catod => catod, anod => anod); -- instantiere afisaj

end Behavioral;
