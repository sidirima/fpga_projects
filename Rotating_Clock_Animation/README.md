# Rotating Clock Animation Sequence
This project is based on the the Experiment 4.7.3 on Chapter 4 of the book "_FPGA Programming by VHDL Examples_" by Dr. Pong P. Chu.
## How it works
In the Experiment of the book, we are supposed to implement a simle sequence of a small rotating square on 4 different 7 Segment Displays.

In my implementation, I used a 16 Segment Display and I inspired a rotating "clock" animation that I had seen in an old Philips VCR from the late 1990s.
Every time a VHS cassette was inserted in the VCR slot, there was the same implemented rotating "clock" animation informing the user to wait before using the VCR, so as to check
the index markers of the recordings in the tape (a Philips proprietary system that was called "Tape Manager" and allowed databasing of VHS recordings in the VCR memory). 

Anyway, in this project there is an implementation of a simple sequential counter. For each counted number, different segments of the LED display light up in sequence to create
that rotating "clock" animation. The max state of the counter is 7, and then it recycles. In the picture below, are the 7 states patterns of the display. Created with
[Geocaching Toolbox](https://www.geocachingtoolbox.com/index.php?lang=en&page=segmentDisplay)
<p align = "center"> <img width="321" height="59" alt="image" src="https://github.com/user-attachments/assets/1b936d8b-da14-46f2-b419-48470aad2c72" />
</p>
In order for the animation to be seen clearly, we need to use a clock divider, because the counter is synchronous and the states change with a clock pulse. The crystal oscillator
of the FPGA development board I used has a frequency of 25 MHz. The desired frequency I went with is 2.5 Hz, so the clock divider consists of a counter that counts up to 10000000.
Every time the counter reaches that number, there is a signal named "ms_tick" that changes from 0 to 1 creating that pulse of the "slow" clock. That "ms_tick" is the clock we use
to change the states of the rotating animation sequence.

The animation is continuous and the only interaction the user can have with the system is to press a pushbutton for reseting the procedure.


## Module Structure
- [rot_clock_top](rot_clock_top.vhd)
  - [rot_clk_16_seg](rot_clk_16_seg.vhd)

## Inputs & Outputs
**INPUTS**
- Reset → Performs a clear register and counters function (Pushbutton)


**OUTPUTS**
- seg → LED Output (16 Segment Display)

_*Note: The VHDL modules are implemented with Active-Low logic I/O and Common Cathode 16 Segment LED Display.*_

