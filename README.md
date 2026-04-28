# FPGA Projects

This folder contains fun projects I implemented from examples from the following books, learning VHDL coding and FPGA implementation. Some of them were little tweaked, some of them are built from scratch.

The code is written in VHDL-93, due to device limitations, as the FPGA used runs only in Xilinx ISE v10.1, which is a quite old version of a legacy suite. The FPGA used was a Spartan-II (XC2S100 - PQ208).
### Books
1. [Chu, Pong P. FPGA Prototyping by VHDL Examples: Xilinx Spartan-3 Version. Hoboken, N.J: Wiley-Interscience, 2008.](https://blog.aku.edu.tr/ismailkoyuncu/files/2017/04/02_ebook.pdf)
2. [Pedroni, Volnei A. Digital Electronics and Design with VHDL. Amsterdam, Boston, 2008.](https://uodiyala.edu.iq/uploads/PDF%20ELIBRARY%20UODIYALA/EL96/Circuit%20Design%20with%20VHDL.pdf)

### Project Index
#### 1. Logic Gate Selector
A simple first project to understand the nature of the VHDL programming language, by implementing all of the basic logic functions in a single multiplexer.

#### 2. 4-Bit Comparator
The scope of this project is the exploration of versatility of VHDL programming. We instantiate 2-bit comparators to implement a 4-bit comparator.

#### 3. 8-bit Barrel Shifter
Implementation of a barrel shifter with two direction logic rotation of the bits (left or right). We can select the amount of rotating bits with the use of a multiplexer.

#### 4. 12-bit Dual Priority Encoder
With simple combinational logic, this project implements a dual priority encoder that detects the position of the two most significant bits that have a value of '1' and returns their position numbers in two different 7 Segment LED Displays.

#### 5. 2 digit BCD Incrementor
Combinational logic at its peak! This simple circuit reads an 8bit binary number, increments it by 1 and decodes the value to BCD format. Then, the output digits are represented on 7 Segment LED Displays. There is also an overflow flag, when the value of the BCD number can not be represented in only 2 displays.

#### 6. Stopwaatch with 4 Digits
Using simple sequential logic (registers), this project implements a stopwatch with four digits, represented on 7 Segment LED Displays, and the functions of counting up or down and start / pause.

#### 7. Parking Lot Occupancy Counter
With the use of sequential logic and Fine State Machine implementation we create a project that simulates a parking lot occupancy counter. The counter is represented on 7 Segment LED Displays, and there are also flags for "Full Parking Lot" and "Space Available".

