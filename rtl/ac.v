/*AC通用寄存器，存储第一个操作数*/
module ac(din, busin, clk, rst, acload, busac, dout);
//din:从alu来的数据
//busin:从总线来的数据
input [7:0] din; 
input [7:0] busin;
input clk,rst,acload,busac;
output reg [7:0] dout;
always @(posedge clk or negedge rst) 
begin
    if (!rst)
        dout <= 0;
    else if (acload)
        dout <= din;
    else if (busac)
        dout <= busin;
end

endmodule