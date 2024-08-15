# FPGA_Basis3_Projects
VHDL/FPGA Project - Basys3 Board with Vivado
This repository contains the VHDL projects developed as part of my coursework at ISEN, where I utilized the Basys3 board by Xilinx and the Vivado development environment to explore various digital design concepts and FPGA implementations.

Project Highlights:

LED Blinking: Implemented a basic LED blinking circuit with defined ON/OFF states using VHDL to control the LED via a clock divider.

LED Chaser (Chenillard): Developed a chaser light sequence across multiple LEDs, utilizing clock division and bit-shifting techniques to create the visual effect.

Incremental and Decremental LED Counter: Designed a 4-bit binary counter with buttons to increment or decrement the LED states, demonstrating basic counting logic in VHDL.

7-Segment Display Control: Controlled a 7-segment display to continuously show identical digits across all segments, with a focus on clock division and state management.

4-Digit Display with Clock Division: Enhanced the display control to manage 4 different digits, utilizing clock division to control individual segments and digits.

Stopwatch Implementation: Created a stopwatch that displays minutes and seconds on a 7-segment display, managing time increments with clock dividers.

Monochrome VGA Display: Developed a VGA controller to display a fixed monochrome image, adjusting clock frequencies for proper VGA signal timing.

Tri-color VGA Display: Extended the VGA controller to display a tricolor image, such as the French flag, by dividing the screen into sections and assigning specific RGB values to each section.

Tools and Technologies:

VHDL: Used for coding and designing the digital circuits.

Vivado: Xilinx’s development environment for synthesizing and implementing VHDL code on the Basys3 board.

Modelsim: Utilized for simulating and verifying the behavior of VHDL designs before deployment.
