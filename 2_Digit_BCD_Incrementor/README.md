# 2 Digit BCD Incrementor
This project is the Experiment 3.9.3 on Chapter 3 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
In the top level module, there are 2 instantiations of the bcd_incrementor entity, the purpose of which is to perform incrementation by 1 bit of two BCD formatted numbers. On each of the bcd_incrementor entities, there is a carry output, in case of an overflow in the incrementation procedure. In this case, if there is an overflow in the LSD, the carry output is inserted in the next incrementing entity. If there in an overflow at the MSD entity, the incrementor has reached its maximum capacity, and the Overflow output is enabled.

The input numbers are inserted as binary data with the use of 4 DIP switches for each number. If the DIP switches form a number that it is not accepted in the BCD format, then the display output is disabled.

In the matter of outputs, the BCD numbers are represented with the use of 7 Segment LED Displays, one for each number. The signals to activate each segment are created in the hex_to_7_segment.vhd module, which is instantiated twice in the top level module.

## Module Structure
- [bcd_incrementor_top](bcd_incrementor_top.vhd)
  - [bcd_incrementor](bcd_incrementor.vhd)
  - [hex_to_7_segment](hex_to_7_segment.vhd)
## Inputs & Outputs
**INPUTS**
- a → 8 bit input (2x4 bits) for the two numbers (DIP Switches)

**OUTPUTS**
- sseg0 → LSD output (7 Segment Display)
- sseg1 → MSD output (7 Segment Display)
- ovf → Overflow flag (LED)
## 
