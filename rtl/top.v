//the relatively complex cpu 
//design by cgy,2020.11
//modify by zhy,2021.12
//实例化，将分频模块，cpu模块,存储器模块,显示模块连接到一起。

module top(clk,rst,A1,SW_choose,SW1,SW2,D,addr,rambus,data,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,acdbus,rdbus,cpustate_led,check_out,quick_low_led,read_led,write_led,arload_led,arinc_led,pcinc_led,pcload_led,drload_led,trload_led,irload_led,rload_led,acload_led,zload_led,pcbus_led,drhbus_led,drlbus_led,trbus_led,rbus_led,acbus_led,membus_led,busmem_led,clr_led);
input clk, rst;
input A1;
input SW_choose,SW1,SW2;
input [7:0] D;

output[15:0]addr;
output [7:0]rambus;
output [7:0] data;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7;
output [7:0] acdbus;//AC通用寄存器的输出
output [7:0] rdbus;//R通用寄存器的输出
output [1:0] cpustate_led;
output [7:0] check_out;
output quick_low_led;
output read_led,write_led,arload_led,arinc_led,pcinc_led,pcload_led,drload_led,trload_led,irload_led,rload_led,acload_led,zload_led,pcbus_led,drhbus_led,drlbus_led,trbus_led,rbus_led,acbus_led,membus_led,busmem_led,clr_led;
wire Z;
wire read,write,arload,arinc,pcinc,pcload,drload,trload,irload,rload,acload,zload,pcbus,drhbus,drlbus,trbus,rbus,acbus,membus,busmem,clr;
wire clk_quick,clk_slow,clk_delay,clk_mem,clk_light;
wire [1:0] cpustate;

/*----------分频程序---------------*/
//综合用
clk_div quick(.clk(clk),.reset(rst),.symbol(32'd16384000),.div_clk(clk_quick));
clk_div slow(.clk(clk),.reset(rst),.symbol(32'd49152000),.div_clk(clk_slow));
clk_div delay(.clk(clk),.reset(rst),.symbol(32'd2048000),.div_clk(clk_delay));
clk_div mem(.clk(clk),.reset(rst),.symbol(32'd2048000),.div_clk(clk_mem));
clk_div light(.clk(clk),.reset(rst),.symbol(32'd2048000),.div_clk(clk_light));
//仿真用
/*
clk_div quick(.clk(clk),.reset(rst),.symbol(32'd3),.div_clk(clk_quick));
clk_div slow(.clk(clk),.reset(rst),.symbol(32'd6),.div_clk(clk_slow));
clk_div delay(.clk(clk),.reset(rst),.symbol(32'd1),.div_clk(clk_delay));
clk_div mem(.clk(clk),.reset(rst),.symbol(32'd3),.div_clk(clk_mem));
clk_div light(.clk(clk),.reset(rst),.symbol(32'd3),.div_clk(clk_light));
*/
/*-------------------------------*/

//CPU_Controller(SW1,SW2,CPU_state);CPU_Controller实例化
CPU_Controller controller(.SW1(SW1),.SW2(SW2),.CPU_state(cpustate));

//补充cpu实例化的语句
cpu mcpu(.data_in(rambus),.clk_quick(clk_quick),.clk_slow(clk_slow),.clk_delay(clk_delay),.zout(Z),
	.rst(rst),.SW_choose(SW_choose),.A1(A1),.cpustate(cpustate),.addr(addr),.data_out(data),.acdbus(acdbus),
	.rdbus(rdbus),.read(read),.write(write),.arload(arload),.arinc(arinc),.trload(trload),.trbus(trbus),
	.rload(rload),.rbus(rbus),.acbus(acbus), .pcload(pcload), .pcinc(pcinc),.pcbus(pcbus),.drdbus(drdbus),
	.membus(membus),.busmem(busmem), .drload(drload),.drlbus(drlbus),.drhbus(drhbus), .acload(acload),
	.bus(dbus),.irout(irout), .irload(irload),.zload(zload),.clr(clr));
//cpu mcpu(.din(ram),.clk_quick(clk_quick),.clk_slow(clk_slow),.clk_delay(clk_delay),.rst(rst),.SW_choose(SW_choose),.A1(A1),.cpustate(cpustate),.ac(result),.addr(addr),.read(read),.arload(arload), .pcload(pcload), .pcinc(pcinc),.pcbus(pcbus),.drbus(drbus),.membus(membus), .drload(drload), .acload(acload), .acinc(acinc), .alusel(alusel), .irload(irload), .clr(clr));

//ram(clk,data_in,addr,A1,reset,read,write,cpustate,D,data_out,check_out);ram实例化
ram mm(.clk(clk_mem),.data_in(data),.addr(addr),.A1(A1),.reset(rst),.read(read),.write(write),
		 .cpustate(cpustate),.D(D),.data_out(rambus),.check_out(check_out));


//light_show(light_clk,SW_choose,check_in,read,write,arload,arinc,pcinc,pcload,drload,trload,irload,rload,acload,zload,pcbus,drhbus,drlbus,trbus,rbus,acbus,membus,busmem,clr,State,MAR,AC,R,Z,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,State_LED,quick_low_led,read_led,write_led,arload_led,arinc_led,pcinc_led,pcload_led,drload_led,trload_led,irload_led,rload_led,acload_led,zload_led,pcbus_led,drhbus_led,drlbus_led,trbus_led,rbus_led,acbus_led,membus_led,busmem_led,clr_led);
//light_show实例化
//light_show(light_clk,SW_choose,check_in,read,write,arload,arinc,pcinc,pcload,drload,trload,irload,rload,acload,zload,pcbus,drhbus,drlbus,trbus,rbus,acbus,membus,busmem,clr,State,MAR,AC,R,Z,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,HEX6,HEX7,State_LED,quick_low_led,read_led,write_led,arload_led,arinc_led,pcinc_led,pcload_led,drload_led,trload_led,irload_led,rload_led,acload_led,zload_led,pcbus_led,drhbus_led,drlbus_led,trbus_led,rbus_led,acbus_led,membus_led,busmem_led,clr_led);
//light_show实例化
light_show show(.light_clk(clk_light),.SW_choose(SW_choose),.check_in(check_out),.State(cpustate),.MAR(addr[7:0]),
  .AC(acdbus),.R(rdbus),.Z(Z),.HEX0(HEX0),.HEX1(HEX1),.HEX2(HEX2),.HEX3(HEX3),.HEX4(HEX4),.HEX5(HEX5),.HEX6(HEX6),
  .HEX7(HEX7),.State_LED(cpustate_led),.quick_low_led(quick_low_led), .arload(arload), .arinc(arinc),
  .pcinc(pcinc),.pcload(pcload),.drload(drload),.trload(trload),.irload(irload),.rload(rload),.acload(acload),.zload(zload),.pcbus(pcbus),
  .drhbus(drhbus),.drlbus(drlbus),.trbus(trbus),.rbus(rbus),.acbus(acbus),.membus(membus),.busmem(busmen),.clr(clr),
  .read_led(read_led),.write_led(write_led),.arload_led(arload_led),.arinc_led(arinc_led),.pcinc_led(pcinc_led),.pcload_led(pcload_led), 
  .drload_led(drload_led),.trload_led(trload_led),.irload_led(irload_led),.rload_led(rload_led),.acload_led(acload_led),.zload_led(zload_led),
  .pcbus_led(pcbus_led),.drhbus_led(drhbus_led),.drlbus_led(drlbus_led),.trbus_led(trbus_led),.rbus_led(rbus_led),.acbus_led(acbus_led),
  .membus_led(membus_led),.busmem_led(busmem_led),.clr_led(clr_led),.read(read),.write(write));

endmodule

