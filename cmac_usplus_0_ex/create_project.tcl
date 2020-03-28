set project_dir    "./prj"
set project_name   "cmac_usplus_0_ex"
set top_module     "cmac_usplus_0_exdes"
set project_target "xcu50-fsvh2104-2-e"
set project_board "xilinx.com:au50:part0:1.0"

set source_files { \
			./sources/cmac_usplus_0_axi4_lite_user_if.v \
			./sources/cmac_usplus_0_exdes.v \
			./sources/cmac_usplus_0_lbus_pkt_gen.v \
			./sources/cmac_usplus_0_lbus_pkt_mon.v \
			./sources/cmac_usplus_0_pkt_gen_mon.v \
			./sources/resetgen.v \
			./sources/cmac_usplus_emitter.sv \
			./sources/ether_rx.sv \
			./sources/ether_tx.sv \
		   }

set constraint_files { \
			./sources/cmac_usplus_0_example_top.xdc \
		       }

set simulation_files { \
			./sources/cmac_usplus_0_exdes_tb.v \
		       }

create_project -force $project_name $project_dir -part $project_target
set_property BOARD_PART $project_board [current_project] 
add_files -norecurse $source_files
add_files -fileset constrs_1 -norecurse $constraint_files

update_ip_catalog

import_ip -files ./ip/cmac_usplus_0.xci
import_ip -files ./ip/fifo_512_256_ft.xci
import_ip -files ./ip/ila_0.xci
import_ip -files ./ip/ila_1.xci
import_ip -files ./ip/vio_0.xci
import_ip -files ./ip/vio_1.xci

set_property top $top_module [current_fileset]
set_property target_constrs_file ./sources/cmac_usplus_0_example_top.xdc [current_fileset -constrset]

update_compile_order -fileset sources_1

add_files -fileset sim_1 -norecurse $simulation_files

update_compile_order -fileset sim_1

reset_project

launch_runs synth_1 -jobs 4
wait_on_run synth_1
 
launch_runs impl_1 -jobs 4
wait_on_run impl_1
open_run impl_1
report_utilization -file [file join $project_dir "project.rpt"]
report_timing -file [file join $project_dir "project.rpt"] -append
 
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
close_project

quit
