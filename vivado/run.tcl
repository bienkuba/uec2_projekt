set project Tetris
set top_module vga_example
set target xc7a35tcpg236-1
set bitstream_file build/${project}.runs/impl_1/${top_module}.bit

proc usage {} {
    puts "usage: vivado -mode tcl -source [info script] -tclargs \[simulation/bitstream/program\]"
    exit 1
}

if {($argc != 1) || ([lindex $argv 0] ni {"simulation" "bitstream" "program"})} {
    usage
}



if {[lindex $argv 0] == "program"} {
    open_hw
    connect_hw_server
    current_hw_target [get_hw_targets *]
    open_hw_target
    current_hw_device [lindex [get_hw_devices] 0]
    refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]

    set_property PROBES.FILE {} [lindex [get_hw_devices] 0]
    set_property FULL_PROBES.FILE {} [lindex [get_hw_devices] 0]
    set_property PROGRAM.FILE ${bitstream_file} [lindex [get_hw_devices] 0]

    program_hw_devices [lindex [get_hw_devices] 0]
    refresh_hw_device [lindex [get_hw_devices] 0]
    
    exit
} else {
    file mkdir build
    create_project ${project} build -part ${target} -force
}

read_xdc {
    constraints/vga_example.xdc
    constraints/clk_wiz_0.xdc
}

read_verilog {
    rtl/vga_example.v
    rtl/vga_timing.v
    rtl/draw_background.v
    rtl/draw_rect.v
    rtl/clk_wiz_0.v
    rtl/clk_wiz_0_clk_wiz.v
    rtl/draw_rect_ctl.v
    rtl/debounce_u.v
    rtl/d_ff.v
    rtl/slow_clock_4Hz.v
    rtl/fallen_blocks.v
    rtl/random.v
    rtl/draw_nxt_block.v
    rtl/char_rom_16x16.v
    rtl/draw_rect_char.v
    rtl/font_rom.v
    rtl/bin_to_BCD_converter.v
    rtl/uart_rx.v
    rtl/uart_tx.v
    rtl/uart.v
    rtl/mod_m_counter.v
    rtl/data_to_transfer.v
    rtl/board_ID.v
    rtl/fifo.v
    rtl/serializer.v
rtl/mux.v
}

add_files -fileset sim_1 {
    sim/testbench.v
    sim/tiff_writer.v
}

set_property top ${top_module} [current_fileset]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

if {[lindex $argv 0] == "simulation"} {
    launch_simulation
    start_gui
} else {
    launch_runs synth_1 -jobs 8
    wait_on_run synth_1

    launch_runs impl_1 -to_step write_bitstream -jobs 8
    wait_on_run impl_1
    exit
}
