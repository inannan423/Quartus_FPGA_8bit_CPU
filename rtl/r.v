/*R通用寄存器，用来存放第二个操作数 12-7*/
module r(din, clk, rst,rload, dout);
input clk,rst,rload;
input [7:0]din;
output reg[7:0]dout;
always@(posedge clk or negedge rst)
begin
	if(rst==0)
		dout<=0;
	else if(rload)
		dout<=din;
end
endmodule
