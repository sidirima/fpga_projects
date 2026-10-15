# PWM LED Dimmer
This project is the Experiment 4.7.2 on Chapter 4 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
Duty cycle of a square wave is defined as the percentage of the ON interval (HIGH signal or Logic-1) in a period. **_PWM_** stands for **_Pulse Width Modulation_** and it is a way of controlling the variable
amplitude of analog signals using a digital input pulse.

Dimmers are variable resistance devices that control the brightness of an incandescent light bulb by varying its input voltage. With LED bulbs, using a variable resistor to control brightness is not
possible, because LEDs are diodes and thus not capable of working when the input voltage is very low. In order to achieve this, we use PWM dimmers. The PWM signal actually controls the frequency of on/off
and thus creating an optical illusion of dimming the brightness. This principle is represented on the figure below.
<p align="center">
  <img <img width="704" height="564" alt="image" src="https://github.com/user-attachments/assets/36fcfff4-b5c7-4989-ab0f-66bd122e3d86" />
</p>

In our project, we will use the LED segments of a 7 Segment display to visualize the PWM dimming. We use 2 different 7 segment displays, one fully bright and the other dimmed according to our variable
duty cycle.

The duty cycle variable is a 4 bit input called "_w_" on **led_dim.vhd** module. On top level module, we use the input 1 bit input "_sw_" (a simple pushbutton) to variate the "_w_" value. 
Each pushbutton press varies the duty cycle by w/16. 

Furthermore, there is a maximum capacity of cars that can enter the parking lot, and this is an input that must be declared before starting the counter. To simulate this, we use an 8-bit input with DIP switches, so the maximum number of spaces in the parking lot is 255.

The functionality of the entering or exiting procedures are checked in the parking_lot_fsm module and they are as follows:
- _**Car Enters the Parking Lot**_: Sensor A Enabled → Sensor A & B Enabled → Sensor B Enabled → Sensors Disabled
- _**Car Exits the Parking Lot**_: Sensor B Enabled → Sensor A & B Enabled → Sensor A Enabled → Sensors Disabled

The two sensors are simulated with the use of two pushbuttons. There is also a third pushbutton used that performs the "Reset" function. Those pushbuttons are already physically debounced, so there is no implementation of a debouncer circuit in VHDL. 

The counter increases by 1 every time a car enters the lot, and decreases by 1 every time a car exits the lot. The counter cannot be incremented when reached the maximum capacity of spaces in the parking lot. When it reaches that state, it triggers a "FULL" flag that is represented by an LED. A different LED shows up while there are available spaces, named "vacant". Furthermore, the counter cannot be decremented further than 0. 

The output of the counter is represented on 2 different 7 Segment LED displays. Those displays are updated live (with the pulse of an internal clock signal) every time a car enters or exits the lot. To represent the counter number on different 7 Segment Displays, there is an FSM implementation of the Double Dabble Algorithm, inside the bin2bcd_dd.vhd module, which is instantiated in the top level module. In addition to the 7 Segment Displays, due to hardware limitations, the MSD of the BCD number (the "hundreds") is represented with the use of 2 different LEDs, named as "ovf" which stands for Overflow. If the MSD is 0, none of the LEDs light up, if the MSD is 1 only 1 of the LEDs light up and last, in case the number is 2, both of the LEDs are enabled. 

## Module Structure
- [led_dimmer_top](led_dimmer_top.vhd)
  - [led_dimmer](led_dimmer.vhd)
  - [disp_hex_mux](disp_hex_mux.vhd)

## Inputs & Outputs
**INPUTS**
- Reset → Performs a clear register and counters function (Pushbutton)
- sw → Sensor A (Pushbutton)

**OUTPUTS**
- sseg → 7 segment output (7 Segment Display)
- an → 4 bit anode selector

## Technical Limitations
- The project was implemented in Xilinx ISE v10.1, which is a legacy product, therefore it is formatted in VHDL-93.
- The VHDL modules are implemented with Active-Low logic I/O due to the Spartan-II development board architecture.
- The 7 Segment Displays used where Common Anode, so a Segment to be active, it must receive a "0".
