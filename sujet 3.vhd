library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity incre is
	port (
		RST,BUT_LEFT,BUT_RIGHT,CLK : in std_logic;
		LED : out STD_LOGIC_VECTOR(15 downto 0)
	);
end incre;

architecture rtl of incre is
	signal state : STD_LOGIC_VECTOR(3 downto 0);
	signal compteur : STD_LOGIC_VECTOR(23 downto 0);
begin -- Shift Register
	
	process (RST, CLK)
	begin
		if (RST ='1') then
			compteur <= (others => '0');
		elsif(rising_edge(CLK)) then
			compteur <= compteur + 1;
		end if;
	end process;
	
	process (RST, compteur(23),BUT_LEFT,BUT_RIGHT)
	begin
		if (RST ='1') then
			state <= (others => '0');
		elsif(rising_edge(compteur(23))) then
			if(BUT_LEFT ='1' and state /= "1111") then
				state <= state+1;
			elsif(BUT_RIGHT='1' and state /= "0000") then
				state <= state-1;
			end if;
		end if;
	end process;
	
	process(state)
	begin
		case state is
			when "0000" => LED <= "0000000000000001";
			when "0001" => LED <= "0000000000000010";
			when "0010" => LED <= "0000000000000100";
			when "0011" => LED <= "0000000000001000";
			when "0100" => LED <= "0000000000010000";
			when "0101" => LED <= "0000000000100000";
			when "0110" => LED <= "0000000001000000";
			when "0111" => LED <= "0000000010000000";
			when "1000" => LED <= "0000000100000000";
			when "1001" => LED <= "0000001000000000";
			when "1010" => LED <= "0000010000000000";
			when "1011" => LED <= "0000100000000000";
			when "1100" => LED <= "0001000000000000";
			when "1101" => LED <= "0010000000000000";
			when "1110" => LED <= "0100000000000000";
			when "1111" => LED <= "1000000000000000";
			when others => LED <= (others => '0');
		end case;
	end process;
end rtl;

