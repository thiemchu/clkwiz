#########################################################################
if {[llength $argv] != 11} {
    puts "Usage: clkwiz.tcl <target_fpga> <ip_ver> <ip_dir> <prim_source> <prim_in_freq> <clkout1_requested_out_freq>"
    puts "                  <use_locked> <locked_port> <use_reset> <reset_type> <reset_port>"
    puts "Got [llength $argv] arguments."
    exit
}

#########################################################################
set target_fpga                [lindex $argv 0]
set ip_ver                     [lindex $argv 1]
set ip_dir                     [lindex $argv 2]
set prim_source                [lindex $argv 3]
set prim_in_freq               [lindex $argv 4]
set clkout1_requested_out_freq [lindex $argv 5]
set use_locked                 [lindex $argv 6]
set locked_port                [lindex $argv 7]
set use_reset                  [lindex $argv 8]
set reset_type                 [lindex $argv 9]
set reset_port                 [lindex $argv 10]

set_part $target_fpga

create_ip -name clk_wiz -vendor xilinx.com -library ip -version $ip_ver -module_name clk_wiz_0 -dir $ip_dir -force
set_property -dict [list CONFIG.PRIM_SOURCE $prim_source CONFIG.PRIM_IN_FREQ $prim_in_freq CONFIG.CLKOUT1_REQUESTED_OUT_FREQ $clkout1_requested_out_freq CONFIG.USE_LOCKED $use_locked CONFIG.LOCKED_PORT $locked_port CONFIG.USE_RESET $use_reset CONFIG.RESET_TYPE $reset_type CONFIG.RESET_PORT $reset_port] [get_ips clk_wiz_0]
