/*程序计数器，输出当前执行的指令地址*/
/*输入din：地址输入；16位，来自于总线
   输入clk：时钟信号，进行时序控制；1位，来自qtsj.v的输出clk_choose；
   输入rst：复位信号，该位为1时系统正常工作，为0时系统复位；1位，来自控制器；
   输入pcload：载入信号，该位为1时该部件工作，为0时该部件不工作；1位，来自控制器；
   输入pcinc：PC+1；该信号为1，PC++；1位，来自控制器；
   输出dout：地址输出；16位，送往总线；
*/
module pc(din, clk, rst,pcload, pcinc, dout);
input[15:0]din;
input clk,rst, pcload, pcinc;
output[15:0]dout; 
reg[15:0]dout;
always@(posedge clk or negedge rst)
    if(!rst)
		begin
			dout<=0;
		end
		
    else if(pcload)		
	dout<=din;
	else if(pcinc)
	dout<=dout+1;
endmodule