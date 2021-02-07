require 'tempfile'

class Vivado

  def self.BUILD; :BUILD; end
  def self.CONFIG; :CONFIG; end

  def initialize(dir: "prj", name: "top", top: nil, kind: Vivado.BUILD)
    @dir = dir
    @name = name
    @kind = kind
    @top = top != nil ? top : @name
    @device = nil
    @board = nil
    @chip = nil
    @bitfile = nil
    @parameters = []
    @sources = []
    @constraints = []
    @testbenchs = []
    @ipcores = []
    @verilog_defines = {}
    @edif_flag = false
  end

  def set_target(device)
    @device = device
  end
  
  def set_chip(chip)
    @chip = chip
  end
  
  def set_board(board)
    @board = board
  end
  
  def set_top(top)
    @top = top
  end
  
  def set_bitfile(bitfile)
    @bitfile = bitfile
  end

  def add_parameters(table)
    table.each{|k,v| @parameters[k] = v}
  end
  
  def add_sources(args)
    @sources += args
  end
  
  def add_constraints(args)
    @constraints += args
  end
  
  def add_ipcores(args)
    @ipcores += args
  end

  def add_testbenchs(args)
    @testbenchs += args
  end

  def add_verilog_define(table)
    table.each{|k,v| @verilog_defines[k] = v}
  end

  def set_export_edif(flag)
    @edif_flag = flag
  end

  def _generate_build_tcl(dst)
    @parameters.each{|k,v| dst.puts("set_param #{k} #{v}") }
    dst.puts("set project_dir #{@dir}")
    dst.puts("set project_name #{@name}")
    if @device != nil then
      dst.puts("create_project -force $project_name $project_dir -part #{@device}")
    elsif @board != nil then
      dst.puts("create_project -force $project_name $project_dir -board #{@board}")
    end
    if @board != nil then
      dst.puts("set_property board_part #{@board} [current_project]")
    end
    dst.puts("set source_files { #{@sources.join(" ")} }")
    dst.puts("add_files -norecurse $source_files")
    dst.puts("set constraint_files { #{@constraints.join(" ")} }")
    dst.puts("add_files -fileset constrs_1 -norecurse $constraint_files")
    if @testbenchs.size > 0 then
      dst.puts("set sim_files { #{@testbenchs.join(" ")} }")
      dst.puts("add_files -fileset sim_1 -norecurse $sim_files")
    end
    @ipcores.each{|i| dst.puts("import_ip -files #{i}") }
    dst.puts("set_property top #{@top} [current_fileset]")
    dst.puts("update_compile_order -fileset sources_1")
    dst.puts("update_compile_order -fileset sim_1") if @testbenchs.size > 0
    @verilog_defines.each{|k,v|
      dst.puts("set_property -name {STEPS.SYNTH_DESIGN.ARGS.MORE OPTIONS} -value {-verilog_define #{k}=#{v}} -objects [get_runs synth_1]")
    }
    dst.puts("reset_project")
    dst.puts("launch_runs synth_1 -jobs 4")
    dst.puts("wait_on_run synth_1")
    if @edif_flag then
      dst.puts("open_run synth_1 -name synth_1")
      dst.puts("write_edif #{@top}.edn")
      dst.puts("write_verilog #{@top}.v")
    else
      dst.puts(IMPL_SCRIPT)
    end
    dst.puts("quit")
  end
  
  def _generate_conf_tcl(dst)
    dst.puts("set chipname #{@chip}")
    if @bitfile != nil then
      dst.puts("set bitfile #{@bitfile}")
    else
      dst.puts("set bitfile #{@dir}/#{@name}.runs/impl_1/#{@top}.bit")
    end
    dst.puts(CONF_SCRIPT)
    dst.puts("quit")
  end

  def generate_tcl(name)
    case @kind
    when Vivado.CONFIG
      open(name, "w"){|f| _generate_conf_tcl(f) }
    else
      open(name, "w"){|f| _generate_build_tcl(f) }
    end
  end

  def run()
    tf = Tempfile.create('vivdo_project'){|f|
      generate_tcl(f.path)
      system("vivado -mode batch -source #{f.path}")
    }
  end

  IMPL_SCRIPT = <<"EOS"
launch_runs impl_1 -jobs 4
wait_on_run impl_1
open_run impl_1
report_utilization -file [file join $project_dir "project.rpt"]
report_timing -file [file join $project_dir "project.rpt"] -append
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
close_project
EOS

  CONF_SCRIPT = <<"EOS"
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target
current_hw_device [get_hw_devices ${chipname}]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices ${chipname}] 0]
set_property PROBES.FILE {} [get_hw_devices ${chipname}]
set_property FULL_PROBES.FILE {} [get_hw_devices ${chipname}]
set_property PROGRAM.FILE ${bitfile} [get_hw_devices ${chipname}]
program_hw_devices [get_hw_devices ${chipname}]
close_hw_manager
EOS

end
