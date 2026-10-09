# FPGA Projects

This folder contains fun projects I implemented from examples from the following books, learning VHDL coding and FPGA implementation. Some of them were little tweaked, some of them are built from scratch.

The code is written in VHDL-93, due to device limitations, as the FPGA used is supported up to v10.1 of Xilinx ISE, which is a quite old version of a legacy suite. The FPGA used was a Spartan-II (XC2S100 - PQ208).
<p align="center">
  <img width="999" height="756" alt="image" src="https://github.com/user-attachments/assets/6a5e32f6-b022-41b0-a2cb-d6382c8bd3dc" />

</p>

### Books
1. [Chu, Pong P. FPGA Prototyping by VHDL Examples: Xilinx Spartan-3 Version. Hoboken, N.J: Wiley-Interscience, 2008.](https://blog.aku.edu.tr/ismailkoyuncu/files/2017/04/02_ebook.pdf)
2. [Pedroni, Volnei A. Digital Electronics and Design with VHDL. Amsterdam, Boston, 2008.](https://uodiyala.edu.iq/uploads/PDF%20ELIBRARY%20UODIYALA/EL96/Circuit%20Design%20with%20VHDL.pdf)

### Project Index
#### 1. [Logic Gate Selector](/Logic_Gate_Selector)
A simple first project to understand the nature of the VHDL programming language, by implementing all of the basic logic functions in a single multiplexer.

#### 2. [4-Bit Comparator](/4bit_Comparator)
The scope of this project is the exploration of versatility of VHDL programming. We instantiate 2-bit comparators to implement a 4-bit comparator.

#### 3. [8-bit Barrel Shifter](/8_bit_Barrel_Shifter)
Implementation of a barrel shifter with two direction logic rotation of the bits (left or right). We can select the amount of rotating bits with the use of a multiplexer.

#### 4. [12-bit Dual Priority Encoder](/Dual_Priority_Encoder)
With simple combinational logic, this project implements a dual priority encoder that detects the position of the two most significant bits that have a value of '1' and returns their position numbers in two different 7 Segment LED Displays.

#### 5. [2 digit BCD Incrementor](/2_Digit_BCD_Incrementor)
Combinational logic at its peak! This simple circuit reads an 8bit binary number, increments it by 1 and decodes the value to BCD format. Then, the output digits are represented on 7 Segment LED Displays. There is also an overflow flag, when the value of the BCD number can not be represented in only 2 displays.

#### 6. [Stopwatch with 4 Digits](Stopwatch_with_4_Digits)
Using simple sequential logic (registers), this project implements a stopwatch with four digits, represented on 7 Segment LED Displays, and the functions of counting up or down and start / pause.

#### 7. [Rotating Clock Animation](Rotating_Clock_Animation)
An easy way to test your skills understanding counters, clock dividers and simple FSM design, with the help of a 16-Segment LED Display.
A fun made project of a rotating "clock" sequence.

#### 8. [Parking Lot Occupancy Counter](Parking_Lot_Occupancy_Counter)
With the use of sequential logic and Fine State Machine implementation we create a project that simulates a parking lot occupancy counter. The counter is represented on 7 Segment LED Displays, and there are also flags for "Full Parking Lot" and "Space Available".


#### 9. [Dual Edge Detector](Dual_Edge_Detector)
A project to determine the best use for each Finite State Machine design. A comparison between Moore and Mealy machine architecture. Experimentation with StateCAD and testbench files. 
