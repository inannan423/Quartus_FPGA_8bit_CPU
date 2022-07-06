/*地址寄存器，输出要执行的下一指令地址*/
/*输入din：地址输入；16位，来自于总线
   输入clk：时钟信号，进行时序控制；1位，来自qtsj.v的输出clk_choose；
   输入rst：复位信号，该位为1时系统正常工作，为0时系统复位；1位，来自控制器；
   输入arload：载入信号，其有效且clk有上升沿来临时，将输入din直接由dout输出；1位，来自控制器；
   输入arinc：AR+1；该信号为1，AR++；1位，来自控制器；
   输出dout：地址输出；16位，送往存储器或连接到数码管；
*/
module ar(din, clk, rst,arload, arinc, dout);
input[15:0] din;
input clk,rst,arload, arinc;
output [15:0]dout;
reg [15:0]dout;
always@(posedge clk or negedge rst)
if(!rst)
	dout<=0;
else
	if(arload)
		dout<=din;
	else if(arinc)
		dout<=dout+1;
endmodule