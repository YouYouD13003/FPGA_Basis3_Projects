library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- simulation library
library UNISIM;
use UNISIM.VComponents.all;

-- the vga_controller_640_60 entity declaration
-- read above for behavioral description and port definitions.
entity Image is
port(
   img_rst   : in std_logic;
   img_clk   : in std_logic;
   img_blank   : in std_logic;

   --HS          : out std_logic;
   --VS          : out std_logic;
   img_blue      : out std_logic_vector(3 downto 0);
   img_green      : out std_logic_vector(3 downto 0);
   img_red       : out std_logic_vector(3 downto 0)
);
end Image;

architecture rtl of Image is
--signal clock_div : STD_LOGIC_VECTOR(23 downto 0);
signal xcount_s :  std_logic_vector(10 downto 0);
signal ycount_s :  std_logic_vector(10 downto 0);

begin
    process (img_blank)
    begin
        --couleur
		if img_blank = '0' then
			if(xcount_s < 213)then
				img_blue <= "1111";
				img_red <= "0000";
				img_green <= "0000";
			elsif(xcount_s < 426) then
				img_blue <= "1111";
				img_red <= "1111";
				img_green <= "1111";
			else
				img_blue <= "0000";
				img_red <= "1111";
				img_green <= "0000";
			end if;
			
        else
        -- sinon on affiche du noir
            img_blue <= "0000";
			img_red <= "0000";
			img_green <= "0000";
        
        end if;
    end process;
	
	process (img_clk, img_blank)
	begin 
		if(img_blank = '1') then
			ycount_s <= (others => '0');
			xcount_s <= (others => '0');
		elsif(rising_edge(img_clk))then
			--640 480
			if(xcount_s = 639)then
				xcount_s <= (others => '0');
				if(ycount_s = 479)then
					ycount_s <= (others => '0');
				else
					ycount_s <= ycount_s+1;
				end if;
			else
				xcount_s <= xcount_s +1;
			end if;
		end if;
	end process;
  
end rtl;