/*组合逻辑控制单元，根据时钟生成为控制信号和内部信号*/
/*
输入：
       din：指令，8位，来自IR；
       clk：时钟信号，1位，上升沿有效；
       rst：复位信号，1位，与cpustate共同组成reset信号；
       cpustate：当前CPU的状态（IN，CHECK，RUN），2位；
       z：零标志，1位，零标志寄存器的输出，如果指令中涉及到z，可加上，否则可去掉；
输出：
      clr：清零控制信号
     自行设计的各个控制信号
*/
//省略号中是自行设计的控制信号，需要自行补充，没用到z的话也可去掉z
module control(din,clk,rst,z,cpustate,......, clr);
input [7:0]din;
input clk;
input rst,z;
input [1:0] cpustate;

//parameter's define
/*-------*/
wire reset;
/*-------*/
//在下方加上自行定义的状态
wire fetch1,fetch2,fetch3,nop1;

//加上自行设计的指令，这里是译码器的输出，所以nop指令经译码器输出后为inop。
//类似地，add指令指令经译码器输出后为iadd；inac指令经译码器输出后为iinac，......
reg inop;

//时钟节拍，8个为一个指令周期，t0-t2分别对应fetch1-fetch3，t3-t7分别对应各指令的执行周期，当然不是所有指令都需要5个节拍的。例如add指令只需要一个t3
reg t0,t1,t2,t3,t4,t5,t6,t7; 

// signals for the counter, 内部信号：clr清零，inc自增
wire clr;
wire inc;
assign reset = rst&(cpustate == 2'b11);
// assign signals for the cunter

//clr信号是每条指令执行完毕后必做的清零，下面赋值语句要修改，需要“或”各指令的最后一个周期
assign clr=nop1;
assign inc=~clr;
	
//generate the control signal using state information
//...
//取公过程
assign fetch1=t0;
assign fetch2=t1;
assign fetch3=t2;
//什么都不做的译码
assign nop1=inop&&t3;//inop表示nop指令，nop1是nop指令的执行周期的第一个状态也是最后一个状态，因为只需要1个节拍t3完成

//以下写出各条指令状态的表达式



//the next grade assign
//以下给出了pcbus的逻辑表达式，写出其他控制信号的逻辑表达式
assign pcbus=fetch1||fetch3;



//the finite state

always@(posedge clk or negedge reset)
begin
if(!reset)
	begin//各指令清零，以下已为nop指令清零，请补充其他指令，为其他指令清零
		inop<=0;
				
	end
else 
begin
	//alus初始化为x，加上将alus初始化为x的语句，后续根据不同指令为alus赋值
	
	if(din[7:4]==0000)//译码处理过程
	begin
		case(din[3:0])
		0:  begin//指令低4位为0，应该是nop指令，因此这里inop的值是1，而其他指令应该清零，请补充为其他指令清零的语句
			inop<=1;
			
			end
		1:  begin
			//指令低4位为0001，应该是ildac指令，因此ildac指令为1，其他指令都应该是0。
			//该指令需要做一个加0运算，详见《示例机的设计Quartus II和使用说明文档》中“ALU的设计”，因此这里要对alus赋值
			//后续各分支类似，只有一条指令为1，其他指令为0，以下分支都给出nop指令的赋值，需要补充其他指令，注意涉及到运算的都要对alus赋值
			inop<=0;
			
			end
		2:  begin
			inop<=0;
			
			end
		3:  begin
			inop<=0;
			
			end
		4:  begin
			inop<=0;
			
			end
		5:  begin
			inop<=0;
			
			end
		6:	begin
			inop<=0;
			
			end
		7:	begin
			inop<=0;
			
			end
		8:	begin
			inop<=0;
			
			end
		9:	begin
			inop<=0;
			
			end
		//如果还有分支，可以继续写，如果没有分支了，写上defuault语句	
		endcase
	end
end
end

/*——————8个节拍t0-t7————*/
always @(posedge clk or negedge reset)
begin
if(!reset) //reset清零
begin
	t0<=1;
	t1<=0;
	t2<=0;
	t3<=0;
	t4<=0;
	t5<=0;
	t6<=0;
	t7<=0;
end
else
begin
	if(inc) //运行
	begin
	t7<=t6;
	t6<=t5;
	t5<=t4;
	t4<=t3;
	t3<=t2;
	t2<=t1;
	t1<=t0;
	t0<=0;
	end
	else if(clr) //清零
	begin
	t0<=1;
	t1<=0;
	t2<=0;
	t3<=0;
	t4<=0;
	t5<=0;
	t6<=0;
	t7<=0;
	end
end

end
/*—————结束—————*/
endmodule
	
		