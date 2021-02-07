require './vivado_util.rb'

VIVADO_VERSION=2020.2

def main()
  dir="prj"
  name="aurora_test_au50"
  
  vivado = Vivado.new(dir: dir, name: name, top: "aurora_test_au50_top")
  #vivado.add_parameters({"general.maxThreads" => 1})
  
  vivado.set_target("xcu50-fsvh2104-2-e")
  vivado.set_board("xilinx.com:au50:part0:1.0")

  vivado.add_sources(["sources/aurora_test_au50_top.sv"])
  vivado.add_constraints(["sources/aurora_test_au50_top.xdc"])
  vivado.add_testbenchs([])
  vivado.add_ipcores(["ipcores/clk_wiz_0.xci",
                      "ipcores/ila_0.xci",
                      "ipcores/fifo_generator_0.xci",
                      "ipcores/aurora_64b66b_0.xci"])
  
  #vivado.add_verilog_define({"BOARD_ID" => board_id})
  
  vivado.generate_tcl("create_prj.tcl")
  #vivado.run()
  
  #config = Vivado.new(dir=dir, name=name, top="top", kind=Vivado.CONFIG)
  #config.set_chip("xc7a35t_0")
  #config.generate_tcl("config_board_#{key}.tcl")
  #config.run()
end

main()


