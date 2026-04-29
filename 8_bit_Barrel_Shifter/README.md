# 8 bit Multifunction Barrel Shifter
This project is the Experiment 3.9.1 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu. With the use of only combinational logic, this circuit performs a logic rotating fucntion, either to the left or to the right for the amount of bits selected.

## How it works
In the top level module, there is are two different instantiations of the shifter modules, one for left and one for right rotation. These modules, perform the rotation in 3 different stages. For each different stage, there is a pushbutton to enable or disable. Those pushbuttons are 2<sup>0</sup> (for 1 or 0 bit rotation), 2<sup>1</sup> (for 2 or 0 bit rotation) and 2<sup>2</sup> (for 4 or 0 bit rotation). By combining those pushbuttons we can rotate the input number for any amount of bits between 0 and 7. For example, if we desire a 6 position rotation, then we should press the 2<sup>2</sup> and the 2<sup>1</sup> pushbuttons.

There is a direction select input, labeled "func". If its value is a logic 0, then the circuit performs right rotation. If its value is a logic 1, then it performs a left rotation. This input is inserted via a DIP switch.

The input number is inserted as binary with the use of 8 DIP switches.

There is a single 8bit output on the top module, which is used for representing the rotated number as binary data. The output should be driven to 8 different LEDs. 

## Module Structure
- [multi_function_barrel_shifter_top](multi_function_barrel_shifter_top.vhd)
  - [barrel_shifter_8bit_left](barrel_shifter_8bit_left.vhd)
  - [barrel_shifter_8bit_right](barrel_shifter_8bit_right.vhd)
## Inputs & Outputs
**INPUTS**
- ext_a → 8 bit input for number A (DIP switches)
- ext_amt → 3 bit input for number of rotating bits (Pushbuttons)
- ext_func → 1 bit input for direction of rotation (DIP switch)

**OUTPUTS**
- ext_y → 8 bit output for rotated number (LEDs)
## 

