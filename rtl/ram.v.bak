/*存储器，完成IN状态的输入，CHECK状态的检查，RUN状态的写入*/
/*输入clk：时钟信号，进行时序控制；1位，来自分频程序clk_div的输出；只在IN和CHECK状态时，其上升沿有效；
   输入data_in：数据输入；8位，来自于cpu模块的data_out，即cpu写入存储器的数据；
   输入addr：地址；16位，来源于地址寄存器ar模块的输出；
   输入A1：为按钮key1，按下时（置0）有效，在IN状态下进行存储操作，在CHECK状态下进行检查操作；
   输入reset：为清零信号，1位，为零时有效，将内部计数器清零，将内部延时信号置1；
   输入read：为控制信号，1位，1为有效，读出存储器ram[addr2]或memory[addr1]的值；
   输入write：为控制信号，1位，1为有效，将data_in写入ram[addr2]；
   输入cpustate：cpu的状态，2位，01表示输入（IN状态），10表示检查（CHECK状态），11表示运行（RUN状态）
   输入D：由实验开发板上SW7-SW0拨动开关的值组成，IN状态下按下A1按钮时进行存储操作，将指令存在内部寄存器memory中；
   输出data_out：8位，只在RUN状态下有效，其余状态时为高阻态，有效时如果addr[15:5]=0（即当前地址在0-31）则输出memeory[addr1]的内容，如果addr[15:5]!=0，则输出ram[addr2] 的内容；
   输出check_out：8位，只在CHECK状态下有效，其余状态为高阻态，有效时输出当前地址cnt在memory存储的指令。
*/
module ram(clk,data_in,addr,A1,reset,read,write,cpustate,D,data_out,check_out);

input clk;
input [7:0] data_in;
input [15:0] addr;
input A1;
input reset;
input read,write;
input [1:0] cpustate;
input [7:0] D;//用于IN模式的开关输入
output [7:0] data_out;
output [7:0] check_out;//CHECK状态下的输出

/****in和check状态使用*****/
reg [7:0] memory [31:0];
reg A_d1,A_d2;
reg [1023:0] cnt;
wire A_Neg;
/*******run状态使用********/
reg [7:0] data_rom;
wire [4:0] addr1;
wire [10:0] addr2;
wire [7:0] data_ram;
reg [7:0] ram [1023:0];
/*********/

assign addr1 = addr[4:0];
assign addr2 = addr[15:5];
assign data_ram=(read)? ram[addr2]:8'bzzzzzzzz;
assign data_out=(cpustate != 2'b11)?8'hzz:((|addr[15:5])?data_ram:data_rom);

always @(write or data_in)
	if(write) ram[addr2]<=data_in;

always @(read or addr1)
begin
	if(read)
		data_rom=memory[addr1];
end

/*-------------IN模式下的指令存储和CHECK模式下的指令检查--------------*/

always @(posedge clk or negedge reset) //将A1按钮延时1个时钟
begin
	if(!reset) A_d1 <= 1;
	else A_d1 <= A1;
end
always @(posedge clk or negedge reset) //将A1按钮延时2个时钟
begin
	if(!reset) A_d2 <= 1;
	else A_d2 <= A_d1;
end
assign A_Neg = (~A_d1)&A_d2; //若A1按钮按下，则将其变为延时1个时钟的脉冲信号
 
assign check_out = (cpustate==2'b10)?memory[cnt]:8'hzz; //check输出

always @(posedge clk or negedge reset)
begin
	if(!reset) cnt=0;
	else 
	begin
		if(cpustate == 2'b01 && A_Neg==1)//IN
		begin
			memory[cnt] = D;
			cnt = cnt+1024'd1;
		end	
		else if(cpustate == 2'b10 && A_Neg==1) cnt = cnt+1024'd1;//CHECK		
		else cnt = cnt;//保持
	end
end
	
endmodule
