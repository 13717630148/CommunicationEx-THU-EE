/* 
Tranditionally, PCM is used for 13 or more bit signal.
In our system, ADC/DAC are 8 bit.
Notations:
a: These are A law PCM related modules
b: double band / g: single band
c: part curve  / f: full curve
d: decode PCM  / e: encode ADC
Order was born of chaos.
abcdefg: transmission without modulation
gfedcba: transmission without modulation
An interesting reference: 
http://www.21ic.com/app/eda/201003/56615.htm
*/

// double band part curve
module abcd(input reset, input [7:0] pcm, output reg [7:0] data);
always @ (*)
begin
  data[7] <= pcm[7]; // Sign
  case (pcm[6:4])
    3'b000: data[6:0] <= {3'b000, pcm[3:0]     }; // pcm[6:0];
    3'b001: data[6:0] <= {3'b001, pcm[3:0]     }; // pcm[6:0];
    3'b010: data[6:0] <= {2'b01, pcm[3:0], 1'b1};
    3'b011: data[6:0] <= {1'b1, pcm[3:0], 2'b10};
    default: data[6:0] <= 0;
  endcase
end
endmodule
module abce(input reset, input [7:0] data, output [7:0] pcm);
  assign pcm[7] <= data[7]; // Sign
  assign pcm[6:0] = (data[6:5] == 2'b00) ? data[6:0]}:
                    (data[6:5] == 2'b01) ? {3'b010, data[4:1]}:
                    (data[6] == 1'b1) ? {3'b011, data[5:2]}:7'b0000000;
endmodule

// double band full curve
module abfd(input reset, input [7:0] pcm, output reg [7:0] data);
always @ (*)
begin
  data[7] <= pcm[7]; // Sign
  case (pcm[6:4])
    3'b000: data[6:0] <= {6'b000_000,      1'b0};
    3'b001: data[6:0] <= {6'b000_000,      1'b1};
    3'b010: data[6:0] <= {6'b000_001, pcm[3]   };
    3'b011: data[6:0] <= {5'b000_01, pcm[3:2]  };
    3'b100: data[6:0] <= {4'b000_1, pcm[3:1]   };
    3'b101: data[6:0] <= {3'b001, pcm[3:0]     };
    3'b110: data[6:0] <= {2'b01, pcm[3:0], 1'b1};
    3'b111: data[6:0] <= {1'b1, pcm[3:0], 2'b10};
    default: data[6:0] <= 0;
  endcase
end
endmodule
module abfe(input reset, input [7:0] data, output [7:0] pcm);
  assign pcm[7] <= data[7]; // Sign
  assign pcm[6:0] = (data[6:0] == 7'b000_0000) ? 7'b000_0000:
                    (data[6:0] == 7'b000_0001) ? 7'b001_0000:
                    (data[6:1] == 6'b000_001) ? {3'b010, data[0], 3'b000}:
                    (data[6:2] == 5'b000_01) ? {3'b011, data[1:0], 2'b00}:
                    (data[6:3] == 4'b000_1) ? {3'b100, data[2:0], 1'b0}:
                    (data[6:4] == 3'b001) ? {3'b101, data[3:0]}:
                    (data[6:5] == 2'b01) ? {3'b110, data[4:1]}:
                    (data[6] == 1'b1) ? {3'b111, data[5:2]}:7'b0000000;
endmodule

// single band part curve
module agcd(input reset, input [7:0] pcm, output reg [7:0] data);
always @ (*)
begin
  case (pcm[6:4])
    3'b000: data[7:0] <= {4'b0000, pcm[3:0]     }; // pcm[7:0];
    3'b001: data[7:0] <= {4'b0001, pcm[3:0]     }; // pcm[7:0];
    3'b010: data[7:0] <= {3'b001, pcm[3:0], 1'b1};
    3'b011: data[7:0] <= {2'b01, pcm[3:0], 2'b10};
    3'b100: data[7:0] <= {1'b1, pcm[3:0], 3'b100};
    default: data[7:0] <= 0;
  endcase
end
endmodule
module agce(input reset, input [7:0] data, output [7:0] pcm);
  assign pcm[7] <=  (data == 8'b00000000) ? 1'b0:1'b1; // Sign
  assign pcm[6:0] = (data[7:5] == 3'b000) ? data[6:0]:
                    (data[7:5] == 3'b001) ? {3'b010, data[4:1]}:
                    (data[7:6] == 2'b01) ? {3'b011, data[5:2]}:
                    (data[7] == 1'b1) ? {3'b100, data[6:3]}:7'b0000000;
endmodule

// single band full curve
module agfd(input reset, input [7:0] pcm, output reg [7:0] data);
always @ (*)
begin
  case (pcm[6:4])
    3'b000: data[7:0] <= {7'b0000_000, pcm[3]   };
    3'b001: data[7:0] <= {7'b0000_001, pcm[3]   };
    3'b010: data[7:0] <= {6'b0000_01, pcm[3:2]  };
    3'b011: data[7:0] <= {5'b0000_1, pcm[3:1]   };
    3'b100: data[7:0] <= {4'b0001, pcm[3:0]     };
    3'b101: data[7:0] <= {3'b001, pcm[3:0], 1'b1};
    3'b110: data[7:0] <= {2'b01, pcm[3:0], 2'b10};
    3'b111: data[7:0] <= {1'b1, pcm[3:0], 3'b100};
    default: data[7:0] <= 0;
  endcase
end
endmodule
module agfe(input reset, input [7:0] data, output [7:0] pcm);
	assign pcm[7] = (data == 8'b00000000) ? 1'b0:1'b1;
	assign pcm[6:0] = (data[7:1] == 7'b0000_000) ? {3'b000, data[0], 3'b000}:
	                  (data[7:1] == 7'b0000_001) ? {3'b001, data[0], 3'b000}:
	                  (data[7:2] == 6'b0000_01) ? {3'b010, data[1:0], 2'b00}:
	                  (data[7:3] == 5'b0000_1) ? {3'b011, data[2:0], 1'b0}:
	                  (data[7:4] == 4'b0001) ? {3'b100, data[3:0]}:
	                  (data[7:5] == 3'b001) ? {3'b101, data[4:1]}:
	                  (data[7:6] == 2'b01) ? {3'b110, data[5:2]}:
	                  (data[7] == 1'b1) ? {3'b111, data[6:3]}:7'b0000000;
endmodule

// Others
module gfedcba(input reset, input [7:0] pcm, output reg [7:0] data);
always @ (*)
begin
  data[7:0] <= pcm[7:0];
end
endmodule
module abcdefg(input reset, input [7:0] data, output [7:0] pcm);
  assign pcm[7:0] <= data[7:0];
endmodule
