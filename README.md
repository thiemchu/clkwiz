# Clocking wizard IP core generator
This repository contains scripts for generating Xilinx Vivado clocking wizard IP core (xci file).

# Usage
```bash
./clkwiz.sh <target_fpga> <clkin_type> <clkin_freq (MHz)> <clkout_freq (MHz)> <vivado version (e.g., 20174, 20183, etc.)>
```
- target_fpga: the current script support only three fpga boards
  - v7 &rarr; vc707 board
  - nv &rarr; nexys video board
  - na &rarr; nexys a7-100t (nexys 4 ddr) board
- clkin_type: input clock type
  - s &rarr; single ended clock capable pin
  - d &rarr; differential clock capable pin
  - b &rarr; global buffer
  - n &rarr; no buffer
- clkin_freq: input clock frequency (MHz) (must be an integer number)
- clkout_freq: output clock frequency (MHz) (must be an integer number)
- vivado version: the current scripts support only two versions
  - 20174 &rarr; 2017.4
  - 20183 &rarr; 2018.3