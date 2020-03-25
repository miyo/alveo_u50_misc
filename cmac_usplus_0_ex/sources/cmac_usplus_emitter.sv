`default_nettype none

module cmac_usplus_emitter
  (
   input wire clk,
   input wire reset,

   input wire [511:0] din_data,
   input wire din_valid,
   input wire din_sop,
   input wire din_eop,
   input wire [7:0] din_mty,

   output reg [511:0] dout_data,
   output reg dout_valid,
   output wire dout_kick,
   output reg [13:0] dout_bytes,
   input wire cmac_busy,
   input wire cmac_done
   );

    always @(posedge clk) begin
	dout_data <= din_data;
	dout_valid <= din_valid;
    end

    reg[7:0] data_ready_state = 8'd0;
    reg dout_ready = 1'b0;

    always @(posedge clk) begin
	if(data_ready_state == 0) begin
	    if(din_valid == 1 && din_sop == 1) begin
		if(din_eop == 1) begin
		    dout_ready <= 1;
		    dout_bytes <= 64 - din_mty;
		end else begin
		    dout_ready <= 0;
		    dout_bytes <= 64;
		    data_ready_state <= data_ready_state + 1;
		end
	    end else begin
		dout_ready <= 0;
	    end
	end else if(data_ready_state == 1) begin
	    if(din_valid == 1) begin
		if(din_eop == 1) begin
		    dout_ready <= 1;
		    dout_bytes <= dout_bytes + (64 - din_mty);
		    data_ready_state <= 0;
		end else begin
		    dout_ready <= 0;
		    dout_bytes <= dout_bytes + 64;
		end
	    end else begin
		dout_ready <= 0;
	    end
	end else begin
	    dout_ready <= 0;
	end
    end

    reg kick_d1 = 1'b0;
    reg kick_d2 = 1'b0;
    reg[3:0] kick_state = 4'd0;
    reg kick_reg = 1'b0;
    assign dout_kick = kick_reg;

    always @(posedge clk) begin
	kick_d1 <= dout_ready;
	kick_d2 <= kick_d1;
	case(kick_state)
	    0 : begin
		if(kick_d2 == 1'b0 && kick_d1 == 1'b1) begin
		    kick_reg <= 1'b1;
		    kick_state <= kick_state + 1;
		end else begin
		    kick_reg <= 1'b0;
		end
	    end
	    1 : begin
		if(cmac_busy == 1'b1) begin // TX begin
		    kick_reg <= 1'b0;
		    kick_state <= kick_state + 1;
		end
	    end
	    2 : begin
		if(cmac_done == 1'b1) begin // TX done
		    kick_state <= 0;
		end
	    end
	    default: begin
		kick_state <= 0;
		kick_reg <= 1'b0;
	    end
	endcase // case (kick_state)
    end

endmodule // cmac_usplus_emitter

`default_nettype wire

