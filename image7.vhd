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


begin
    process (img_blank)
    begin
        --couleur
		if img_blank = '0' then
			img_blue <= "1111";
			img_red <= "1111";
			img_green <= "0111";
			
        else
        -- sinon on affiche du noir
            img_blue <= "0000";
			img_red <= "0000";
			img_green <= "0000";
        
        end if;
    end process;
  
end rtl;