# Stopwatch with 4 Digits 
This project is the Experiment 4.7.6 on Chapter 4 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
The suggested experiment focus on the expansion on the logic of a simple 3 digit stopwatch described as a design example in Chapter 4 of the book. That simple stopwatch displays the time as 3 decimal
digits, counting from 00.0 to 99.9 seconds and then wraps around. It contains a synchronous clear signal **clr**, which returns the count to 00.0 and an enable signal **go**, which enables or suspends
counting.

The counting procedure is a simple BCD counter. In BCD format, a decimal number is represented by a sequence of 4 digits, as shown in the picture below.
So, for the decimal number **42**, the BCD equivalent number is: **0100 0010**. 
<p align="center"> 
  <img width="142" height="201" alt="image" src="https://github.com/user-attachments/assets/f9088615-2db1-4d87-bf4d-70b47ccc7aa4" />
</p>

Also, we need to create a clock with 0.1 second period for our counting to be accurate and be able to see the 7 segment digits change. This clock signal is a very 
"slow" clock in contrast with the 25 MHz that the Spartan-II FPGA uses. For that, we use the **clock division** technique,
the simplest yet best known solution to create a custom clock signal.

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

## Technical Limitations
- The project was implemented in Xilinx ISE v10.1, which is a legacy product, therefore it is formatted in VHDL-93.
- The VHDL modules are implemented with Active-Low logic I/O due to the Spartan-II development board architecture.
- The 7 Segment Displays used where Common Anode, so a Segment to be active, it must receive a "0".

