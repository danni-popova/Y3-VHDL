set_property PACKAGE_PIN W5         [get_ports inputClock]
set_property IOSTANDARD LVCMOS33    [get_ports inputClock]

create_clock -add -period 10.000 -name C100Mhz_pin -waveform {0.000 5.000} [get_ports inputClock]

set_property PACKAGE_PIN V17        [get_ports {inputFast}]
set_property IOSTANDARD LVCMOS33    [get_ports {inputFast}]

set_property PACKAGE_PIN W7         [get_ports {outputSegmentCathodes[6]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[6]}]
set_property PACKAGE_PIN W6         [get_ports {outputSegmentCathodes[5]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[5]}]
set_property PACKAGE_PIN U8         [get_ports {outputSegmentCathodes[4]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[4]}]
set_property PACKAGE_PIN V8         [get_ports {outputSegmentCathodes[3]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[3]}]
set_property PACKAGE_PIN U5         [get_ports {outputSegmentCathodes[2]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[2]}]
set_property PACKAGE_PIN V5         [get_ports {outputSegmentCathodes[1]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[1]}]
set_property PACKAGE_PIN U7         [get_ports {outputSegmentCathodes[0]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentCathodes[0]}]

set_property PACKAGE_PIN U2         [get_ports {outputSegmentAnodes[0]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentAnodes[0]}]
set_property PACKAGE_PIN U4         [get_ports {outputSegmentAnodes[1]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentAnodes[1]}]
set_property PACKAGE_PIN V4         [get_ports {outputSegmentAnodes[2]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentAnodes[2]}]
set_property PACKAGE_PIN W4         [get_ports {outputSegmentAnodes[3]}]
set_property IOSTANDARD LVCMOS33    [get_ports {outputSegmentAnodes[3]}]


set_property PACKAGE_PIN U18        [get_ports {inputReset}]
set_property IOSTANDARD LVCMOS33    [get_ports {inputReset}]


set_property BITSTREAM.GENERAL.COMPRESS TRUE    [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4    [current_design]
set_property CONFIG_MODE SPIx4                  [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33    [current_design]

set_property CONFIG_VOLTAGE 3.3                 [current_design]
set_property CFGBVS VCCO                        [current_design]