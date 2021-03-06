////------------------------------------------------------------------------------
////  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
////
////  This file contains confidential and proprietary information
////  of Xilinx, Inc. and is protected under U.S. and
////  international copyright and other intellectual property
////  laws.
////
////  DISCLAIMER
////  This disclaimer is not a license and does not grant any
////  rights to the materials distributed herewith. Except as
////  otherwise provided in a valid license issued to you by
////  Xilinx, and to the maximum extent permitted by applicable
////  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
////  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
////  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
////  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
////  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
////  (2) Xilinx shall not be liable (whether in contract or tort,
////  including negligence, or under any other theory of
////  liability) for any loss or damage of any kind or nature
////  related to, arising under or in connection with these
////  materials, including for any direct, or any indirect,
////  special, incidental, or consequential loss or damage
////  (including loss of data, profits, goodwill, or any type of
////  loss or damage suffered as a result of any action brought
////  by a third party) even if such damage or loss was
////  reasonably foreseeable or Xilinx had been advised of the
////  possibility of the same.
////
////  CRITICAL APPLICATIONS
////  Xilinx products are not designed or intended to be fail-
////  safe, or for use in any application requiring fail-safe
////  performance, such as life-support or safety devices or
////  systems, Class III medical devices, nuclear facilities,
////  applications related to the deployment of airbags, or any
////  other applications that could lead to death, personal
////  injury, or severe property or environmental damage
////  (individually and collectively, "Critical
////  Applications"). Customer assumes the sole risk and
////  liability of any use of Xilinx products in Critical
////  Applications, subject only to applicable laws and
////  regulations governing limitations on product liability.
////
////  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
////  PART OF THIS FILE AT ALL TIMES.
////------------------------------------------------------------------------------

`timescale 1ps/1ps
(* DowngradeIPIdentifiedWarnings="yes" *)
////module lbus_if
module cmac_usplus_0_pkt_gen_mon
   #(
    parameter PKT_NUM      = 1000,    //// 1 to 65535 (Number of packets)
    parameter PKT_SIZE     = 522      //// Min pkt size 64 Bytes; Max pkt size 9600 Bytes
   )
   (
    input  wire                gen_mon_clk,
    input  wire                usr_tx_reset,
    input  wire                usr_rx_reset,
    input  wire                sys_reset,
    input  wire                send_continuous_pkts,
    //// User Interface signals
    input  wire                lbus_tx_rx_restart_in,
    input  wire                s_axi_aclk,
    input  wire                s_axi_sreset,
    input  wire                pm_tick,
    output wire [31:0]         s_axi_awaddr,
    output wire                s_axi_awvalid,
    
    input  wire                s_axi_awready,
    
    output wire [31:0]         s_axi_wdata,
    output wire [3:0]          s_axi_wstrb,
    output wire                s_axi_wvalid,
    input  wire                s_axi_wready,
    
    input  wire [1:0]          s_axi_bresp,
    input  wire                s_axi_bvalid,
    output wire                s_axi_bready,
    
    output wire [31:0]         s_axi_araddr,
    output wire                s_axi_arvalid,
    input  wire                s_axi_arready,
    input  wire [31:0]         s_axi_rdata,
    input  wire [1:0]          s_axi_rresp,
    input  wire                s_axi_rvalid,
    output wire                s_axi_rready,
    //// LBUS Tx Signals
    input  wire                tx_rdyout,
    output wire [128-1:0]      tx_datain0,
    output wire                tx_enain0,
    output wire                tx_sopin0,
    output wire                tx_eopin0,
    output wire                tx_errin0,
    output wire [4-1:0]        tx_mtyin0,
    output wire [128-1:0]      tx_datain1,
    output wire                tx_enain1,
    output wire                tx_sopin1,
    output wire                tx_eopin1,
    output wire                tx_errin1,
    output wire [4-1:0]        tx_mtyin1,
    output wire [128-1:0]      tx_datain2,
    output wire                tx_enain2,
    output wire                tx_sopin2,
    output wire                tx_eopin2,
    output wire                tx_errin2,
    output wire [4-1:0]        tx_mtyin2,
    output wire [128-1:0]      tx_datain3,
    output wire                tx_enain3,
    output wire                tx_sopin3,
    output wire                tx_eopin3,
    output wire                tx_errin3,
    output wire [4-1:0]        tx_mtyin3,
    input  wire                tx_ovfout,
    input  wire                tx_unfout,

    //// LBUS Rx Signals
    input  wire [128-1:0]      rx_dataout0,
    input  wire                rx_enaout0,
    input  wire                rx_sopout0,
    input  wire                rx_eopout0,
    input  wire                rx_errout0,
    input  wire [4-1:0]        rx_mtyout0,
    input  wire [128-1:0]      rx_dataout1,
    input  wire                rx_enaout1,
    input  wire                rx_sopout1,
    input  wire                rx_eopout1,
    input  wire                rx_errout1,
    input  wire [4-1:0]        rx_mtyout1,
    input  wire [128-1:0]      rx_dataout2,
    input  wire                rx_enaout2,
    input  wire                rx_sopout2,
    input  wire                rx_eopout2,
    input  wire                rx_errout2,
    input  wire [4-1:0]        rx_mtyout2,
    input  wire [128-1:0]      rx_dataout3,
    input  wire                rx_enaout3,
    input  wire                rx_sopout3,
    input  wire                rx_eopout3,
    input  wire                rx_errout3,
    input  wire [3:0]          rx_mtyout3,
    output wire [55:0]         tx_preamblein,
    input  wire [55:0]         rx_preambleout,
    input  wire [8:0]          stat_tx_pause_valid,
    input  wire                stat_tx_pause,
    input  wire                stat_tx_user_pause,
    output wire [8:0]          ctl_tx_pause_req,
    output wire                ctl_tx_resend_pause,
    input  wire                stat_rx_pause,
    input  wire [15:0]         stat_rx_pause_quanta0,
    input  wire [15:0]         stat_rx_pause_quanta1,
    input  wire [15:0]         stat_rx_pause_quanta2,
    input  wire [15:0]         stat_rx_pause_quanta3,
    input  wire [15:0]         stat_rx_pause_quanta4,
    input  wire [15:0]         stat_rx_pause_quanta5,
    input  wire [15:0]         stat_rx_pause_quanta6,
    input  wire [15:0]         stat_rx_pause_quanta7,
    input  wire [15:0]         stat_rx_pause_quanta8,
    input  wire [8:0]          stat_rx_pause_req,
    input  wire [8:0]          stat_rx_pause_valid,
    input  wire                stat_rx_user_pause,

    input  wire                stat_rx_aligned,
    input  wire                stat_rx_aligned_err,
    input  wire [2:0]          stat_rx_bad_code,
    input  wire [2:0]          stat_rx_bad_fcs,
    input  wire                stat_rx_bad_preamble,
    input  wire                stat_rx_bad_sfd,
    input  wire                stat_rx_bip_err_0,
    input  wire                stat_rx_bip_err_1,
    input  wire                stat_rx_bip_err_10,
    input  wire                stat_rx_bip_err_11,
    input  wire                stat_rx_bip_err_12,
    input  wire                stat_rx_bip_err_13,
    input  wire                stat_rx_bip_err_14,
    input  wire                stat_rx_bip_err_15,
    input  wire                stat_rx_bip_err_16,
    input  wire                stat_rx_bip_err_17,
    input  wire                stat_rx_bip_err_18,
    input  wire                stat_rx_bip_err_19,
    input  wire                stat_rx_bip_err_2,
    input  wire                stat_rx_bip_err_3,
    input  wire                stat_rx_bip_err_4,
    input  wire                stat_rx_bip_err_5,
    input  wire                stat_rx_bip_err_6,
    input  wire                stat_rx_bip_err_7,
    input  wire                stat_rx_bip_err_8,
    input  wire                stat_rx_bip_err_9,
    input  wire [19:0]         stat_rx_block_lock,
    input  wire                stat_rx_broadcast,
    input  wire [2:0]          stat_rx_fragment,
    input  wire [1:0]          stat_rx_framing_err_0,
    input  wire [1:0]          stat_rx_framing_err_1,
    input  wire [1:0]          stat_rx_framing_err_10,
    input  wire [1:0]          stat_rx_framing_err_11,
    input  wire [1:0]          stat_rx_framing_err_12,
    input  wire [1:0]          stat_rx_framing_err_13,
    input  wire [1:0]          stat_rx_framing_err_14,
    input  wire [1:0]          stat_rx_framing_err_15,
    input  wire [1:0]          stat_rx_framing_err_16,
    input  wire [1:0]          stat_rx_framing_err_17,
    input  wire [1:0]          stat_rx_framing_err_18,
    input  wire [1:0]          stat_rx_framing_err_19,
    input  wire [1:0]          stat_rx_framing_err_2,
    input  wire [1:0]          stat_rx_framing_err_3,
    input  wire [1:0]          stat_rx_framing_err_4,
    input  wire [1:0]          stat_rx_framing_err_5,
    input  wire [1:0]          stat_rx_framing_err_6,
    input  wire [1:0]          stat_rx_framing_err_7,
    input  wire [1:0]          stat_rx_framing_err_8,
    input  wire [1:0]          stat_rx_framing_err_9,
    input  wire                stat_rx_framing_err_valid_0,
    input  wire                stat_rx_framing_err_valid_1,
    input  wire                stat_rx_framing_err_valid_10,
    input  wire                stat_rx_framing_err_valid_11,
    input  wire                stat_rx_framing_err_valid_12,
    input  wire                stat_rx_framing_err_valid_13,
    input  wire                stat_rx_framing_err_valid_14,
    input  wire                stat_rx_framing_err_valid_15,
    input  wire                stat_rx_framing_err_valid_16,
    input  wire                stat_rx_framing_err_valid_17,
    input  wire                stat_rx_framing_err_valid_18,
    input  wire                stat_rx_framing_err_valid_19,
    input  wire                stat_rx_framing_err_valid_2,
    input  wire                stat_rx_framing_err_valid_3,
    input  wire                stat_rx_framing_err_valid_4,
    input  wire                stat_rx_framing_err_valid_5,
    input  wire                stat_rx_framing_err_valid_6,
    input  wire                stat_rx_framing_err_valid_7,
    input  wire                stat_rx_framing_err_valid_8,
    input  wire                stat_rx_framing_err_valid_9,
    input  wire                stat_rx_got_signal_os,
    input  wire                stat_rx_hi_ber,
    input  wire                stat_rx_inrangeerr,
    input  wire                stat_rx_internal_local_fault,
    input  wire                stat_rx_jabber,
    input  wire                stat_rx_local_fault,
    input  wire [19:0]         stat_rx_mf_err,
    input  wire [19:0]         stat_rx_mf_len_err,
    input  wire [19:0]         stat_rx_mf_repeat_err,
    input  wire                stat_rx_misaligned,
    input  wire                stat_rx_multicast,
    input  wire                stat_rx_oversize,
    input  wire                stat_rx_packet_1024_1518_bytes,
    input  wire                stat_rx_packet_128_255_bytes,
    input  wire                stat_rx_packet_1519_1522_bytes,
    input  wire                stat_rx_packet_1523_1548_bytes,
    input  wire                stat_rx_packet_1549_2047_bytes,
    input  wire                stat_rx_packet_2048_4095_bytes,
    input  wire                stat_rx_packet_256_511_bytes,
    input  wire                stat_rx_packet_4096_8191_bytes,
    input  wire                stat_rx_packet_512_1023_bytes,
    input  wire                stat_rx_packet_64_bytes,
    input  wire                stat_rx_packet_65_127_bytes,
    input  wire                stat_rx_packet_8192_9215_bytes,
    input  wire                stat_rx_packet_bad_fcs,
    input  wire                stat_rx_packet_large,
    input  wire [2:0]          stat_rx_packet_small,
    input  wire                stat_rx_received_local_fault,
    input  wire                stat_rx_remote_fault,
    input  wire                stat_rx_status,
    input  wire [2:0]          stat_rx_stomped_fcs,
    input  wire [19:0]         stat_rx_synced,
    input  wire [19:0]         stat_rx_synced_err,
    input  wire [2:0]          stat_rx_test_pattern_mismatch,
    input  wire                stat_rx_toolong,
    input  wire [6:0]          stat_rx_total_bytes,
    input  wire [13:0]         stat_rx_total_good_bytes,
    input  wire                stat_rx_total_good_packets,
    input  wire [2:0]          stat_rx_total_packets,
    input  wire                stat_rx_truncated,
    input  wire [2:0]          stat_rx_undersize,
    input  wire                stat_rx_unicast,
    input  wire                stat_rx_vlan,
    input  wire [19:0]         stat_rx_pcsl_demuxed,
    input  wire [4:0]          stat_rx_pcsl_number_0,
    input  wire [4:0]          stat_rx_pcsl_number_1,
    input  wire [4:0]          stat_rx_pcsl_number_10,
    input  wire [4:0]          stat_rx_pcsl_number_11,
    input  wire [4:0]          stat_rx_pcsl_number_12,
    input  wire [4:0]          stat_rx_pcsl_number_13,
    input  wire [4:0]          stat_rx_pcsl_number_14,
    input  wire [4:0]          stat_rx_pcsl_number_15,
    input  wire [4:0]          stat_rx_pcsl_number_16,
    input  wire [4:0]          stat_rx_pcsl_number_17,
    input  wire [4:0]          stat_rx_pcsl_number_18,
    input  wire [4:0]          stat_rx_pcsl_number_19,
    input  wire [4:0]          stat_rx_pcsl_number_2,
    input  wire [4:0]          stat_rx_pcsl_number_3,
    input  wire [4:0]          stat_rx_pcsl_number_4,
    input  wire [4:0]          stat_rx_pcsl_number_5,
    input  wire [4:0]          stat_rx_pcsl_number_6,
    input  wire [4:0]          stat_rx_pcsl_number_7,
    input  wire [4:0]          stat_rx_pcsl_number_8,
    input  wire [4:0]          stat_rx_pcsl_number_9,
    input  wire                stat_tx_bad_fcs,
    input  wire                stat_tx_broadcast,
    input  wire                stat_tx_frame_error,
    input  wire                stat_tx_local_fault,
    input  wire                stat_tx_multicast,
    input  wire                stat_tx_packet_1024_1518_bytes,
    input  wire                stat_tx_packet_128_255_bytes,
    input  wire                stat_tx_packet_1519_1522_bytes,
    input  wire                stat_tx_packet_1523_1548_bytes,
    input  wire                stat_tx_packet_1549_2047_bytes,
    input  wire                stat_tx_packet_2048_4095_bytes,
    input  wire                stat_tx_packet_256_511_bytes,
    input  wire                stat_tx_packet_4096_8191_bytes,
    input  wire                stat_tx_packet_512_1023_bytes,
    input  wire                stat_tx_packet_64_bytes,
    input  wire                stat_tx_packet_65_127_bytes,
    input  wire                stat_tx_packet_8192_9215_bytes,
    input  wire                stat_tx_packet_large,
    input  wire                stat_tx_packet_small,
    input  wire [5:0]          stat_tx_total_bytes,
    input  wire [13:0]         stat_tx_total_good_bytes,
    input  wire                stat_tx_total_good_packets,
    input  wire                stat_tx_total_packets,
    input  wire                stat_tx_unicast,
    input  wire                stat_tx_vlan,

    output wire                ctl_tx_send_idle,
    output wire                ctl_tx_send_rfi,
    output wire                ctl_tx_send_lfi,
    output wire                tx_reset,
    output wire                rx_reset,
    input  wire [3 :0]         gt_rxrecclkout,
    output wire                tx_done_led,
    output wire                tx_busy_led,
    output wire                stat_reg_compare_out,

    output wire                rx_gt_locked_led,
    output wire                rx_aligned_led,
    output wire                rx_done_led,
    output wire                rx_data_fail_led,
    output wire                rx_busy_led,

    output wire 	 payload_rd,
    input wire [511:0] 	 payload,
    input wire [15:0] 	 lbus_number_pkt_proc,
    input wire [13:0] 	 lbus_pkt_size_proc,
    output wire [7:0] 	 debug
    );

    wire                sanity_init_done;
    wire                pause_init_done;
    wire                rx_busy;


cmac_usplus_0_lbus_pkt_gen
#(
.PKT_NUM                               (PKT_NUM),
.PKT_SIZE                              (PKT_SIZE)
) i_cmac_usplus_0_lbus_pkt_gen  
(
.clk                                   (gen_mon_clk),
.reset                                 (usr_tx_reset),
.sys_reset                             (sys_reset),
.send_continuous_pkts                  (send_continuous_pkts),
.stat_rx_aligned                       (stat_rx_aligned),
.lbus_tx_rx_restart_in                 (lbus_tx_rx_restart_in),
.sanity_init_done                      (sanity_init_done),
.pause_init_done                       (pause_init_done),
.ctl_tx_send_idle                      (ctl_tx_send_idle),
.ctl_tx_send_rfi                       (ctl_tx_send_rfi),
.ctl_tx_send_lfi                       (ctl_tx_send_lfi),
.tx_reset                              (tx_reset),
.gt_rxrecclkout                        (gt_rxrecclkout),
.tx_done_led                           (tx_done_led),
.tx_busy_led                           (tx_busy_led),
.stat_tx_pause                         (stat_tx_pause),
.stat_tx_pause_valid                   (stat_tx_pause_valid),
.stat_tx_user_pause                    (stat_tx_user_pause),
.ctl_tx_pause_req                      (ctl_tx_pause_req),
.ctl_tx_resend_pause                   (ctl_tx_resend_pause),
.stat_tx_bad_fcs                       (stat_tx_bad_fcs),
.stat_tx_broadcast                     (stat_tx_broadcast),
.stat_tx_frame_error                   (stat_tx_frame_error),
.stat_tx_local_fault                   (stat_tx_local_fault),
.stat_tx_multicast                     (stat_tx_multicast),
.stat_tx_packet_1024_1518_bytes        (stat_tx_packet_1024_1518_bytes),
.stat_tx_packet_128_255_bytes          (stat_tx_packet_128_255_bytes),
.stat_tx_packet_1519_1522_bytes        (stat_tx_packet_1519_1522_bytes),
.stat_tx_packet_1523_1548_bytes        (stat_tx_packet_1523_1548_bytes),
.stat_tx_packet_1549_2047_bytes        (stat_tx_packet_1549_2047_bytes),
.stat_tx_packet_2048_4095_bytes        (stat_tx_packet_2048_4095_bytes),
.stat_tx_packet_256_511_bytes          (stat_tx_packet_256_511_bytes),
.stat_tx_packet_4096_8191_bytes        (stat_tx_packet_4096_8191_bytes),
.stat_tx_packet_512_1023_bytes         (stat_tx_packet_512_1023_bytes),
.stat_tx_packet_64_bytes               (stat_tx_packet_64_bytes),
.stat_tx_packet_65_127_bytes           (stat_tx_packet_65_127_bytes),
.stat_tx_packet_8192_9215_bytes        (stat_tx_packet_8192_9215_bytes),
.stat_tx_packet_large                  (stat_tx_packet_large),
.stat_tx_packet_small                  (stat_tx_packet_small),
.stat_tx_total_bytes                   (stat_tx_total_bytes),
.stat_tx_total_good_bytes              (stat_tx_total_good_bytes),
.stat_tx_total_good_packets            (stat_tx_total_good_packets),
.stat_tx_total_packets                 (stat_tx_total_packets),
.stat_tx_unicast                       (stat_tx_unicast),
.stat_tx_vlan                          (stat_tx_vlan), 
.tx_preamblein                         (tx_preamblein),
.tx_rdyout                             (tx_rdyout),
.tx_datain0                            (tx_datain0),
.tx_enain0                             (tx_enain0),
.tx_sopin0                             (tx_sopin0),
.tx_eopin0                             (tx_eopin0),
.tx_errin0                             (tx_errin0),
.tx_mtyin0                             (tx_mtyin0),
.tx_datain1                            (tx_datain1),
.tx_enain1                             (tx_enain1),
.tx_sopin1                             (tx_sopin1),
.tx_eopin1                             (tx_eopin1),
.tx_errin1                             (tx_errin1),
.tx_mtyin1                             (tx_mtyin1),
.tx_datain2                            (tx_datain2),
.tx_enain2                             (tx_enain2),
.tx_sopin2                             (tx_sopin2),
.tx_eopin2                             (tx_eopin2),
.tx_errin2                             (tx_errin2),
.tx_mtyin2                             (tx_mtyin2),
.tx_datain3                            (tx_datain3),
.tx_enain3                             (tx_enain3),
.tx_sopin3                             (tx_sopin3),
.tx_eopin3                             (tx_eopin3),
.tx_errin3                             (tx_errin3),
.tx_mtyin3                             (tx_mtyin3),
.tx_ovfout                             (tx_ovfout),
.tx_unfout                             (tx_unfout),
.payload_rd(payload_rd),
.payload(payload),
.lbus_number_pkt_proc(lbus_number_pkt_proc),
.lbus_pkt_size_proc(lbus_pkt_size_proc),
.debug(debug)
);


cmac_usplus_0_lbus_pkt_mon
#(
.PKT_NUM                               (PKT_NUM)
) i_cmac_usplus_0_lbus_pkt_mon  
(
.clk                                   (gen_mon_clk),
.reset                                 (usr_rx_reset),
.sys_reset                             (sys_reset),
.send_continuous_pkts                  (send_continuous_pkts),
.stat_rx_aligned                       (stat_rx_aligned),
.lbus_tx_rx_restart_in                 (lbus_tx_rx_restart_in),
.rx_reset                              (rx_reset),
.rx_gt_locked_led                      (rx_gt_locked_led),
.rx_aligned_led                        (rx_aligned_led),
.rx_done_led                           (rx_done_led),
.rx_data_fail_led                      (rx_data_fail_led),
.rx_busy_led                           (rx_busy),
.stat_rx_pause                         (stat_rx_pause),
.stat_rx_user_pause                    (stat_rx_user_pause),
.stat_rx_pause_req                     (stat_rx_pause_req),
.stat_rx_pause_valid                   (stat_rx_pause_valid),
.stat_rx_pause_quanta0                 (stat_rx_pause_quanta0),
.stat_rx_pause_quanta1                 (stat_rx_pause_quanta1),
.stat_rx_pause_quanta2                 (stat_rx_pause_quanta2),
.stat_rx_pause_quanta3                 (stat_rx_pause_quanta3),
.stat_rx_pause_quanta4                 (stat_rx_pause_quanta4),
.stat_rx_pause_quanta5                 (stat_rx_pause_quanta5),
.stat_rx_pause_quanta6                 (stat_rx_pause_quanta6),
.stat_rx_pause_quanta7                 (stat_rx_pause_quanta7),
.stat_rx_pause_quanta8                 (stat_rx_pause_quanta8),
.stat_rx_aligned_err                   (stat_rx_aligned_err),
.stat_rx_bad_code                      (stat_rx_bad_code),
.stat_rx_bad_fcs                       (stat_rx_bad_fcs),
.stat_rx_bad_preamble                  (stat_rx_bad_preamble),
.stat_rx_bad_sfd                       (stat_rx_bad_sfd),
.stat_rx_bip_err_0                     (stat_rx_bip_err_0),
.stat_rx_bip_err_1                     (stat_rx_bip_err_1),
.stat_rx_bip_err_10                    (stat_rx_bip_err_10),
.stat_rx_bip_err_11                    (stat_rx_bip_err_11),
.stat_rx_bip_err_12                    (stat_rx_bip_err_12),
.stat_rx_bip_err_13                    (stat_rx_bip_err_13),
.stat_rx_bip_err_14                    (stat_rx_bip_err_14),
.stat_rx_bip_err_15                    (stat_rx_bip_err_15),
.stat_rx_bip_err_16                    (stat_rx_bip_err_16),
.stat_rx_bip_err_17                    (stat_rx_bip_err_17),
.stat_rx_bip_err_18                    (stat_rx_bip_err_18),
.stat_rx_bip_err_19                    (stat_rx_bip_err_19),
.stat_rx_bip_err_2                     (stat_rx_bip_err_2),
.stat_rx_bip_err_3                     (stat_rx_bip_err_3),
.stat_rx_bip_err_4                     (stat_rx_bip_err_4),
.stat_rx_bip_err_5                     (stat_rx_bip_err_5),
.stat_rx_bip_err_6                     (stat_rx_bip_err_6),
.stat_rx_bip_err_7                     (stat_rx_bip_err_7),
.stat_rx_bip_err_8                     (stat_rx_bip_err_8),
.stat_rx_bip_err_9                     (stat_rx_bip_err_9),
.stat_rx_block_lock                    (stat_rx_block_lock),
.stat_rx_broadcast                     (stat_rx_broadcast),
.stat_rx_fragment                      (stat_rx_fragment),
.stat_rx_framing_err_0                 (stat_rx_framing_err_0),
.stat_rx_framing_err_1                 (stat_rx_framing_err_1),
.stat_rx_framing_err_10                (stat_rx_framing_err_10),
.stat_rx_framing_err_11                (stat_rx_framing_err_11),
.stat_rx_framing_err_12                (stat_rx_framing_err_12),
.stat_rx_framing_err_13                (stat_rx_framing_err_13),
.stat_rx_framing_err_14                (stat_rx_framing_err_14),
.stat_rx_framing_err_15                (stat_rx_framing_err_15),
.stat_rx_framing_err_16                (stat_rx_framing_err_16),
.stat_rx_framing_err_17                (stat_rx_framing_err_17),
.stat_rx_framing_err_18                (stat_rx_framing_err_18),
.stat_rx_framing_err_19                (stat_rx_framing_err_19),
.stat_rx_framing_err_2                 (stat_rx_framing_err_2),
.stat_rx_framing_err_3                 (stat_rx_framing_err_3),
.stat_rx_framing_err_4                 (stat_rx_framing_err_4),
.stat_rx_framing_err_5                 (stat_rx_framing_err_5),
.stat_rx_framing_err_6                 (stat_rx_framing_err_6),
.stat_rx_framing_err_7                 (stat_rx_framing_err_7),
.stat_rx_framing_err_8                 (stat_rx_framing_err_8),
.stat_rx_framing_err_9                 (stat_rx_framing_err_9),
.stat_rx_framing_err_valid_0           (stat_rx_framing_err_valid_0),
.stat_rx_framing_err_valid_1           (stat_rx_framing_err_valid_1),
.stat_rx_framing_err_valid_10          (stat_rx_framing_err_valid_10),
.stat_rx_framing_err_valid_11          (stat_rx_framing_err_valid_11),
.stat_rx_framing_err_valid_12          (stat_rx_framing_err_valid_12),
.stat_rx_framing_err_valid_13          (stat_rx_framing_err_valid_13),
.stat_rx_framing_err_valid_14          (stat_rx_framing_err_valid_14),
.stat_rx_framing_err_valid_15          (stat_rx_framing_err_valid_15),
.stat_rx_framing_err_valid_16          (stat_rx_framing_err_valid_16),
.stat_rx_framing_err_valid_17          (stat_rx_framing_err_valid_17),
.stat_rx_framing_err_valid_18          (stat_rx_framing_err_valid_18),
.stat_rx_framing_err_valid_19          (stat_rx_framing_err_valid_19),
.stat_rx_framing_err_valid_2           (stat_rx_framing_err_valid_2),
.stat_rx_framing_err_valid_3           (stat_rx_framing_err_valid_3),
.stat_rx_framing_err_valid_4           (stat_rx_framing_err_valid_4),
.stat_rx_framing_err_valid_5           (stat_rx_framing_err_valid_5),
.stat_rx_framing_err_valid_6           (stat_rx_framing_err_valid_6),
.stat_rx_framing_err_valid_7           (stat_rx_framing_err_valid_7),
.stat_rx_framing_err_valid_8           (stat_rx_framing_err_valid_8),
.stat_rx_framing_err_valid_9           (stat_rx_framing_err_valid_9),
.stat_rx_got_signal_os                 (stat_rx_got_signal_os),
.stat_rx_hi_ber                        (stat_rx_hi_ber),
.stat_rx_inrangeerr                    (stat_rx_inrangeerr),
.stat_rx_internal_local_fault          (stat_rx_internal_local_fault),
.stat_rx_jabber                        (stat_rx_jabber),
.stat_rx_local_fault                   (stat_rx_local_fault),
.stat_rx_mf_err                        (stat_rx_mf_err),
.stat_rx_mf_len_err                    (stat_rx_mf_len_err),
.stat_rx_mf_repeat_err                 (stat_rx_mf_repeat_err),
.stat_rx_misaligned                    (stat_rx_misaligned),
.stat_rx_multicast                     (stat_rx_multicast),
.stat_rx_oversize                      (stat_rx_oversize),
.stat_rx_packet_1024_1518_bytes        (stat_rx_packet_1024_1518_bytes),
.stat_rx_packet_128_255_bytes          (stat_rx_packet_128_255_bytes),
.stat_rx_packet_1519_1522_bytes        (stat_rx_packet_1519_1522_bytes),
.stat_rx_packet_1523_1548_bytes        (stat_rx_packet_1523_1548_bytes),
.stat_rx_packet_1549_2047_bytes        (stat_rx_packet_1549_2047_bytes),
.stat_rx_packet_2048_4095_bytes        (stat_rx_packet_2048_4095_bytes),
.stat_rx_packet_256_511_bytes          (stat_rx_packet_256_511_bytes),
.stat_rx_packet_4096_8191_bytes        (stat_rx_packet_4096_8191_bytes), 
.stat_rx_packet_512_1023_bytes         (stat_rx_packet_512_1023_bytes),
.stat_rx_packet_64_bytes               (stat_rx_packet_64_bytes),
.stat_rx_packet_65_127_bytes           (stat_rx_packet_65_127_bytes),
.stat_rx_packet_8192_9215_bytes        (stat_rx_packet_8192_9215_bytes),
.stat_rx_packet_bad_fcs                (stat_rx_packet_bad_fcs),
.stat_rx_packet_large                  (stat_rx_packet_large),
.stat_rx_packet_small                  (stat_rx_packet_small),
.stat_rx_received_local_fault          (stat_rx_received_local_fault),
.stat_rx_remote_fault                  (stat_rx_remote_fault),
.stat_rx_status                        (stat_rx_status),
.stat_rx_stomped_fcs                   (stat_rx_stomped_fcs),
.stat_rx_synced                        (stat_rx_synced),
.stat_rx_synced_err                    (stat_rx_synced_err),
.stat_rx_test_pattern_mismatch         (stat_rx_test_pattern_mismatch),
.stat_rx_toolong                       (stat_rx_toolong),
.stat_rx_total_bytes                   (stat_rx_total_bytes),
.stat_rx_total_good_bytes              (stat_rx_total_good_bytes),
.stat_rx_total_good_packets            (stat_rx_total_good_packets),
.stat_rx_total_packets                 (stat_rx_total_packets),
.stat_rx_truncated                     (stat_rx_truncated),
.stat_rx_undersize                     (stat_rx_undersize),
.stat_rx_unicast                       (stat_rx_unicast),
.stat_rx_vlan                          (stat_rx_vlan),
.stat_rx_pcsl_demuxed                  (stat_rx_pcsl_demuxed ),
.stat_rx_pcsl_number_0                 (stat_rx_pcsl_number_0),
.stat_rx_pcsl_number_1                 (stat_rx_pcsl_number_1),
.stat_rx_pcsl_number_10                (stat_rx_pcsl_number_10),
.stat_rx_pcsl_number_11                (stat_rx_pcsl_number_11),
.stat_rx_pcsl_number_12                (stat_rx_pcsl_number_12),
.stat_rx_pcsl_number_13                (stat_rx_pcsl_number_13),
.stat_rx_pcsl_number_14                (stat_rx_pcsl_number_14),
.stat_rx_pcsl_number_15                (stat_rx_pcsl_number_15),
.stat_rx_pcsl_number_16                (stat_rx_pcsl_number_16),
.stat_rx_pcsl_number_17                (stat_rx_pcsl_number_17),
.stat_rx_pcsl_number_18                (stat_rx_pcsl_number_18),
.stat_rx_pcsl_number_19                (stat_rx_pcsl_number_19),
.stat_rx_pcsl_number_2                 (stat_rx_pcsl_number_2),
.stat_rx_pcsl_number_3                 (stat_rx_pcsl_number_3),
.stat_rx_pcsl_number_4                 (stat_rx_pcsl_number_4),
.stat_rx_pcsl_number_5                 (stat_rx_pcsl_number_5),
.stat_rx_pcsl_number_6                 (stat_rx_pcsl_number_6),
.stat_rx_pcsl_number_7                 (stat_rx_pcsl_number_7),
.stat_rx_pcsl_number_8                 (stat_rx_pcsl_number_8),
.stat_rx_pcsl_number_9                 (stat_rx_pcsl_number_9),
.rx_preambleout                        (rx_preambleout),
.rx_dataout0                           (rx_dataout0),
.rx_enaout0                            (rx_enaout0),
.rx_sopout0                            (rx_sopout0),
.rx_eopout0                            (rx_eopout0),
.rx_errout0                            (rx_errout0),
.rx_mtyout0                            (rx_mtyout0),
.rx_dataout1                           (rx_dataout1),
.rx_enaout1                            (rx_enaout1),
.rx_sopout1                            (rx_sopout1),
.rx_eopout1                            (rx_eopout1),
.rx_errout1                            (rx_errout1),
.rx_mtyout1                            (rx_mtyout1),
.rx_dataout2                           (rx_dataout2),
.rx_enaout2                            (rx_enaout2),
.rx_sopout2                            (rx_sopout2),
.rx_eopout2                            (rx_eopout2),
.rx_errout2                            (rx_errout2),
.rx_mtyout2                            (rx_mtyout2),
.rx_dataout3                           (rx_dataout3),
.rx_enaout3                            (rx_enaout3),
.rx_sopout3                            (rx_sopout3),
.rx_eopout3                            (rx_eopout3),
.rx_errout3                            (rx_errout3),
.rx_mtyout3                            (rx_mtyout3)
);


cmac_usplus_0_axi4_lite_user_if i_cmac_usplus_0_axi4_lite_user_if
(
.lbus_clk                              (gen_mon_clk),
.reset                                 (sys_reset),
.rx_gt_locked                          (rx_gt_locked_led),
.stat_rx_aligned                       (stat_rx_aligned),
.rx_done                               (rx_done_led),
.rx_busy                               (rx_busy),
.rx_busy_led                           (rx_busy_led),
.stat_reg_compare_out                  (stat_reg_compare_out),
.sanity_init_done                      (sanity_init_done),
.pause_init_done                       (pause_init_done),
.s_axi_aclk                            (s_axi_aclk),
.s_axi_sreset                          (s_axi_sreset),
.pm_tick                               (pm_tick),
.s_axi_awaddr                          (s_axi_awaddr),
.s_axi_awvalid                         (s_axi_awvalid),
.s_axi_awready                         (s_axi_awready),
.s_axi_wdata                           (s_axi_wdata),
.s_axi_wstrb                           (s_axi_wstrb),
.s_axi_wvalid                          (s_axi_wvalid),
.s_axi_wready                          (s_axi_wready),
.s_axi_bresp                           (s_axi_bresp),
.s_axi_bvalid                          (s_axi_bvalid),
.s_axi_bready                          (s_axi_bready),
.s_axi_araddr                          (s_axi_araddr),
.s_axi_arvalid                         (s_axi_arvalid),
.s_axi_arready                         (s_axi_arready),
.s_axi_rdata                           (s_axi_rdata),
.s_axi_rresp                           (s_axi_rresp),
.s_axi_rvalid                          (s_axi_rvalid),
.s_axi_rready                          (s_axi_rready)
);

endmodule

