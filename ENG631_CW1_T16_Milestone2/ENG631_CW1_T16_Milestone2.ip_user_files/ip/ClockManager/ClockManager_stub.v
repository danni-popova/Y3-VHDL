// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Tue Feb  5 11:01:39 2019
// Host        : W0DA01E54C1964C running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               N:/GitHub/Y3-VHDL/ENG631_CW1_T16_Milestone2/ENG631_CW1_T16_Milestone2.srcs/sources_1/ip/ClockManager/ClockManager_stub.v
// Design      : ClockManager
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ClockManager(out100mhz, reset, locked, in100mhz)
/* synthesis syn_black_box black_box_pad_pin="out100mhz,reset,locked,in100mhz" */;
  output out100mhz;
  input reset;
  output locked;
  input in100mhz;
endmodule
