library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clockDivider is
    Port ( CLK: in STD_LOGIC;
           refreshClock: out STD_LOGIC;
           clockDig1: out STD_LOGIC);
end clockDivider;

architecture Behavioral of clockDivider is
    signal count1: integer:=0; -- contor pt divizare frecv1
    signal count2: integer:=0; -- contor pt divizare frecv2
    signal tmp1: std_logic:='0'; -- var temp pt refreshClock
    signal tmp2: std_logic:='0'; -- var temp pt clockDig1

begin
    divizorFrecventa: process(CLK) -- divizor de frecv
    begin
        if rising_edge(CLK) then
            count1 <= count1 + 1; -- incrementam
            count2 <= count2 + 1; -- incrementam

            if (count1 = 208334) then -- contorul atinge 208334
                tmp1 <= NOT tmp1; -- inversam valoarea pt a genera semnal out periodic cu frecv mai mica
                count1 <= 0; -- reset contor
            end if;

            if(count2 = 500000) then -- contorul atinge 500000
                tmp2 <= NOT tmp2;  -- inversam valoarea pt a genera semnal out periodic cu frecv mai mica
                count2 <= 0; -- reset contor
            end if;
        end if;
    end process;

    refreshClock <= tmp1; -- refreshClock primeste val lui tmp1
    clockDig1 <= tmp2; -- clockDig1 primeste val lui tmp2

end Behavioral;
