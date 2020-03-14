open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices xcu50_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcu50_0] 0]
set_property PROBES.FILE {./cmac_usplus_0_ex/cmac_usplus_0_ex.runs/impl_1/cmac_usplus_0_exdes.ltx} [get_hw_devices xcu50_0]
set_property FULL_PROBES.FILE {./cmac_usplus_0_ex/cmac_usplus_0_ex.runs/impl_1/cmac_usplus_0_exdes.ltx} [get_hw_devices xcu50_0]
set_property PROGRAM.FILE {./cmac_usplus_0_ex/cmac_usplus_0_ex.runs/impl_1/cmac_usplus_0_exdes.bit} [get_hw_devices xcu50_0]
program_hw_devices [get_hw_devices xcu50_0]
refresh_hw_device [lindex [get_hw_devices xcu50_0] 0]
#display_hw_ila_data [ get_hw_ila_data hw_ila_data_1 -of_objects [get_hw_ilas -of_objects [get_hw_devices xcu50_0] -filter {CELL_NAME=~"ila_0_i"}]]
#display_hw_ila_data [ get_hw_ila_data hw_ila_data_2 -of_objects [get_hw_ilas -of_objects [get_hw_devices xcu50_0] -filter {CELL_NAME=~"ila_1_i"}]]
quit
