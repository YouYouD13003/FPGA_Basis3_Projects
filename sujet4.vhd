library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity afficheur is
    Port ( CLK : in  STD_LOGIC;     -- input clock
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
		   an : out STD_LOGIC_VECTOR (3 downto 0)
          );
end afficheur;

architecture rtl of afficheur is
    signal clk_div : STD_LOGIC_VECTOR (3 downto 0) := X"0";
begin

    -- clock divider
    process (CLK)
    begin
        if (CLK'Event and CLK = '1') then
            clk_div <= clk_div + '1';
        end if;
    end process;
    
    -- up/down counter
    process (clk_div(3))
    begin
        an <= "0000";       -- tous les afficheurs allumés
        seg <= "1000000"; -- '0'
    end process;
   
end rtl;