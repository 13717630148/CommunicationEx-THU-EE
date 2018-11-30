module fenpin(reset,in_clk,out_clk_fre1,out_clk_fre2,out_clk_base);
	input in_clk;
	input reset;
	output reg out_clk_fre1, out_clk_fre2, out_clk_base;
	reg [4:0]count_1;
	reg [4:0]count_2;
	reg [10:0]count_3;
	initial begin
		out_clk_fre1 <= 0;
		out_clk_fre2 <= 0;
		out_clk_base <= 0;
		count_1 <= 0;
		count_2 <= 0;
		count_3 <= 0;
	end
	always @(posedge in_clk or negedge reset) begin
	    if(~reset) begin
		    count_1 <= 0;
		end
		else begin
		if(count_1 == 5'b00100) begin
			out_clk_fre1 <= ~out_clk_fre1;
			count_1 <= count_1 + 1;
		end
		else if(count_1 == 5'b01000) begin
			out_clk_fre1 <= ~out_clk_fre1;
			count_1 <= 1;
		end
		else begin
			count_1 <= count_1 + 1;
		end
		end
	end
	always @(posedge in_clk or negedge reset) begin
	    if(~reset) begin
		    count_2 <= 0;
		end
		else begin
		if(count_2 == 5'b01000) begin
			out_clk_fre2 <= ~out_clk_fre2;
			count_2 <= count_2 + 1;
		end
		else if(count_2 == 5'b10000) begin
			out_clk_fre2 <= ~out_clk_fre2;
			count_2 <= 1;
		end
		else begin
			count_2 <= count_2 + 1;
		end
		end
	end
	always @(posedge in_clk or negedge reset) begin
		if(~reset) begin
			count_3 <= 0;
		end
		else begin
		if(count_3 == 11'b01000000000) begin
			out_clk_base <= ~out_clk_base;
			count_3 <= count_3 + 1;
		end
		else if(count_3 == 11'b10000000000) begin
			out_clk_base <= ~out_clk_base;
			count_3 <= 1;
		end
		else begin
			count_3 <= count_3 + 1;
		end
	end
	end
endmodule

module fenpin_2(reset,in_clk,out_clk);
	input in_clk;
	input reset;
	output reg out_clk;
	initial begin
		out_clk <= 0;
	end

	always @(posedge in_clk) begin
		out_clk <= ~out_clk;
	end
endmodule
