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

In our project, we will use the LED segments of a 7 Segment display to visualize the PWM dimming. We use a 7 segment multiplexer but it is not really necessary as we only need to use 1 digit.

The duty cycle variable is a 4 bit input called "_w_" on **led_dim.vhd** module. On top level module, we use the input 1 bit input "_sw_" (a simple pushbutton) to variate the "_w_" value. 
Each pushbutton press varies the duty cycle by w/16. By pushing the pushbutton, the value displayed on the 7 segment display changes, following the counter value of w. This is perfromed in **led_dimmer_top.vhd**. 

To perform synchronous variation of brightness on all 8 segments (including the dp), when instantiating the led_dimmer entities we use a "FOR" loop. This will generate 8 independent led_dimmer entities, each one used when necessary, defined by the w_count value that needs to be displayed.

To check that every press of the pushbutton changes the duty cycle value by w/16, we can use a testbench file **led_dimmer_tb.vhd** or we can use an oscilloscope. In the video file contatined in the project folder we can see the oscilloscope screen and the dimming of the LEDs while pressing the pushbutton.

## Module Structure
- [led_dimmer_top](led_dimmer_top.vhd)
  - [led_dimmer](led_dimmer.vhd)
  - [disp_hex_mux](disp_hex_mux.vhd)

## Inputs & Outputs
**INPUTS**
- Reset → Performs a clear register and counters function (Pushbutton)
- sw → Duty Cycle value (Pushbutton)

**OUTPUTS**
- sseg → 7 segment output (7 Segment Display)
- an → 4 bit anode selector

## Technical Limitations
- The project was implemented in Xilinx ISE v10.1, which is a legacy product, therefore it is formatted in VHDL-93.
- The VHDL modules are implemented with Active-Low logic I/O due to the Spartan-II development board architecture.
- The 7 Segment Displays used where Common Anode, so a Segment to be active, it must receive a "0".
- The pushbuttons used are already debounced.
