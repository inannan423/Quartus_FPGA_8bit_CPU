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
initial
	begin
		data_rom=8'bz;
	end
assign addr1 = addr[4:0];
assign addr2 = addr[15:5];
assign data_ram=(read)? ram[addr2]:8'bzzzzzzzz;
assign data_out=(cpustate != 2'b11)?8'hzz:((|addr[15:5])?data_ram:data_rom);

always @(posedge clk)
 if(write) ram[addr2]<=data_in;

always @(posedge clk)
begin
 if(read)
  data_rom<=memory[addr1];
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