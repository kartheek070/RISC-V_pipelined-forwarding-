5-Stage Pipelined RISC-V Processor (Verilog)

This project implements and simulates a 32-bit 5-stage pipelined RISC-V processor in Verilog using Xilinx Vivado, based on a reference architecture.<br>
The processor follows the classical IF, ID, EX, MEM and WB pipeline structure with dedicated pipeline registers between each stage.<br>

Architecture Overview

Instruction Fetch (IF)<br>

Instruction Decode (ID) with register file access and control generation<br>

Execute (EX) stage with ALU and operand forwarding multiplexers<br>

Memory (MEM) stage with data memory interface<br>

Write Back (WB) stage to register file<br>

Key Features

32-bit datapath<br>

Control Unit with main decoder and ALU decoder<br>

Immediate generation for I-type, S-type and B-type instructions<br>

Data forwarding unit to resolve ALU-ALU data hazards<br>

Simulation-based verification using waveform analysis<br>

Debugging and Verification

During development, multiple RTL-level issues were identified and resolved, including:<br>

Signal propagation (X/Z) issues across pipeline stages<br>

Case-sensitive wiring mismatches<br>

Immediate extraction errors<br>

Forwarding priority logic bugs in hazard unit<br>

Register file initialization and write timing behavior<br>

Functional correctness was verified for arithmetic, load and branch instructions through detailed simulation in Vivado.<br>

Learning Outcomes

This project strengthened understanding of:<br>

Pipeline timing and stage synchronization<br>

Data hazards and forwarding mechanisms<br>

Control signal generation and propagation<br>

Systematic RTL debugging using waveform inspection<br>

Practical implementation of a pipelined processor architecture<br>
