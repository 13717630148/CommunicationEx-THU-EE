module modulate(clk,in,reset,output_data6,send);
	input clk;
	input reset;
	input [7:0]in;
	wire [7:0]in_pcm;
	wire out_pcm;
	input send;
	
    wire [1:0]input_data;
    output [7:0]output_data6;
	wire clk_fre1,clk_fre2,output_data1, output_data2,output_data3,clk_base,clk_conv;
	wire [1:0] output_data4;
    wire [7:0] output_data5;
	fenpin fenbin_Test(reset,clk,clk_fre1,clk_fre2,clk_base);
	fenpin_2 fenbin_fre2_Test(reset,clk_base,clk_conv);
	agfe PCM_Encode(reset,in,in_pcm);
	eight2one eight2one_Test(reset,in_pcm,out_pcm,clk_conv,send);
	convolution conv_Test(reset,clk_conv,out_pcm,input_data);
	two2one two2one_Test(reset,input_data, output_data1, clk_base);
	modulate_2fsk modulateTest(reset,clk,output_data1, output_data2,clk_fre1,clk_fre2);
    demodulate demodulateTest(reset,output_data2,output_data3,clk);
    one2two one2twoTest(reset,output_data3,output_data4,clk_base);
    decoder decoderTest(reset,output_data4,clk_conv,output_data5);
    agfd pcm_Decode(reset,output_data5,output_data6);
	initial
		begin
			clk <= 1'b1;
			in <= 0;
			send <= 1;
			reset <= 0;
			#2000 in <= 8'b00010100;
			#200000 in <= 8'b00100011;
			#200000 in <= 8'b01101000;
		end
endmodule
