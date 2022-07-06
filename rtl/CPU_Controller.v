//CPU的状态
/*输入SW1：模拟按键SW17；1位，拨到上方为1，拨到下方为0；
   输入SW2：模拟按键SW16；1位，拨到上方为1，拨到下方为0；
   输出CPU_state：2位，SW1SW2=01时输入(IN状态)，SW1SW2=10时检查（CHECK状态），SW1SW2=11时运行（RUN状态）；
*/

module CPU_Controller(SW1,SW2,CPU_state);

input SW1,SW2;
output [1:0] CPU_state;

assign CPU_state = {SW2,SW1};

endmodule
