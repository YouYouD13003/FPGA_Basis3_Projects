library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity afficheurCompteur is
    Port ( CLK : in  STD_LOGIC;     -- input clock
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
		   an : out STD_LOGIC_VECTOR (3 downto 0)
          );
end afficheurCompteur;

architecture rtl of afficheurCompteur is
    signal clk_div : STD_LOGIC_VECTOR (2 downto 0);
    signal clk_lent : STD_LOGIC;
    signal clk_compte : STD_LOGIC_VECTOR(25 downto 0);
begin

    process (clk)
    begin
        if clk'Event and clk = '1' then
            if clk_compte > 50000 then
                clk_compte <= (others => '0');
            else
                clk_compte <= clk_compte + 1;
            end if;
            
            if clk_compte < 25000 then 
                clk_lent <= '0';
            else
                clk_lent <= '1';
            end if;
        end if;
    end process;

    -- clock divider
    process (clk_lent)
    begin
        if (clk_lent'Event and clk_lent = '1') then
            if clk_div >= 3 then
                clk_div <= (others => '0');
            else
                clk_div <= clk_div + '1';
            end if;
        end if;
    end process;
    
    
    -- up/down counter
    process (clk_div)
    begin
        case clk_div is
            when "00" =>
                an <= "0111";       
                seg <= "1000000"; -- '0'
            when "01" =>
                an <= "1011";       
                seg <= "1111001"; -- '1'
            when "10" =>
                an <= "1101";      
                seg <= "0100100"; -- '2'
            when "11" =>
                an <= "1110";       
                seg <= "0110000"; --'3'
            when others =>
                an <= "1111";
         end case;
    end process;
   
end rtl;