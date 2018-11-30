module two2one(reset,in_data,out_data,clk);
	input [1:0]in_data;
	input clk;
	input reset;
	output reg out_data;
	reg [1:0]data;
	reg state;
	initial begin
		state <= 0;
		data <= 2'b00 ;
		out_data <= 2'b00;
	end
	always @(posedge clk or negedge reset) begin
	if (~reset) begin
		state <= 0;
		data <= 2'b00 ;
	end
	else begin
	    if(state == 0) begin
	    	data <= in_data;
			out_data <= in_data[1];
			state <= 1;
	    end
	    else begin
	    	out_data <= data[0];
	    	state <= 0;
	    end
	end
	end
endmodule