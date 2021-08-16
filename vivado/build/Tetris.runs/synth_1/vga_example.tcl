# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/czlow/OneDrive/Pulpit/vivado/build/Tetris.cache/wt [current_project]
set_property parent.project_path C:/Users/czlow/OneDrive/Pulpit/vivado/build/Tetris.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/czlow/OneDrive/Pulpit/vivado/build/Tetris.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/clk_wiz_0.v
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/clk_wiz_0_clk_wiz.v
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/draw_background.v
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/draw_rect.v
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/draw_rect_ctl.v
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/vga_timing.v
  C:/Users/czlow/OneDrive/Pulpit/vivado/rtl/vga_example.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/czlow/OneDrive/Pulpit/vivado/constraints/vga_example.xdc
set_property used_in_implementation false [get_files C:/Users/czlow/OneDrive/Pulpit/vivado/constraints/vga_example.xdc]

read_xdc C:/Users/czlow/OneDrive/Pulpit/vivado/constraints/clk_wiz_0.xdc
set_property used_in_implementation false [get_files C:/Users/czlow/OneDrive/Pulpit/vivado/constraints/clk_wiz_0.xdc]


synth_design -top vga_example -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef vga_example.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file vga_example_utilization_synth.rpt -pb vga_example_utilization_synth.pb"
