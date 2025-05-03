set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { READ_LED }]; #IO_L6N_T0_VREF_34 Sch=led[0]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { WRITE_LED }]; #IO_L6P_T0_34 Sch=led[1]
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { LOAD_LED }]; #IO_L21N_T3_DQS_AD14N_35 Sch=led[2]
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { MATMUL_LED }]; #IO_L23P_T3_35 Sch=led[3]


set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { EN_LED }]; #IO_L16P_T2_35 Sch=led4_g