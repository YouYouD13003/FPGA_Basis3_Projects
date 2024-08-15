library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- port exterieur --
entity exo8 is port(
	RST        : in std_logic;
	CLK        : in std_logic;
	Hsync	   : out std_logic;
	Vsync	   : out std_logic;
	vgaBlue    : out std_logic_vector(3 downto 0);
	vgaGreen   : out std_logic_vector(3 downto 0);
	vgaRed     : out std_logic_vector(3 downto 0)
);
end exo8;

architecture Behavioral of exo8  is

-- sous partie --
-- vga_controler
-- coordonee des pixel 
component ImgFixe  
	port(
		rst         : in std_logic;
		pixel_clk   : in std_logic;
		HS          : out std_logic;
		VS          : out std_logic;
		hcount      : out std_logic_vector(10 downto 0);
		vcount      : out std_logic_vector(10 downto 0);
		blank       : out std_logic
	);
end component;


-- sous partie --
-- construit l'image
component Image
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
end component;


signal hcount_s : std_logic_vector(10 downto 0);
signal vcount_s : std_logic_vector(10 downto 0);
signal blank_s :   std_logic;
signal HS_s          :  std_logic;
signal VS_s          :  std_logic;
signal blue_s      :  std_logic_vector(3 downto 0);
signal green_s      :  std_logic_vector(3 downto 0);
signal red_s       :  std_logic_vector(3 downto 0);
signal rst_s : std_logic;

signal clk_s : std_logic;
signal clk25M_s : std_logic_vector(1 downto 0);

begin
	img_cont:ImgFixe 
	port map(
		rst => rst_s,
		pixel_clk => clk_s,
		HS => HS_s,
		VS => VS_s,
		hcount => hcount_s,
		vcount => vcount_s,
		blank => blank_s
	);
	
	img_i : Image 
	port map(
		img_rst => rst_s,
		img_clk => clk_s,
		img_blank => blank_s,
		img_blue => blue_s,
		img_green => green_s,
		img_red => red_s
	);

	rst_s <= rst;
	Hsync <= HS_s;
	Vsync <= VS_s;
	vgaBlue <= blue_s;
	vgaGreen <= green_s;
	vgaRed <= red_s;
	
	--clock de 25 MHzv
	process(CLK, RST) 
	begin
	   if(RST = '1')then
	       clk25M_s <= "00";
	   elsif(CLK'event and CLK = '1')then
	       clk25M_s <= clk25M_s + 1;
	   end if;
	end process;
	
	clk_s <= clk25M_s(1);
	
end Behavioral;
