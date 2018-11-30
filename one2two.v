module one2two(reset,input_data,output_data,clk);
	input input_data;
	input clk;
	input reset;
	output reg [1:0]output_data;
	reg [1:0]data;
	reg state;
	reg flag;
	reg [3:0]count;
	initial begin
		count <= 0;
		flag <= 0;
		state <= 0;
		data <= 0;
		output_data <= 0;
	end
	always @(posedge clk or negedge reset) begin
	if(~reset) begin
		count <= 0;
		flag <= 0;
		state <= 0;
		data <= 0;
	end
	else begin
		if (state == 1) begin
			if(count == 4'd15) begin
				count <= 0;
				state <= 0;
			end
			else begin
				count <= count + 1;
			end
			if (flag == 0) begin
				data[1] <= input_data;
				flag <= 1;
			end
			else begin
				data[0] <= input_data;
				flag <= 0;
				output_data[1] <= data[1];
				output_data[0] <= input_data;
			end
		end
		else begin
			if(input_data == 1 && data[1] == 1) begin
				state <= 1;
				output_data <= 2'b11;
			end
			data[1] <= input_data;
			data[0] <= data[1];
		end
	end
	end
endmodule