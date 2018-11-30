module demodulate(reset, in_data, out_data, clk);
	input in_data, clk;
	input reset;
	output reg out_data;
	reg in_data_before;
	reg [4:0] count;

	initial begin
		out_data <= 0;
		in_data_before <= 0;
		count <= 0;
	end

	always @(posedge clk or negedge reset) begin
	if(~reset) begin
		in_data_before <= 0;
		count <= 0;
	end
	else begin
		if (in_data == 1 && in_data_before == 0) begin
			count <= 0;
		end
		else if (in_data == 0 && in_data_before == 1) begin
			out_data <= (count <= 5'b00110) ? 0 : 1;
			count <= 0;
		end
		else begin
			count <= count + 1;
		end
		in_data_before <= in_data;
	end
	end
endmodule