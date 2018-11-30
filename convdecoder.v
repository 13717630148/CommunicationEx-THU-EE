// PCM module processes 1 Byte each time.
module decoder(input reset, input [1:0] conv_code, input clk, output reg [7:0] pcm);
reg [3:0] dist[3:0];
reg [1:0] src[7:0][3:0];
reg [1:0] route[7:0];
reg [3:0] step;
reg flag;
reg [1:0]dist_00[3:0];
reg [1:0]dist_02[3:0];
reg [1:0]dist_10[3:0];
reg [1:0]dist_12[3:0];
reg [1:0]dist_21[3:0];
reg [1:0]dist_23[3:0];
reg [1:0]dist_31[3:0];
reg [1:0]dist_33[3:0];
/*
// You may use parameter arrays in System Verilog.
// In Verilog they will be concatenated.
parameter [7:0] dist_00 = {2'd2, 2'd1, 2'd1, 2'd0};
parameter [7:0] dist_02 = {2'd0, 2'd1, 2'd1, 2'd2};
parameter [7:0] dist_10 = {2'd0, 2'd1, 2'd1, 2'd2};
parameter [7:0] dist_12 = {2'd2, 2'd1, 2'd1, 2'd0};
parameter [7:0] dist_21 = {2'd1, 2'd0, 2'd2, 2'd1};
parameter [7:0] dist_23 = {2'd1, 2'd2, 2'd0, 2'd1};
parameter [7:0] dist_31 = {2'd1, 2'd2, 2'd0, 2'd1};
parameter [7:0] dist_33 = {2'd1, 2'd0, 2'd2, 2'd1};
*/

initial
begin
    flag <= 1'b0;
    step <= 4'b1111;
    pcm <= 0;
    dist[3] <= 0;
    dist[2] <= 0;
    dist[1] <= 0;
    dist[0] <= 0;

    route[7] <= 0;
    route[6] <= 0;
    route[5] <= 0;
    route[4] <= 0;
    route[3] <= 0;
    route[2] <= 0;
    route[1] <= 0;
    route[0] <= 0;

    src[7][3] <= 0;
    src[7][2] <= 0;
    src[7][1] <= 0;
    src[7][0] <= 0;

    src[6][3] <= 0;
    src[6][2] <= 0;
    src[6][1] <= 0;
    src[6][0] <= 0;

    src[5][3] <= 0;
    src[5][2] <= 0;
    src[5][1] <= 0;
    src[5][0] <= 0;

    src[4][3] <= 0;
    src[4][2] <= 0;
    src[4][1] <= 0;
    src[4][0] <= 0;

    src[3][3] <= 0;
    src[3][2] <= 0;
    src[3][1] <= 0;
    src[3][0] <= 0;

    src[2][3] <= 0;
    src[2][2] <= 0;
    src[2][1] <= 0;
    src[2][0] <= 0;

    src[1][3] <= 0;
    src[1][2] <= 0;
    src[1][1] <= 0;
    src[1][0] <= 0;

    src[0][3] <= 0;
    src[0][2] <= 0;
    src[0][1] <= 0;
    src[0][0] <= 0;

    dist_00[3] <= 2'd2;
    dist_00[2] <= 2'd1;
    dist_00[1] <= 2'd1;
    dist_00[0] <= 2'd0;

    dist_02[3] <= 2'd0;
    dist_02[2] <= 2'd1;
    dist_02[1] <= 2'd1;
    dist_02[0] <= 2'd2;

    dist_10[3] <= 2'd0;
    dist_10[2] <= 2'd1;
    dist_10[1] <= 2'd1;
    dist_10[0] <= 2'd2;

    dist_12[3] <= 2'd2;
    dist_12[2] <= 2'd1;
    dist_12[1] <= 2'd1;
    dist_12[0] <= 2'd0;

    dist_21[3] <= 2'd1;
    dist_21[2] <= 2'd0;
    dist_21[1] <= 2'd2;
    dist_21[0] <= 2'd1;

    dist_23[3] <= 2'd1;
    dist_23[2] <= 2'd2;
    dist_23[1] <= 2'd0;
    dist_23[0] <= 2'd1;

    dist_31[3] <= 2'd1;
    dist_31[2] <= 2'd2;
    dist_31[1] <= 2'd0;
    dist_31[0] <= 2'd1;

    dist_33[3] <= 2'd1;
    dist_33[2] <= 2'd0;
    dist_33[1] <= 2'd2;
    dist_33[0] <= 2'd1;

end
always @ (posedge clk or negedge reset)
begin
if(~reset)
begin
    flag <= 1'b0;
    step <= 4'b1111;
    pcm <= 0;
    dist[3] <= 0;
    dist[2] <= 0;
    dist[1] <= 0;
    dist[0] <= 0;

    route[7] <= 0;
    route[6] <= 0;
    route[5] <= 0;
    route[4] <= 0;
    route[3] <= 0;
    route[2] <= 0;
    route[1] <= 0;
    route[0] <= 0;

    src[7][3] <= 0;
    src[7][2] <= 0;
    src[7][1] <= 0;
    src[7][0] <= 0;

    src[6][3] <= 0;
    src[6][2] <= 0;
    src[6][1] <= 0;
    src[6][0] <= 0;

    src[5][3] <= 0;
    src[5][2] <= 0;
    src[5][1] <= 0;
    src[5][0] <= 0;

    src[4][3] <= 0;
    src[4][2] <= 0;
    src[4][1] <= 0;
    src[4][0] <= 0;

    src[3][3] <= 0;
    src[3][2] <= 0;
    src[3][1] <= 0;
    src[3][0] <= 0;

    src[2][3] <= 0;
    src[2][2] <= 0;
    src[2][1] <= 0;
    src[2][0] <= 0;

    src[1][3] <= 0;
    src[1][2] <= 0;
    src[1][1] <= 0;
    src[1][0] <= 0;

    src[0][3] <= 0;
    src[0][2] <= 0;
    src[0][1] <= 0;
    src[0][0] <= 0;
end
// Suppose every byte starts with 1.
// In fact, with this assumption, src[0] and route[1:0] are useless.
if ((conv_code[1:0] == 2'b11) && (flag == 0))
    begin
        flag <= 1'b1;
        step <= 4'b0000;
        dist_00[3] <= 2'd2;
        dist_00[2] <= 2'd1;
        dist_00[1] <= 2'd1;
        dist_00[0] <= 2'd0;

        dist_02[3] <= 2'd0;
        dist_02[2] <= 2'd1;
        dist_02[1] <= 2'd1;
        dist_02[0] <= 2'd2;

        dist_10[3] <= 2'd0;
        dist_10[2] <= 2'd1;
        dist_10[1] <= 2'd1;
        dist_10[0] <= 2'd2;

        dist_12[3] <= 2'd2;
    	dist_12[2] <= 2'd1;
    	dist_12[1] <= 2'd1;
    	dist_12[0] <= 2'd0;

    	dist_21[3] <= 2'd1;
    	dist_21[2] <= 2'd0;
    	dist_21[1] <= 2'd2;
    	dist_21[0] <= 2'd1;

    	dist_23[3] <= 2'd1;
    	dist_23[2] <= 2'd2;
    	dist_23[1] <= 2'd0;
    	dist_23[0] <= 2'd1;

    	dist_31[3] <= 2'd1;
    	dist_31[2] <= 2'd2;
    	dist_31[1] <= 2'd0;
    	dist_31[0] <= 2'd1;

    	dist_33[3] <= 2'd1;
    	dist_33[2] <= 2'd0;
    	dist_33[1] <= 2'd2;
    	dist_33[0] <= 2'd1;
    end
if (flag == 1)
    begin
        case (step)
            4'b0000:
            begin
                // Suppose every byte starts with 1.
                dist[0] <= dist_00[conv_code]+dist_00[3];
                dist[1] <= dist_21[conv_code]+dist_02[3];
                dist[2] <= dist_02[conv_code]+dist_00[3];
                dist[3] <= dist_23[conv_code]+dist_02[3];
	            src[0][0] <= 2'b00;
	            src[0][1] <= 2'b10;
	            src[0][2] <= 2'b00;
	            src[0][3] <= 2'b10;
                step <= step+1;
            end
            4'b0001:
            begin
                dist[0] <= (dist_10[conv_code]+dist[1] < dist_00[conv_code]+dist[0]) ?
                            dist_10[conv_code]+dist[1] : dist_00[conv_code]+dist[0];
                dist[1] <= (dist_31[conv_code]+dist[3] < dist_21[conv_code]+dist[2]) ?
                            dist_31[conv_code]+dist[3] : dist_21[conv_code]+dist[2];
                dist[2] <= (dist_12[conv_code]+dist[1] < dist_02[conv_code]+dist[0]) ?
                            dist_12[conv_code]+dist[1] : dist_02[conv_code]+dist[0];
                dist[3] <= (dist_33[conv_code]+dist[3] < dist_23[conv_code]+dist[2]) ?
                            dist_33[conv_code]+dist[3] : dist_23[conv_code]+dist[2];
                src[1][0] <= 2'b01;
                src[1][1] <= 2'b11;
                src[1][2] <= 2'b01;
                src[1][3] <= 2'b11;
                step <= step+1;
            end
            4'b1000:
            begin
                if ((dist[3] < dist[2]) && (dist[3] < dist[1]) && (dist[3] < dist[0]))
                    route[7] <= src[7][3];
                else if ((dist[2] < dist[1]) && (dist[2] < dist[0]))
                    route[7] <= src[7][2];
                else if (dist[1] < dist[0])
                    route[7] <= src[7][1];
                else
                    route[7] <= src[7][0];
                step <= step+1;
            end
	        4'b1001: begin route[6] <= src[6][route[7]]; step <= step+1; end
	        4'b1010: begin route[5] <= src[5][route[6]]; step <= step+1; end
	        4'b1011: begin route[4] <= src[4][route[5]]; step <= step+1; end
	        4'b1100: begin route[3] <= src[3][route[4]]; step <= step+1; end
	        4'b1101: begin route[2] <= src[2][route[3]]; step <= step+1; end
	        4'b1110: 
	        begin
	        	pcm[7] <= 1'b1;
                pcm[6] <= src[1][route[2]]>>1;
                pcm[5] <= route[2]>>1;
                pcm[4] <= route[3]>>1;
                pcm[3] <= route[4]>>1;
                pcm[2] <= route[5]>>1;
                pcm[1] <= route[6]>>1;
                pcm[0] <= route[7]>>1;
				step <= step+1; 
				flag <= 1'b0;
	        end
            default: // Make a choice! If it can not decide, choose the upper one.
            begin
                dist[0] <= (dist_10[conv_code]+dist[1] < dist_00[conv_code]+dist[0]) ?
                            dist_10[conv_code]+dist[1] : dist_00[conv_code]+dist[0];
                dist[1] <= (dist_31[conv_code]+dist[3] < dist_21[conv_code]+dist[2]) ?
                            dist_31[conv_code]+dist[3] : dist_21[conv_code]+dist[2];
                dist[2] <= (dist_12[conv_code]+dist[1] < dist_02[conv_code]+dist[0]) ?
                            dist_12[conv_code]+dist[1] : dist_02[conv_code]+dist[0];
                dist[3] <= (dist_33[conv_code]+dist[3] < dist_23[conv_code]+dist[2]) ?
                            dist_33[conv_code]+dist[3] : dist_23[conv_code]+dist[2];
                src[step][0] <= (dist_00[conv_code]+dist[0] > dist_10[conv_code]+dist[1]) ?
                                2'b01 : 2'b00;
                src[step][1] <= (dist_21[conv_code]+dist[2] > dist_31[conv_code]+dist[3]) ?
                                2'b11 : 2'b10;
                src[step][2] <= (dist_02[conv_code]+dist[0] > dist_12[conv_code]+dist[1]) ?
                                2'b01 : 2'b00;
                src[step][3] <= (dist_23[conv_code]+dist[2] > dist_33[conv_code]+dist[3]) ?
                                2'b11 : 2'b10;
                step <= step+1;
            end
        endcase
    end
end
endmodule
