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
set_param synth.incrementalSynthesisCache {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/.Xil/Vivado-11720-Tom-PC/incrSyn}
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.cache/wt} [current_project]
set_property parent.project_path {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.xpr} [current_project]
set_property XPM_LIBRARIES XPM_CDC [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {d:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/BinaryDecimalConverter.vhd}
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/ClockDivider.vhd}
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/Counter.vhd}
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/DisplayDriver.vhd}
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/MUX4to1.vhd}
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/SegmentSelector.vhd}
  {D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/new/MasterComponent.vhd}
}
read_ip -quiet {{D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/ip/ClockManager/ClockManager.xci}}
set_property used_in_implementation false [get_files -all {{d:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/ip/ClockManager/ClockManager_board.xdc}}]
set_property used_in_implementation false [get_files -all {{d:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/ip/ClockManager/ClockManager.xdc}}]
set_property used_in_implementation false [get_files -all {{d:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/sources_1/ip/ClockManager/ClockManager_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/constrs_1/new/IO.xdc}}
set_property used_in_implementation false [get_files {{D:/University/ENG631 - VHDL and FPGA/VHDL Source/ENG631_CW1_T16/ENG631_CW1_T16.srcs/constrs_1/new/IO.xdc}}]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top MasterComponent -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef MasterComponent.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file MasterComponent_utilization_synth.rpt -pb MasterComponent_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]