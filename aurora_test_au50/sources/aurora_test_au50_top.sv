`default_nettype none
`timescale 1ns/100ps

module aurora_test_au50_top(
   input wire  [0:0] gt_rxp_in,
   input wire  [0:0] gt_rxn_in,
   output wire [0:0] gt_txp_out,
   output wire [0:0] gt_txn_out,

   output wire 	QSFP28_0_ACTIVITY_LED,
   output wire 	QSFP28_0_STATUS_LEDG,
   output wire 	QSFP28_0_STATUS_LEDY,
  
   input wire		gt_refclk_p,
   input wire		gt_refclk_n,

   input wire 		SYSCLK3_N,
   input wire 		SYSCLK3_P,

   output wire CATTRIP_PKGPIN
);

    assign CATTRIP_PKGPIN = 1'b0;

    wire CLK100;
    wire LOCKED100;

    wire [0:63] s_axi_tx_tdata;
    wire        s_axi_tx_tvalid;
    wire        s_axi_tx_tready;
    wire [0:63] m_axi_rx_tdata;
    wire        m_axi_rx_tvalid;

    wire gt_rxcdrovrden_in = 0;
    wire power_down = 0;
    wire [2:0] loopback = 0;

    wire [31:0] s_axi_awaddr = 0;
    wire        s_axi_awvalid = 0;
    wire        s_axi_awready = 0;
    wire [31:0] s_axi_wdata = 0;
    wire [3:0]  s_axi_wstrb = 0;
    wire        s_axi_wvalid = 0;
    wire        s_axi_wready;
    wire        s_axi_bvalid;
    wire [1:0]  s_axi_bresp;
    wire        s_axi_bready = 1;
    wire [31:0] s_axi_araddr = 0;
    wire        s_axi_arvalid = 0;
    wire        s_axi_arready;
    wire [31:0] s_axi_rdata;
    wire        s_axi_rvalid;
    wire [1:0]  s_axi_rresp;
    wire        s_axi_rready = 1;

    wire gt_refclk1_out;
    wire hard_err;
    wire soft_err;
    wire channel_up;
    wire [0:0] lane_up;
    wire user_clk_out;
    wire mmcm_not_locked_out;
    wire sync_clk_out;
    wire gt_pll_lock;
    wire link_reset_out;
    wire [0:0] gt_powergood;
    wire gt_qpllclk_quad1_out;
    wire gt_qpllrefclk_quad1_out;
    wire gt_qplllock_quad1_out;
    wire gt_qpllrefclklost_quad1_out;
    wire sys_reset_out;
    wire gt_reset_out;
    wire tx_out_clk;

    wire reset_pb;
    wire pma_init;
    wire init_clk = CLK100;
    
    reg [23:0] counter;
    always @(posedge CLK100)
      counter <= counter + 1;

    assign QSFP28_0_ACTIVITY_LED = lane_up;
    assign QSFP28_0_STATUS_LEDG = gt_powergood;
    assign QSFP28_0_STATUS_LEDY = counter[23];
    
    clk_wiz_0 clk_wiz_0_i(
			  .clk_out1(CLK100),
			  .reset(0),
			  .locked(LOCKED100),
			  .clk_in1_p(SYSCLK3_P),
			  .clk_in1_n(SYSCLK3_N));

    ku_aurora_boot ku_aurora_boot_i(
				    .CLK100(CLK100),
				    .DCM_LOCKED(LOCKED100),
				    .PMA_INIT(pma_init),
				    .RESET_PB(reset_pb)
				    );

    aurora_64b66b_0 aurora_64b66b_0_i(
				      .s_axi_tx_tdata(s_axi_tx_tdata),   // input
				      .s_axi_tx_tvalid(s_axi_tx_tvalid), // input
				      .s_axi_tx_tready(s_axi_tx_tready), // output
				      .m_axi_rx_tdata(m_axi_rx_tdata),   // output
				      .m_axi_rx_tvalid(m_axi_rx_tvalid), // output
				      .rxp(gt_rxp_in[0]),  // input
				      .rxn(gt_rxn_in[0]),  // input
				      .txp(gt_txp_out[0]), // output
				      .txn(gt_txn_out[0]), // output
				      .gt_refclk1_p(gt_refclk_p), // input
				      .gt_refclk1_n(gt_refclk_n), // input
				      .gt_refclk1_out(gt_refclk1_out), // output
				      .hard_err(hard_err),     // output
				      .soft_err(soft_err),     // output
				      .channel_up(channel_up), // output
				      .lane_up(lane_up),       // output
				      .user_clk_out(user_clk_out), // output
				      .mmcm_not_locked_out(mmcm_not_locked_out), // output
				      .sync_clk_out(sync_clk_out), // output
				      .reset_pb(reset_pb), // input
				      .gt_rxcdrovrden_in(gt_rxcdrovrden_in), // input
				      .power_down(power_down),  // input
				      .loopback(loopback), // input
				      .pma_init(pma_init), // input
				      .gt_pll_lock(gt_pll_lock), // output
				      .s_axi_awaddr(s_axi_awaddr),   // input
				      .s_axi_awvalid(s_axi_awvalid), // input
				      .s_axi_awready(s_axi_awready), // input
				      .s_axi_wdata(s_axi_wdata),     // input
				      .s_axi_wstrb(s_axi_wstrb),     // input
				      .s_axi_wvalid(s_axi_wvalid),   // input
				      .s_axi_wready(s_axi_wready),   // output
				      .s_axi_bvalid(s_axi_bvalid),   // output
				      .s_axi_bresp(s_axi_bresp),     // output
				      .s_axi_bready(s_axi_bready),   // input
				      .s_axi_araddr(s_axi_araddr),   // input
				      .s_axi_arvalid(s_axi_arvalid), // input
				      .s_axi_arready(s_axi_arready), // output
				      .s_axi_rdata(s_axi_rdata),     // output
				      .s_axi_rvalid(s_axi_rvalid),   // output
				      .s_axi_rresp(s_axi_rresp),     // output
				      .s_axi_rready(s_axi_rready),   // input
				      .init_clk(CLK100), // input
				      .link_reset_out(link_reset_out), // output
				      .gt_powergood(gt_powergood),     // output
				      .gt_qpllclk_quad1_out(gt_qpllclk_quad1_out),               // output
				      .gt_qpllrefclk_quad1_out(gt_qpllrefclk_quad1_out),         // output
				      .gt_qplllock_quad1_out(gt_qplllock_quad1_out),             // output
				      .gt_qpllrefclklost_quad1_out(gt_qpllrefclklost_quad1_out), // output
				      .sys_reset_out(sys_reset_out), // output
				      .gt_reset_out(gt_reset_out),   // output
				      .tx_out_clk(tx_out_clk)        // output
				      );

    wire tx_fifo_empty, tx_fifo_full, tx_fifo_valid, tx_fifo_wr_busy;

    reg [63:0] tx_out_counter = 0;
    reg tx_out_counter_wr = 0;

    fifo_generator_0 fifo_generator_0_i(
					.rst(sys_reset_out),    // input
					.wr_clk(user_clk_out), // input
					.rd_clk(user_clk_out), // input
					.din(tx_out_counter), // input
					.wr_en(tx_out_counter_wr), // input
					.rd_en(s_axi_tx_tready && tx_fifo_valid), // input
					.dout(s_axi_tx_tdata), // output
					.full(), // output
					.empty(tx_fifo_empty), // output
					.valid(tx_fifo_valid), // output
					.prog_full(tx_fifo_full), // output
					.wr_rst_busy(tx_fifo_wr_busy), // output
					.rd_rst_busy()  // output
					);
    assign s_axi_tx_tvalid = tx_fifo_valid;

    always @(posedge user_clk_out) begin
	if(sys_reset_out == 1 || tx_fifo_wr_busy == 1) begin
	    tx_out_counter <= 0;
	    tx_out_counter_wr <= 0;
	end else begin
	    if(tx_fifo_full == 0) begin
		tx_out_counter <= tx_out_counter + 1;
		tx_out_counter_wr <= 1;
	    end else begin
		tx_out_counter_wr <= 0;
	    end
	end
    end
					
    ila_0 ila_0_i(
		  .clk(user_clk_out),
		  .probe0({reset_pb, pma_init}),
		  .probe1({hard_err,
			   soft_err,
			   channel_up,
			   lane_up,
			   mmcm_not_locked_out,
			   gt_pll_lock,
			   link_reset_out,
			   gt_powergood,
			   gt_qplllock_quad1_out,
			   gt_qpllrefclklost_quad1_out,
			   sys_reset_out,
			   gt_reset_out}),
		  .probe2({m_axi_rx_tdata, m_axi_rx_tvalid}),
		  .probe3({tx_fifo_empty, tx_fifo_full, tx_fifo_wr_busy, tx_fifo_valid, tx_out_counter_wr, tx_out_counter}),
		  .probe4({s_axi_tx_tready, s_axi_tx_tvalid, s_axi_tx_tdata})
		  );

endmodule // aurora_test_au50_top

// cf. https://www.acri.c.titech.ac.jp/wordpress/archives/8624
module ku_aurora_boot
  ( input wire CLK100,
    input wire DCM_LOCKED,
    output reg PMA_INIT, RESET_PB
    );

   reg [7:0]        PMA_INIT_CNT = 0;

   initial PMA_INIT <= 1;
   initial RESET_PB <= 1;

   always @ (posedge CLK100) begin
      if (~DCM_LOCKED) PMA_INIT_CNT <= 0;
      else PMA_INIT_CNT <= PMA_INIT_CNT + ((~&PMA_INIT_CNT) ? 1 : 0);

      case (PMA_INIT_CNT)
        100: PMA_INIT <= 0;
        200: RESET_PB <= 0;
      endcase
   end
endmodule
