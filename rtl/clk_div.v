/*分频程序*/

module clk_div(clk,reset,symbol,div_clk);

input clk;
input reset;
input [31:0] symbol;

output reg div_clk;

reg [31:0] count;

always @(posedge clk)
begin
	
		if (!reset)
			begin
				div_clk <= 1;
				count <= 0;
			end
		else 
			begin
				if(count == symbol)
					begin 
						div_clk <= ~div_clk;
						count <= 0;
					end
				else 
					count <= count + 1'b1;
			end
end
	
endmodule	