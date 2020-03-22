set project_dir    "./prj"
set project_name   "cmac_usplus_0_ex"
set top_module   "cmac_usplus_0_exdes"

open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices xcu50_0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcu50_0] 0]
set_property PROBES.FILE {$prject_dir/$project_name.runs/impl_1/$top_module.ltx} [get_hw_devices xcu50_0]
set_property FULL_PROBES.FILE {$project_dir/$project_name.runs/impl_1/$top_module.ltx} [get_hw_devices xcu50_0]
set_property PROGRAM.FILE {$project_dir/$project_name.runs/impl_1/$top_module.bit} [get_hw_devices xcu50_0]
program_hw_devices [get_hw_devices xcu50_0]
refresh_hw_device [lindex [get_hw_devices xcu50_0] 0]
quit
