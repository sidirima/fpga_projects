# Dual Priority Encoder
This project is the Experiment 3.9.2 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu. With the use of only combinational logic, it is a test for the reader's abilities of expanding
a circuit that is given as an example in the specific chapter.

## How it works
In the top level module, there is an instantiation of a simple priority encoder that is used to find the position of the first '1' in a 12bit binary input, starting from the MSB. The code
for this circuit is given as an example of a 4bit priority encoder in the book. The position of the first '1' (as a 4bit binary number) is shown on the first of the two 7 Segment Displays
of the development board, with an instantiation of the hex_to_7_segment module. If the '1' is found on position 10, 11 or 12, the 7 Segment depicts the letters "A", "B" or "C" accordingly.

To find the position of the second '1' in the binary input, we will use a second instantiation of the same priority_encoder_12to4 module that we used to find the first '1'. Although, this is
a bit complicated, as we want the encoder to ignore the first most-significant '1' that we found with the first instantiation of the encoder. To achieve this, first we must invert the 4bit
binary decoded position of the most-significant '1'. Then, we perform a logic "AND" operation between the inverted decoded 4bit binary number and the original 12bit input binary number.

Then, we use the same priority encoder we used to find the first most-significant '1' and we find the position of the second. In case there are more bits that have a '1' value in the input, 
they are ignored.

## Module Structure
- [dual_priority_encoder_top](dual_priority_encoder_top.vhd)
  - [priority_encoder_12to4](priority_encoder_12to4.vhd)
  - [decoder_12to4](decoder_12to4.vhd)
  - [hex_to_7_segment](hex_to_7_segment.vhd)
  
## Inputs & Outputs
**INPUTS**
- req → 12 bit binary input for requested number (DIP switches)

**OUTPUTS**
- first → Position of the first most-significant '1' in the "req" input (7 Segment Display)
- second → Position of the second most-significant '1' in the "req" input (7 Segment Display)
  
## Technical Limitations
- The project was implemented in Xilinx ISE suite v10.1, which is a legacy product, so it is formatted in VHDL-93.
- The outputs and inputs of the Spartan-II board I used were Active Low, so in the top level module every input and output is inverted.
