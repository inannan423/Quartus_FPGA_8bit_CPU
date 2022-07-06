/*算术逻辑单元 12-9*/
module alu(alus,ac, bus, dout);
input[7:0] ac,bus;
input[3:0] alus;
output reg[7:0] dout;
always@(alus or ac or bus)
	case(alus)
		4'b0000:	dout = 8'b00000000;//clac 清零
		4'b0001:	dout = ac + bus;//add 加法
		4'b0010:	dout = ac - bus;//sub 减法
		4'b0011:	dout = ac+ 8'b00000001;//inac 自加
		4'b0100:	dout = bus+8'b00000000;//movr r->ac
		4'b0101:	dout = ac & bus;//and 与
		4'b0110:	dout = ac | bus;//or 或
		4'b0111:	dout = ~ac;//not 非
		4'b1000:	dout = (~ac & bus) | (ac & ~bus);//xor 异或
		4'b1001: dout = bus+8'b00000000;//ldac
		default: dout = 4'bz;
	endcase
endmodule
