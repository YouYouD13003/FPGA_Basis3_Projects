library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity chenillard is
port (
CLK, RST : in std_logic;
LED : out STD_LOGIC_VECTOR(15 downto 0));

end chenillard;



architecture rtl of chenillard is
signal clock_div : std_logic_vector(23 downto 0);
signal shift_reg : STD_LOGIC_VECTOR(15 downto 0) ;
begin



-- Clock Divider
process (CLK,RST)
begin
if (CLK'event and CLK = '1' and RST = '0') then
clock_div <= clock_div + '1';
end if;
end process;




-- Shift Register
process (clock_div(23), RST)
begin
if (RST = '0') then
if (clock_div(23)'event and clock_div(23) = '1') then
shift_reg(0) <= shift_reg(15);
shift_reg(14) <= shift_reg(13);
shift_reg(13) <= shift_reg(12);
shift_reg(12) <= shift_reg(11);
shift_reg(11) <= shift_reg(10);
shift_reg(10) <= shift_reg(9);
shift_reg(9) <= shift_reg(8);
shift_reg(8) <= shift_reg(7);
shift_reg(7) <= shift_reg(6);
shift_reg(6) <= shift_reg(5);
shift_reg(5) <= shift_reg(4);
shift_reg(4) <= shift_reg(3);
shift_reg(3) <= shift_reg(2);
shift_reg(2) <= shift_reg(1);
shift_reg(1) <= shift_reg(0);
shift_reg(15) <= shift_reg(14);
end if;
else
shift_reg<=x"0001";
end if;
end process;

-- hook up the shift register bits to the LEDs
LED <= shift_reg;



end rtl;