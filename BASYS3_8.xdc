## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports CLK]
 


# Reset signal
set_property PACKAGE_PIN U18 [get_ports {RST}]
set_property IOSTANDARD LVCMOS33 [get_ports {RST}]

# Hsync and Vsync signals
set_property PACKAGE_PIN P19 [get_ports {Hsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {Hsync}]
set_property PACKAGE_PIN R19 [get_ports {Vsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {Vsync}]

# VGA signals
set_property PACKAGE_PIN G19 [get_ports {vgaRed[3]}]
set_property PACKAGE_PIN H19 [get_ports {vgaRed[2]}]
set_property PACKAGE_PIN J19 [get_ports {vgaRed[1]}]
set_property PACKAGE_PIN N19 [get_ports {vgaRed[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[*]}]

set_property PACKAGE_PIN J17 [get_ports {vgaGreen[3]}]
set_property PACKAGE_PIN H17 [get_ports {vgaGreen[2]}]
set_property PACKAGE_PIN G17 [get_ports {vgaGreen[1]}]
set_property PACKAGE_PIN D17 [get_ports {vgaGreen[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[*]}]

set_property PACKAGE_PIN N18 [get_ports {vgaBlue[3]}]
set_property PACKAGE_PIN L18 [get_ports {vgaBlue[2]}]
set_property PACKAGE_PIN K18 [get_ports {vgaBlue[1]}]
set_property PACKAGE_PIN J18 [get_ports {vgaBlue[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[*]}]
