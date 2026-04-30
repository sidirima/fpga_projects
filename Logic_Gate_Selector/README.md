# Logic Gate Selector
This is my first project using VHDL. It is a simple demonstation of logic gate functionality.

## How it works
The project is a very simple implementation of the 8 basic logic gates, using two single bit inputs, A and B, which in the top level module are labeled as extA and extB.
There is also a 3-bit input labeled extSel, which performs the selection of the logic function between the two inputs. The selection is performed with the use of
a multiplexer. Below, there is an image of the match-up between the Sel input and the logic function performed between the two single bit inputs. 
<p align = "center">
<img width="295" height="662" alt="image" src="https://github.com/user-attachments/assets/a36e5a7b-3400-4073-bd40-7ffc81ebb20f" />

</p>

The two single bit inputs are connected to DIP switches, and the same is for the multiplexer input. The desired output is displayed to a single LED.

The use of the top level module is only if we desire the inputs and outputs implemented with Active-Low logic. To perform that otherwise, we have the
option of using the De Morgan theorem and perform "logic inversion" in the Boolean Algebra functions of each gate, but that would be wasteful in terms
of logic cells inside the FPGA. 

In case of Active-High I/O, we can use the logicGateSelector.vhd module by itself. 

## Module Structure
- [logicGateSelector_top](logicGateSelector_top.vhd)
  - [logicGateSelector](logicGateSelector.vhd)
## Inputs & Outputs
**INPUTS**
- extA → 1 bit input for A (DIP switch)
- extB → 1 bit input for B (DIP switch)
- extSel → 3 bit input for desired logic function (DIP switches)

**OUTPUTS**
- extY → 1 bit output for Y (LED)
  
## Technical Limitations
- The project was implemented in Xilinx ISE suite v10.1, which is a legacy product, so it is formatted in VHDL-93.
- The outputs and inputs of the Spartan-II board I used were Active-Low, so in the top level module every input and output is inverted.
