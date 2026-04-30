# Parking Lot Occupancy Counter
This project is the Experiment 5.5.3 on Chapter 5 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
Imagine there is a parking lot entrance with two sensors (A and B) that detect the presence of a vehicle or human. Those two sensors are placed a few meters apart, so that only a vehicle stationed behind the bars of the parking lot could enable them both at the same time. Those two sensors are connected to a counter system that detects how many vehicles are inside the parking lot at any given moment. This project simulates those functionalities with the use of a simple counter implementation, that is being updated every time a car enters or exits the parking lot. The Figure 5.11 below offers a visual diagram of the discussed concept.
<p align="center">
  <img width="364" height="344" alt="image" src="https://github.com/user-attachments/assets/a164d8a8-8fcd-4cf6-97a9-0ada79d49cc5" />
</p>


Furthermore, there is a maximum capacity of cars that can enter the parking lot, and this is an input that must be declared before starting the counter. To simulate this, we use an 8-bit input with DIP switches, so the maximum number of spaces in the parking lot is 255.

The functionality of the entering or exiting procedures are checked in the parking_lot_fsm module and they are as follows:
- _**Car Enters the Parking Lot**_: Sensor A Enabled → Sensor A & B Enabled → Sensor B Enabled → Sensors Disabled
- _**Car Exits the Parking Lot**_: Sensor B Enabled → Sensor A & B Enabled → Sensor A Enabled → Sensors Disabled

The two sensors are simulated with the use of two pushbuttons. There is also a third pushbutton used that performs the "Reset" function. Those pushbuttons are already physically debounced, so there is no implementation of a debouncer circuit in VHDL. 

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
- a → Sensor A (Pushbutton)
- b → Sensor B (Pushbutton)
- max_cap → 8-bit binary for desired maximum parking spaces (DIP Switches)

**OUTPUTS**
- sseg0 → LSD output (7 Segment Display)
- sseg1 → MSD output (7 Segment Display)
- ovf → 2 bit Overflow flag (LEDs)
- full → _FULL_ flag (LED)
- vacant → _VACANCY / SPACE AVAILABLE_ flag (LED)
_
*Note: The VHDL modules are implemented with Active-Low logic I/O and Common Anode 7 Segment LED Displays.*_

