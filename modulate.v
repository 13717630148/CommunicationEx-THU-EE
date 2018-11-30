module modulate_2fsk(reset,clk,Data_in,Data_out,frequency_1,frequency_2);
	input Data_in;
	input reset;
	input clk;
	output Data_out;
	input frequency_1, frequency_2;
	reg Data;
	assign Data_out = (Data == 0) ? frequency_1:frequency_2;
	initial
		begin
			Data <= 0;
		end
	
	always @(posedge clk or negedge reset) begin
	if(~reset) begin
		Data <= 0;
	end
	else begin
		Data <= Data_in;
	end
	end
endmodule
