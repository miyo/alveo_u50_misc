set_property PACKAGE_PIN J45 [get_ports {gt_rxp_in[0]}]
set_property PACKAGE_PIN J46 [get_ports {gt_rxn_in[0]}]
set_property PACKAGE_PIN D42 [get_ports {gt_txp_out[0]}]
set_property PACKAGE_PIN D43 [get_ports {gt_txn_out[0]}]

##set_property PACKAGE_PIN G45 [get_ports {gt_rxp_in[1]}]
##set_property PACKAGE_PIN G46 [get_ports {gt_rxn_in[1]}]
##set_property PACKAGE_PIN C40 [get_ports {gt_txp_out[1]}]
##set_property PACKAGE_PIN C41 [get_ports {gt_txn_out[1]}]

##set_property PACKAGE_PIN F43 [get_ports {gt_rxp_in[2]}]
##set_property PACKAGE_PIN F44 [get_ports {gt_rxn_in[2]}]
##set_property PACKAGE_PIN B42 [get_ports {gt_txp_out[2]}]
##set_property PACKAGE_PIN B43 [get_ports {gt_txn_out[2]}]

##set_property PACKAGE_PIN E45 [get_ports {gt_rxp_in[3]}]
##set_property PACKAGE_PIN E46 [get_ports {gt_rxn_in[3]}]
##set_property PACKAGE_PIN A40 [get_ports {gt_txp_out[3]}]
##set_property PACKAGE_PIN A41 [get_ports {gt_txn_out[3]}]

set_property PACKAGE_PIN E18 [get_ports QSFP28_0_ACTIVITY_LED]
set_property IOSTANDARD LVCMOS18 [get_ports QSFP28_0_ACTIVITY_LED]
set_property PACKAGE_PIN E16 [get_ports QSFP28_0_STATUS_LEDG]
set_property IOSTANDARD LVCMOS18 [get_ports QSFP28_0_STATUS_LEDG]
set_property PACKAGE_PIN F17 [get_ports QSFP28_0_STATUS_LEDY]
set_property IOSTANDARD LVCMOS18 [get_ports QSFP28_0_STATUS_LEDY]

set_property PACKAGE_PIN N37 [get_ports gt_refclk_n]
set_property PACKAGE_PIN N36 [get_ports gt_refclk_p]
# create_clock -period 6.206  -name gtrefclk0 [get_ports "gt_refclk_p"]

set_property IOSTANDARD LVDS [get_ports SYSCLK3_N]
set_property PACKAGE_PIN BB18 [get_ports SYSCLK3_P]
set_property PACKAGE_PIN BC18 [get_ports SYSCLK3_N]
set_property IOSTANDARD LVDS [get_ports SYSCLK3_P]
set_property DQS_BIAS TRUE [get_ports SYSCLK3_P]
# create_clock -period 10.000 -name sysclk3 [get_ports "SYSCLK3_P"]

set_property PACKAGE_PIN J18 [get_ports CATTRIP_PKGPIN]
set_property IOSTANDARD LVCMOS18 [get_ports CATTRIP_PKGPIN]
