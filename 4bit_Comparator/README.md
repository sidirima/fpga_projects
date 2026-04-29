# 4bit Comparator
This project is an experimentation to test the versatility and expandability of VHDL. It is based on a 1bit Comparator circuit described in Chapter 2 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
In the top level module, there is an instantiation of the comparator_4bit.vhd entity, which is structured by instantiating 2 seperate comparator_2bit.vhd modules. In that manner, we can extend the project to compare numbers of every even width. 

The input numbers are inserted as binary with the use of 2 DIP switches for each number. Then, the numbers are split in two bits for each 2bit comparator and then both halves are compared. If they are equal, the equal output is enabled. If they are different, there are two different options.
- Either A > B, where the A number value is greater than B
- Or A < B, where the A number value is smaller than B

Therefore, there are 3 different outputs which are represented by 3 different LEDs.

## Module Structure
- [comparator_4bit_top](comparator_4bit_top.vhd)
  - [comparator_4bit](comparator_4bit.vhd)
    - [comparator_2bit](comparator_2bit.vhd)
## Inputs & Outputs
**INPUTS**
- extA → 4 bit input for number A (DIP switches)
- extB → 4 bit input for number B (DIP switches)

**OUTPUTS**
- extAeqB → A = B output (LED)
- extAgrB → A > B output (LED)
- extAsmB → A < B output (LED)
## 

