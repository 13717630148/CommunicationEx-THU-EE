//(2,1,3) Convolution Encoder Module
//2 registers
module convolution
(
    reset,
    clk,
    code_in,
    code_out,
);

input clk;
input reset;
input code_in;

output reg [1:0] code_out;

reg [1:0] next_state;
reg flag;
reg [3:0] cnt;

initial begin
	code_out <= 0;
	next_state <= 0;
    flag <= 0;
    cnt <= 0;
end

always@(posedge clk or negedge reset) 
begin
if(~reset) begin
    next_state <= 0;
    flag <= 0;
    cnt <= 0;
end
else begin
if(flag == 1)
    begin
        code_out[0] <= code_in + next_state[0];
        code_out[1] <= code_in + next_state[1] + next_state[0];
        
        if(cnt == 4'd7) begin
            cnt <= 0;
            next_state <= 2'b0;
        end
        else begin
            cnt <= cnt+1;
            next_state[0] <= next_state[1];
            next_state[1] <= code_in;
        end
    end
else if(code_in == 1)
    begin
        flag <= 1;
        cnt <= 1;
        code_out[1:0] <= 2'b11;
        next_state[1] <= 1;
    end  
end
end

endmodule
