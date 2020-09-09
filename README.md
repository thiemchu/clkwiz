# Clocking wizard IP core generator
This repository contains scripts for generating Xilinx Vivado clocking wizard IP core (xci file).

# Usage
```bash
./clkwiz.sh <target_fpga> <clkin_type> <clkin_freq (MHz)> <clkout_freq (MHz)> <vivado version (e.g., 20174, 20183, etc.)>
```
- target_fpga: the current scripts support four fpga boards
  - v7 &rarr; vc707 board
  - nv &rarr; nexys video board
  - na100 &rarr; nexys a7-100t (nexys 4 ddr) board
  - aa35 &rarr; arty a7-35t board
- clkin_type: input clock type
  - s &rarr; single ended clock capable pin
  - d &rarr; differential clock capable pin
  - b &rarr; global buffer
  - n &rarr; no buffer
- clkin_freq: input clock frequency (MHz) (must be a number with three fractional digits (e.g., 100.000, 83.333))
- clkout_freq: output clock frequency (MHz) (must be a number with three fractional digits (e.g., 100.000, 83.333))
- vivado version: the current scripts support four versions
  - 20174 &rarr; 2017.4
  - 20183 &rarr; 2018.3
  - 20191 &rarr; 2019.1
  - 20192 &rarr; 2019.2

# Output
The output xci file (```clk_wiz_0.xci```) is located at the following directory:
```
ip/clk_wiz_0/
```
The scripts also generate some log files in the following directory:
```
log/
```
