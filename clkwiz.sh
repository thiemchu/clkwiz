#!/bin/bash

if [ $# != 5 ]; then
    echo "Usage: ./clkwiz.sh <target_fpga> <clkin_type> <clkin_freq (MHz)> <clkout_freq (MHz)> \\"
    echo "                   <vivado version (e.g., 20174, 20183, etc.)>"
    echo "    target_fpga: v7    -> vc707 board"
    echo "                 nv    -> nexys video board"
    echo "                 na100 -> nexys a7-100t (nexys 4 ddr) board"
    echo "                 aa35  -> arty a7-35t board"
    echo "    clkin_type:  s     -> single ended clock capable pin"
    echo "                 d     -> differential clock capable pin"
    echo "                 b     -> global buffer"
    echo "                 n     -> no buffer"
    echo "clkin_freq and clkout_freq must be numbers with three fractional digits (e.g., 100.000, 83.333)"
    echo "Got $# args"
    exit
fi

target_fpga_code=$1
clkin_type=$2
clkin_freq=$3
clkout_freq=$4
vivado_ver=$5

if [ $vivado_ver -eq 20174 ]; then
    vivado_bin="/opt/Xilinx/Vivado/2017.4/bin/vivado"
    ip_ver="5.4"
elif [ $vivado_ver -eq 20183 ]; then
    vivado_bin="/tools/Xilinx/Vivado/2018.3/bin/vivado"
    ip_ver="6.0"
elif [ $vivado_ver -eq 20191 ]; then
    vivado_bin="/tools/Xilinx/Vivado/2019.1/bin/vivado"
    ip_ver="6.0"
elif [ $vivado_ver -eq 20192 ]; then
    vivado_bin="/tools/Xilinx/Vivado/2019.2/bin/vivado"
    ip_ver="6.0"
else
    echo "Not supported vivado version"
    exit
fi

if [ $target_fpga_code = "v7" ]; then # vc707 board
    target_fpga="xc7vx485tffg1761-2"
elif [ $target_fpga_code = "nv" ]; then # nexys video board
    target_fpga="xc7a200tsbg484-1"
elif [ $target_fpga_code = "na100" ]; then # nexys a7-100t (nexys 4 ddr) board
    target_fpga="xc7a100tcsg324-1"
elif [ $target_fpga_code = "aa35" ]; then # arty a7-35t board
    target_fpga="xc7a35ticsg324-1L"
else
    echo "Not supported fpga"
    exit
fi

echo "$vivado_bin"
echo "Target fpga device: $target_fpga"

if [ "$clkin_type" = "s" ]; then
    prim_source="Single_ended_clock_capable_pin"
elif [ "$clkin_type" = "d" ]; then
    prim_source="Differential_clock_capable_pin"
elif [ "$clkin_type" = "b" ]; then
    prim_source="Global_buffer"
else
    prim_source="No_buffer"
fi

prim_in_freq=$clkin_freq
clkout1_requested_out_freq=$clkout_freq
use_locked="true"
locked_port="locked"
use_reset="true"
reset_type="ACTIVE_HIGH"
reset_port="reset"

current_dir=`pwd`

ip_dir="${current_dir}/ip"
mkdir -p $ip_dir

log_dir="${current_dir}/log"
mkdir -p $log_dir

rm -rf ${log_dir}/vivado_*

tcl_file="${current_dir}/clkwiz.tcl"
log_file="${log_dir}/vivado.log"
jou_file="${log_dir}/vivado.jou"

$vivado_bin \
    -log $log_file \
    -journal $jou_file \
    -mode batch \
    -source $tcl_file \
    -tclargs $target_fpga $ip_ver $ip_dir $prim_source $prim_in_freq \
    $clkout1_requested_out_freq $use_locked $locked_port $use_reset $reset_type $reset_port \
    > ${log_dir}/stdout.txt \
    2> ${log_dir}/stderr.txt
