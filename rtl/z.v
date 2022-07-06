/*标志寄存器 12-6*/
module z(din,clk,rst, zload,dout);
input [7:0] din;
input clk, rst, zload;
output [0:0] dout;
reg [0:0]dout;
always @(posedge clk or negedge rst)
	if(!rst)
		dout<=0;
	else if(zload)
		begin	
			if(din==8'b00000000)
				dout<=1;
			else
				dout<=0;
		end
endmodule
