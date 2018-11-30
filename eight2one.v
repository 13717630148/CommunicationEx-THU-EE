module eight2one(reset,in_pcm,out_pcm,clk,send);
	input [7:0]in_pcm;
	input clk;
	input send;
	input reset;
	output out_pcm;
	reg [1:0]state;
	reg [3:0]count;
	initial begin
		count <= 0;
		state <= 0;
	end
	assign out_pcm = (state == 2'b00) ? 0:
					 (state == 2'b10) ? 0:
					 (count == 1) ? in_pcm[7]:
					 (count == 2) ? in_pcm[6]:
					 (count == 3) ? in_pcm[5]:
					 (count == 4) ? in_pcm[4]:
					 (count == 5) ? in_pcm[3]:
					 (count == 6) ? in_pcm[2]:
					 (count == 7) ? in_pcm[1]:
					 (count == 8) ? in_pcm[0]:0;
	always @(posedge clk or negedge send or negedge reset) begin
	if(~reset) begin
		count <= 0;
		state <= 0;
	end
	else begin
	   if(~send) begin
			if(in_pcm[7] == 1) begin
				count <= 0;
				state <= 1;
			end
		end
		else begin
			if(state == 2'b01) begin
				if(count == 8) begin
					count <= 0;
					state <= 0;
				end
			count <= count + 1;
			end
		end
	end
	end
	
endmodule