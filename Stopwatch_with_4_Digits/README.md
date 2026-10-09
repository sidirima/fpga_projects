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
"slow" clock in contrast with the 25 MHz crystal oscillator that the Spartan-II FPGA uses. Thus, we use the **clock division** technique,the simplest yet best known solution to create a custom clock signal.
So, we create a signal named **ms_tick** and a register able to count up to 2500000. That gives us a "tick" every 0.1 seconds to use as a clock for the BCD counter.

The "enhanced version" of the simple stopwatch has the following additional features:
- One additional digit for minutes, so the display format is now **M.SS.D**
- A signal to control the direction of counting named **up**, controlled via a DIP-Switch. 

To keep track of the counters, we create a 4-bit register for each one of the 4 digits, named d3 ~ d0 from MSB to LSB accordingly. Also, since we can now control the direction of counting,
we need to create two seperate counters, an up-counter and a down counter. The counters for digits d0, d1,d3 count from 0 ~ 9 and then overflow to the next digit, but the counter for d2 will count from 0 ~ 5 and then overflow, because there are 60 seconds in one minute. The whole process is described as a nested if scenario on the enhanced_stopwatch.vhd file of the project.

As for the output, we need to use 4 different 7 segment displays. The Spartan-II board we use does not support a 4-digit 7 segment display, so we need to use an external display. Also, to avoid the usage
of 32 different pins to control all those segments, we will use **7 Segment Display Multiplexation**. Now, we only need to use 8 different pins of the FPGA to control the segments for each number and 4 additional ones to control the anodes of each display, depending on what digit need to be represented. The idea is depicted in the picture below.The multiplexation is done disp_hex_mux.vhd file of the project.
<p align = "center">
  <img <img width="705" height="555" alt="image" src="https://github.com/user-attachments/assets/adfdde73-a67d-491d-bf73-1fec4effc4ad" />
</p>

At this point, we have 
## Module Structure
- [enhanced_stopwatch_top](enhanced_stopwatch_top.vhd)
  - [enhanced_stopwatch](enhanced_stopwatch.vhd)
  - [disp_hex_mux](disp_hex_mux.vhd)
  - [bin2bcd_dd](bin2bcd_dd.vhd)

## Inputs & Outputs
**INPUTS**
- clr → Performs a clear register and counters function (Pushbutton)
- go → Start counting (Pushbutton)
- up → Counting direction (DIP-Switch)
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

