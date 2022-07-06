/*启停电路*/
/*输入clk_quick：快时钟；1位，来自于分频模块clk_div的输出div_clk；
   输入clk_slow：慢时钟；1位，来自于分频模块clk_div的输出div_clk；
   输入clk_delay：为A1按钮的检测时钟，上升沿有，通过此时钟完成了A1按钮的延迟检测和防抖功能；1位，来自于分频模块clk_div的输出div_clk；
   输入clr：清零；1位，来自控制器；当clr有效时，时钟clk_run输出为0；
   输入rst：复位；1位，来自控制器；rst=0有效；rst与cpustate共同组成了reset的值；
   输入SW_choose：选择快慢时钟；1位，为1是快时钟，否则是慢时钟；top模块的输入，即SW15的状态；
   输入A1：按钮key1；1位，按下为0，弹起为1；top模块的输入
   输入cpustate：CPU的状态；2位，CPU_Controller模块的输出；
   输出clk_run：运行时的时钟，1位，送入控制器control的时钟；
   输出clk_choose：时钟；1位，是寄存器ar、pc等的时钟；
*/
module qtsj(clk_quick,clk_slow,clk_delay,clr,rst,SW_choose,A1,cpustate,clk_run,clk_choose);
input clk_quick,clk_slow;
input clk_delay;
input clr;
input rst;
input SW_choose;
input A1;//按钮key1
input [1:0] cpustate;
output clk_run,clk_choose;

reg A_d1,A_d2,clk_enable;
reg clr_d1,clr_d2;
wire reset;
wire A_Neg;
wire clr_Neg;

//wire clk_choose;
//wire clk_run;
assign reset = rst&(cpustate == 2'b11);
assign clk_choose = (SW_choose)?clk_quick:clk_slow;

always @(posedge clk_delay or negedge reset)//将A1延时1个时钟
begin
	if(!reset) A_d1 <= 1;
	else A_d1 <= A1;
end
always @(posedge clk_delay or negedge reset)//将A1延时2个时钟
begin
	if(!reset) A_d2 <= 1;
	else A_d2 <= A_d1;
end
assign A_Neg = (~A_d1)&A_d2;//若A1有效，则将A1变为延时1个时钟的有效脉冲信号

always @(posedge clk_choose or negedge reset)//将clr延时1个时钟
begin
	if(!reset) clr_d1 <= 1;
	else clr_d1 <= clr;
end
always @(posedge clk_choose or negedge reset)//将clr延时2个时钟
begin
	if(!reset) clr_d2 <= 1;
	else clr_d2 <= clr_d1;
end
assign clr_Neg = (~clr_d2)&clr_d1;//若clr有效，则将clr变为延时1个时钟的有效脉冲信号


always @(posedge clk_delay or negedge reset)//A1有效时，clk_enable为1；clr有效时，clk_enable为0
begin	
	if(!reset) clk_enable <= 0;
	else 
	begin
		if(clr_Neg) clk_enable <= 0;
		else if(A_Neg) clk_enable <= 1;
		else clk_enable <= clk_enable;
	end
end

assign clk_run = clk_choose & clk_enable;//生成clk_run时钟信号


endmodule 