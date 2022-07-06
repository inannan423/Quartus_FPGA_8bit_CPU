/*灯光显示单元，通过HEX6-HEX0：7个数码管进行显示*/
/*输入light_clk：light的时钟信号，1位；来自于top.v的分频器clk_div的输出clk_light；
   输入SW_choose：选择快慢；1位；在top.v的端口;
   输入check_in：8位；来自于存储器的check_out，CPU为check状态下的输出;
   输入read——clr：为控制信号，都是1位，来自控制器；
   输入State：CPU的状态，2位；来自CPU_Controller的输出；
   输入MAR：地址；8位，来自cpu.v的输出addr的低8位；用hex0和hex1显示
   输入AC：ac寄存器的结果显示；来自于ac寄存器的输出acdbus；用hex4和hex5显示
   输入R：r寄存器的结果显示；来自于r寄存器的输出rdbus；用hex2和hex3显示
   输入Z：z标志寄存器的结果显示：来自z寄存器的输出；用hex6显示
   输出HEX0-HEX7：为8个数码管
*/
//module light_show(light_clk,SW_choose,check_in,State,MAR,AC,R,Z,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,State_LED,quick_low_led);
module light_show (light_clk,SW_choose,check_in,State,MAR,
		AC,R,Z,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,State_LED,quick_low_led,arload,arinc,
		pcinc,pcload,drload,trload,irload,rload,acload,zload,pcbus,
		drhbus,drlbus,trbus,rbus,acbus,membus,busmem,clr,
		read_led,write_led,arload_led,arinc_led,pcinc_led,pcload_led, 
		drload_led,trload_led,irload_led,rload_led,acload_led,zload_led,
		pcbus_led,drhbus_led,drlbus_led,trbus_led,rbus_led,acbus_led,
		membus_led,busmem_led,clr_led,read,write);

input light_clk;
input SW_choose;
input [7:0] check_in;
input arload,arinc,
		pcinc,pcload,drload,trload,irload,rload,acload,zload,pcbus,
		drhbus,drlbus,trbus,rbus,acbus,membus,busmem,read,write,clr;
input [1:0] State; //状态，LEDG1~LEDG3
input [7:0] MAR; //下一执行指令地址：hex0，1
input [7:0] AC,R; //AC通用寄存器运行结果显示，hex4,5;R通用寄存器结果显示,hex2,3
input Z; //标志寄存器Z的值，hex6

output reg [6:0] HEX0;
output reg [6:0] HEX1;
output reg [6:0] HEX2;
output reg [6:0] HEX3;
output reg [6:0] HEX4;
output reg [6:0] HEX5;
output reg [6:0] HEX6;
output [6:0] HEX7;
output [1:0] State_LED;
output quick_low_led;
output read_led,write_led,arload_led,arinc_led,pcinc_led,pcload_led, 
		drload_led,trload_led,irload_led,rload_led,acload_led,zload_led,
		pcbus_led,drhbus_led,drlbus_led,trbus_led,rbus_led,acbus_led,
		membus_led,busmem_led,clr_led;
		
assign HEX7 = 7'b0111111;
assign State_LED = State; //显示状态灯
assign quick_low_led = SW_choose;//快慢时钟灯
assign read_led=read;
assign write_led=write;
assign arload_led=arload;
assign arinc_led=arinc;
assign pcinc_led=pcinc;
assign pcload_led=pcload;
assign zload_led=zload;
assign pcbus_led=pcbus;
assign drload_led=drload;
assign trload_led=trload;
assign irload_led=irload;
assign rload_led=rload;
assign acload_led=acload;
assign drhbus_led=drhbus;
assign drlbus_led=drlbus;
assign membus_led=membus;
assign busmem_led=busmem;
assign trbus_led=trbus;
assign rbus_led=rbus;
assign acbus_led=acbus;
assign clr_led=clr;
//assign quick_low_led=quick_low;
//always @(posedge light_clk or negedge K6 or posedge STP)
always @(posedge light_clk)
begin

			case(MAR[3:0]) //hex0
				4'd0:HEX0 <= 7'b1000000;
				4'd1:HEX0 <= 7'b1111001;
				4'd2:HEX0 <= 7'b0100100;
				4'd3:HEX0 <= 7'b0110000;
				4'd4:HEX0 <= 7'b0011001;
				4'd5:HEX0 <= 7'b0010010;
				4'd6:HEX0 <= 7'b0000010;
				4'd7:HEX0 <= 7'b1111000;
				4'd8:HEX0 <= 7'b0000000;
				4'd9:HEX0 <= 7'b0010000;
				4'd10:HEX0 <= 7'b0011000;//a
				4'd11:HEX0 <= 7'b0000011;//b
				4'd12:HEX0 <= 7'b0100111;//c
				4'd13:HEX0 <= 7'b0100001;//d
				4'd14:HEX0 <= 7'b0000100;//e
				4'd15:HEX0 <= 7'b0001111;//f
				default:HEX0 <= 7'b0111111;
			endcase
			
			case(MAR[7:4]) //hex1
				4'd0:HEX1 <= 7'b1000000;
				4'd1:HEX1 <= 7'b1111001;
				4'd2:HEX1 <= 7'b0100100;
				4'd3:HEX1 <= 7'b0110000;
				4'd4:HEX1 <= 7'b0011001;
				4'd5:HEX1 <= 7'b0010010;
				4'd6:HEX1 <= 7'b0000010;
				4'd7:HEX1 <= 7'b1111000;
				4'd8:HEX1 <= 7'b0000000;
				4'd9:HEX1 <= 7'b0010000;
				4'd10:HEX1 <= 7'b0011000;//a
				4'd11:HEX1 <= 7'b0000011;//b
				4'd12:HEX1 <= 7'b0100111;//c
				4'd13:HEX1 <= 7'b0100001;//d
				4'd14:HEX1 <= 7'b0000100;//e
				4'd15:HEX1 <= 7'b0001111;//f
				default:HEX1 <= 7'b0111111;
			endcase
			
			case(Z) //hex6
				4'd0:HEX6 <= 7'b1000000;
				4'd1:HEX6 <= 7'b1111001;
				default:HEX6 <= 7'b0111111;
			endcase
			
			case(AC[3:0]) //hex4
				4'd0:HEX4 <= 7'b1000000;
				4'd1:HEX4 <= 7'b1111001;
				4'd2:HEX4 <= 7'b0100100;
				4'd3:HEX4 <= 7'b0110000;
				4'd4:HEX4 <= 7'b0011001;
				4'd5:HEX4 <= 7'b0010010;
				4'd6:HEX4 <= 7'b0000010;
				4'd7:HEX4 <= 7'b1111000;
				4'd8:HEX4 <= 7'b0000000;
				4'd9:HEX4 <= 7'b0010000;
				4'd10:HEX4 <= 7'b0011000;//a
				4'd11:HEX4 <= 7'b0000011;//b
				4'd12:HEX4 <= 7'b0100111;//c
				4'd13:HEX4 <= 7'b0100001;//d
				4'd14:HEX4 <= 7'b0000100;//e
				4'd15:HEX4 <= 7'b0001111;//f
				default:HEX4 <= 7'b0111111;
			endcase
			
			case(AC[7:4]) //hex5
				4'd0:HEX5 <= 7'b1000000;
				4'd1:HEX5 <= 7'b1111001;
				4'd2:HEX5 <= 7'b0100100;
				4'd3:HEX5 <= 7'b0110000;
				4'd4:HEX5 <= 7'b0011001;
				4'd5:HEX5 <= 7'b0010010;
				4'd6:HEX5 <= 7'b0000010;
				4'd7:HEX5 <= 7'b1111000;
				4'd8:HEX5 <= 7'b0000000;
				4'd9:HEX5 <= 7'b0010000;
				4'd10:HEX5 <= 7'b0011000;//a
				4'd11:HEX5 <= 7'b0000011;//b
				4'd12:HEX5 <= 7'b0100111;//c
				4'd13:HEX5 <= 7'b0100001;//d
				4'd14:HEX5 <= 7'b0000100;//e
				4'd15:HEX5 <= 7'b0001111;//f
				default:HEX5 <= 7'b0111111;
			endcase
			
			case(R[3:0]) //hex2
				4'd0:HEX2 <= 7'b1000000;
				4'd1:HEX2 <= 7'b1111001;
				4'd2:HEX2 <= 7'b0100100;
				4'd3:HEX2 <= 7'b0110000;
				4'd4:HEX2 <= 7'b0011001;
				4'd5:HEX2 <= 7'b0010010;
				4'd6:HEX2 <= 7'b0000010;
				4'd7:HEX2 <= 7'b1111000;
				4'd8:HEX2 <= 7'b0000000;
				4'd9:HEX2 <= 7'b0010000;
				4'd10:HEX2 <= 7'b0011000;//a
				4'd11:HEX2 <= 7'b0000011;//b
				4'd12:HEX2 <= 7'b0100111;//c
				4'd13:HEX2 <= 7'b0100001;//d
				4'd14:HEX2 <= 7'b0000100;//e
				4'd15:HEX2 <= 7'b0001111;//f
				default:HEX2 <= 7'b0111111;
			endcase
			
			case(R[7:4]) //hex3
				4'd0:HEX3 <= 7'b1000000;
				4'd1:HEX3 <= 7'b1111001;
				4'd2:HEX3 <= 7'b0100100;
				4'd3:HEX3 <= 7'b0110000;
				4'd4:HEX3 <= 7'b0011001;
				4'd5:HEX3 <= 7'b0010010;
				4'd6:HEX3 <= 7'b0000010;
				4'd7:HEX3 <= 7'b1111000;
				4'd8:HEX3 <= 7'b0000000;
				4'd9:HEX3 <= 7'b0010000;
				4'd10:HEX3 <= 7'b0011000;//a
				4'd11:HEX3 <= 7'b0000011;//b
				4'd12:HEX3 <= 7'b0100111;//c
				4'd13:HEX3 <= 7'b0100001;//d
				4'd14:HEX3 <= 7'b0000100;//e
				4'd15:HEX3 <= 7'b0001111;//f
				default:HEX3 <= 7'b0111111;
			endcase	
end

assign State_LED = State; //显示状态灯
assign quick_low_led = SW_choose;//快慢时钟灯

endmodule

