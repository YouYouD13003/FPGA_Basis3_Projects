library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity chrono is
    Port ( CLK,RST : in  STD_LOGIC;
           seg : out  STD_LOGIC_VECTOR (6 downto 0);
		   an : out STD_LOGIC_VECTOR (3 downto 0)
          );
end chrono;

architecture rtl of chrono is
    signal clk_div : STD_LOGIC_VECTOR (2 downto 0);
    signal clk_div_1 : STD_LOGIC_VECTOR (2 downto 0);
    
    signal clk_1s : STD_LOGIC;
    signal clk_compte_1s : STD_LOGIC_VECTOR(26 downto 0);
	signal clk_compte_16ms : STD_LOGIC_VECTOR(19 downto 0);
	signal clk_16ms : STD_LOGIC;
	
	signal min_h : STD_LOGIC_VECTOR(2 downto 0);
	signal min_l : STD_LOGIC_VECTOR(3 downto 0);
	signal sec_h : STD_LOGIC_VECTOR(2 downto 0);
	signal sec_l : STD_LOGIC_VECTOR(3 downto 0);
begin

    process (RST, clk)
    begin
		if(RST = '1') then
			clk_compte_1s <= (others => '0');
			clk_1s <= '0';
			clk_compte_16ms <= (others => '0');
			clk_16ms <= '0';
        elsif clk'Event and clk = '1' then
            if clk_compte_1s >= 100000000 then
                clk_compte_1s <= (others => '0');
            else
                clk_compte_1s <= clk_compte_1s + 1;
            end if;
            
            if clk_compte_1s < 50000000 then   --clock 1 Hz
                clk_1s <= '0';
            else
                clk_1s <= '1';
            end if;
			
			if clk_compte_16ms >= 200000 then
				clk_compte_16ms <= (others => '0');
			else
				clk_compte_16ms <= clk_compte_16ms + 1;
			end if;
			
			if clk_compte_16ms < 100000 then     --clock 16ms
				clk_16ms <= '0';
			else
				clk_16ms <= '1';
			end if;
			
        end if;
    end process;

    -- clock divider : afficheurs
    process (RST, clk_16ms)
    begin
		if(RST = '1') then
			clk_div <= (others => '0');
        elsif (clk_16ms'Event and clk_16ms = '1') then
            if clk_div >= 3 then
                clk_div <= (others => '0');
            else
                clk_div <= clk_div + '1';
            end if;
        end if;
    end process;
    
    -- clock divider : chiffres
    process (RST, clk_1s)
    begin
		if(RST = '1') then
			sec_l <= (others => '0');
			sec_h <= (others => '0');
			min_l <= (others => '0');
			min_h <= (others => '0');
        elsif (clk_1s'Event and clk_1s = '1') then
            if sec_l = "1001" then
				sec_l <= "0000";
				
				if(sec_h = "101") then
					sec_h <= "000";
					if(min_l = "1001") then
						min_l <= "0000";
						if(min_h = "101") then
							min_h <= "000";
						else
							min_h <= min_h + 1;
						end if;
					else
						min_l <= min_l + 1;
					end if;
				else
					sec_h <= sec_h + 1;
				end if;
			 else
			     sec_l <= sec_l + 1;  
			 end if;
        end if;
    end process;
    
    process (RST, clk_1s)
    begin
		if(RST = '1') then
			clk_div_1 <= (others => '0');
		elsif (clk_1s'Event and clk_1s = '1') then
            if clk_div_1 >= 3 then
                clk_div_1 <= (others => '0');
            else
                clk_div_1 <= clk_div_1 + '1';
            end if;
        end if;
    end process;
    
    -- up/down counter
    process (RST, clk_div, sec_h, sec_l, min_h, min_l)
    begin
        case clk_div is
            when "00" =>        -- 1er gauche
                an <= "0111";
                case min_h is
                    when "000" =>
                        seg <= "1000000"; -- '0'
                    when "001" =>
                        seg <= "1111001"; -- '1'
                    when "010" =>
                        seg <= "0100100"; -- '2'
                    when "011" =>
                        seg <= "0110000"; -- '3'
                    when "100" =>
                        seg <= "0011001"; -- '4'
                    when "101" =>
                        seg <= "0010010"; -- '5'
                    when "110" =>
                        seg <= "0000010"; -- '6'
                    when others =>
                        seg <= "1111111"; -- 'end'
                end case;
            when "01" =>        -- 2er gauche
                an <= "1011";       
                case min_l is
                    when "0000" =>
                        seg <= "1000000"; -- '0'
                    when "0001" =>
                        seg <= "1111001"; -- '1'
                    when "0010" =>
                        seg <= "0100100"; -- '2'
                    when "0011" =>
                        seg <= "0110000"; -- '3'
                    when "0100" =>
                        seg <= "0011001"; -- '4'
                    when "0101" =>
                        seg <= "0010010"; -- '5'
                    when "0110" =>
                        seg <= "0000010"; -- '6'
                    when "0111" =>
                        seg <= "1111000"; -- '7'
                    when "1000" =>
                        seg <= "0000000"; -- '8'
                    when "1001" =>
                        seg <= "0010000"; -- '9'
                    when others =>
                        seg <= "1111111"; -- 'end'
                end case;
            when "10" =>        -- 3er gauche
                an <= "1101";      
                case sec_h is
                    when "000" =>
                        seg <= "1000000"; -- '0'
                    when "001" =>
                        seg <= "1111001"; -- '1'
                    when "010" =>
                        seg <= "0100100"; -- '2'
                    when "011" =>
                        seg <= "0110000"; -- '3'
                    when "100" =>
                        seg <= "0011001"; -- '4'
                    when "101" =>
                        seg <= "0010010"; -- '5'
                    when "110" =>
                        seg <= "0000010"; -- '6'
                    when others =>
                        seg <= "1111111"; -- 'end'
                end case;
            when "11" =>        -- 4er gauche
                an <= "1110";       
                case sec_l is
                    when "0000" =>
                        seg <= "1000000"; -- '0'
                    when "0001" =>
                        seg <= "1111001"; -- '1'
                    when "0010" =>
                        seg <= "0100100"; -- '2'
                    when "0011" =>
                        seg <= "0110000"; -- '3'
                    when "0100" =>
                        seg <= "0011001"; -- '4'
                    when "0101" =>
                        seg <= "0010010"; -- '5'
                    when "0110" =>
                        seg <= "0000010"; -- '6'
                    when "0111" =>
                        seg <= "1111000"; -- '7'
                    when "1000" =>
                        seg <= "0000000"; -- '8'
                    when "1001" =>
                        seg <= "0010000"; -- '9'
                    when others =>
                        seg <= "1111111"; -- 'end'
                end case;
            when others =>
                an <= "1111";
         end case;
    end process;
	
   
   -- "1000000"; -- '0'
   -- "1111001"; -- '1'
   -- "0100100"; -- '2'
   -- "0110000"; -- '3'
   -- "0011001" -- '4'
   -- "0010010" -- '5'
   -- "0000010" -- '6'
   -- "1111000" -- '7'
   -- "0000000" -- '8'
   -- "0010000" -- '9'
   
end rtl;