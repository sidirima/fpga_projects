# Dual Edge Detector
This project is the Experiment 5.5.1 on Chapter 5 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
An edge detecting circuit is a simple sequential circuit with the ability to detect the input pulse's (e.g. a clock signal) rising or falling edge. 
When the desired state is detected, a short one-clock-cycle pulse is generated on the output.

In Chapter 5 of the book, there are two design examples of a rising edge detector **_FSM_**.
The first one is a Moore-machine based and the second is a Mealy-machine based.
The difference between the two designs is that Moore-based FSMs are synchronous, meaning that the outputs change ONLY when the clock changes. Therefore, the outputs are only a function of the current state and not dependent to the input signals.
On the other hand, Mealy-based FSMs are asynchronous, meaning they are not always clock-dependent. Therefore, the output state is dependent on the current state AND the inputs state.
These two different designs are depicted in the picture below.
<p align="center">
  <img <img width="1200" height="800" alt="image" src="https://github.com/user-attachments/assets/3b7df304-fb59-459f-9a34-8f0c14290427" />
</p>

To design the dual edge detector FSM we can use StateCAD, a simple FSM designer program included in Xilinx ISE suite and then derive the VHDL code equivalent to the FSM or we can directly write the FSM on VHDL.
For dual edge detecting, we need the output enabled for one clock cycle when the input changes from 0 to 1 (rising edge) and also from 1 to 0 (falling edge).

Due to the 25 MHz oscillator of the FPGA, this project is impossible to implement on physical form, so we need to create a **testbench** file to determine the functionality of designed FSM. This file is dual_edge_detector_tb.vhd.
In the file, there are two instantiations of the edge detector, one for each architecture (Moore-based and Mealy-based) so that we can monitor the output simultaneously using a Behavioral Simulation program, such as ISE Simulator or ModelSim.



The counter increases by 1 every time a car enters the lot, and decreases by 1 every time a car exits the lot. The counter cannot be incremented when reached the maximum capacity of spaces in the parking lot. When it reaches that state, it triggers a "FULL" flag that is represented by an LED. A different LED shows up while there are available spaces, named "vacant". Furthermore, the counter cannot be decremented further than 0. 

The output of the counter is represented on 2 different 7 Segment LED displays. Those displays are updated live (with the pulse of an internal clock signal) every time a car enters or exits the lot. To represent the counter number on different 7 Segment Displays, there is an FSM implementation of the Double Dabble Algorithm, inside the bin2bcd_dd.vhd module, which is instantiated in the top level module. In addition to the 7 Segment Displays, due to hardware limitations, the MSD of the BCD number (the "hundreds") is represented with the use of 2 different LEDs, named as "ovf" which stands for Overflow. If the MSD is 0, none of the LEDs light up, if the MSD is 1 only 1 of the LEDs light up and last, in case the number is 2, both of the LEDs are enabled. 

## Module Structure
- [pakring_lot_occupancy_top](pakring_lot_occupancy_top.vhd)
  - [pakring_lot_fsm](pakring_lot_fsm.vhd)
  - [hex_to_7_segment](hex_to_7_segment.vhd)
  - [bin2bcd_dd](bin2bcd_dd.vhd)

## Inputs & Outputs
**INPUTS**
- Reset → Performs a clear register and counters function (Pushbutton)
- Level → Input Signal (Pulse)

**OUTPUTS**
- edge → Output signal (Pulse)

## Technical Limitations
- The project was implemented in Xilinx ISE v10.1, which is a legacy product, therefore it is formatted in VHDL-93.
- The VHDL modules are implemented with Active-Low logic I/O due to the Spartan-II development board architecture.
- The 7 Segment Displays used where Common Anode, so a Segment to be active, it must receive a "0".
