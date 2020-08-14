
##########
# Clocks #
##########
create_clock -name CLK -period 10 -waveform {0 5} [get_ports CLK]

###############
# Input Delay #
###############
set_input_delay 0 -clock CLK  -add_delay  [get_ports RESET   ]
set_input_delay 0 -clock CLK  -add_delay  [get_ports TESTMOOD]
set_input_delay 0 -clock CLK  -add_delay  [get_ports LOAD    ]
set_input_delay 0 -clock CLK  -add_delay  [get_ports DATA_IN ]
set_input_delay 0 -clock CLK  -add_delay  [get_ports ADRS    ]

################
# Output Delay #
################
set_output_delay 0 -clock CLK  -add_delay  [get_ports {SEGMENTS_OUT_BAYSIS3* ANODE_OUT_BAYSIS3* SEGMENTS_OUT_PMOD_SSD* CATHODS_OUT_PMOD_SSD }]

##############################
# Pin Locations and Voltages #
##############################
set_property -dict  { PACKAGE_PIN W5       IOSTANDARD LVCMOS33}   [get_ports { CLK             }]; 
set_property -dict  { PACKAGE_PIN T17      IOSTANDARD LVCMOS33}   [get_ports { RESET           }]; 
set_property -dict  { PACKAGE_PIN W19      IOSTANDARD LVCMOS33}   [get_ports { LOAD            }]; 
set_property -dict  { PACKAGE_PIN V17      IOSTANDARD LVCMOS33}   [get_ports { TESTMOOD        }]; 
set_property -dict  { PACKAGE_PIN V16      IOSTANDARD LVCMOS33}   [get_ports { DATA_IN[0]      }]; 
set_property -dict  { PACKAGE_PIN W16      IOSTANDARD LVCMOS33}   [get_ports { DATA_IN[1]      }]; 
set_property -dict  { PACKAGE_PIN W17      IOSTANDARD LVCMOS33}   [get_ports { DATA_IN[2]      }]; 
set_property -dict  { PACKAGE_PIN W15      IOSTANDARD LVCMOS33}   [get_ports { DATA_IN[3]      }]; 
set_property -dict  { PACKAGE_PIN V15      IOSTANDARD LVCMOS33}   [get_ports { DATA_IN[4]      }]; 
set_property -dict  { PACKAGE_PIN W14      IOSTANDARD LVCMOS33}   [get_ports { DATA_IN[5]      }]; 
set_property -dict  { PACKAGE_PIN W13      IOSTANDARD LVCMOS33}   [get_ports { ADRS[0]         }]; 
set_property -dict  { PACKAGE_PIN V2       IOSTANDARD LVCMOS33}   [get_ports { ADRS[1]         }]; 

set_property -dict  { PACKAGE_PIN  U7       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[0]  }]; 
set_property -dict  { PACKAGE_PIN  V5      IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[1]  }]; 
set_property -dict  { PACKAGE_PIN  U5      IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[2]  }]; 
set_property -dict  { PACKAGE_PIN V8       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[3]  }]; 
set_property -dict  { PACKAGE_PIN  U8      IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[4]  }]; 
set_property -dict  { PACKAGE_PIN  W6     IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[5]  }]; 
set_property -dict  { PACKAGE_PIN  W7      IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_BAYSIS3[6]  }]; 

set_property -dict  { PACKAGE_PIN U2       IOSTANDARD LVCMOS33}   [get_ports { ANODE_OUT_BAYSIS3[0]  }]; 
set_property -dict  { PACKAGE_PIN U4       IOSTANDARD LVCMOS33}   [get_ports { ANODE_OUT_BAYSIS3[1]  }]; 
set_property -dict  { PACKAGE_PIN V4       IOSTANDARD LVCMOS33}   [get_ports { ANODE_OUT_BAYSIS3[2]  }]; 
set_property -dict  { PACKAGE_PIN W4       IOSTANDARD LVCMOS33}   [get_ports { ANODE_OUT_BAYSIS3[3]  }]; 

set_property -dict  { PACKAGE_PIN J2       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[0] }]; 
set_property -dict  { PACKAGE_PIN L2       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[1] }]; 
set_property -dict  { PACKAGE_PIN J1       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[2] }]; 
set_property -dict  { PACKAGE_PIN N2       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[3] }]; 
set_property -dict  { PACKAGE_PIN M2       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[4] }]; 
set_property -dict  { PACKAGE_PIN L3       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[5] }]; 
set_property -dict  { PACKAGE_PIN J3       IOSTANDARD LVCMOS33}   [get_ports { SEGMENTS_OUT_PMOD_SSD[6] }];

set_property -dict  { PACKAGE_PIN G2       IOSTANDARD LVCMOS33}   [get_ports { CATHODS_OUT_PMOD_SSD     }]; 





##########################
# Configuration Settings #
##########################
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

