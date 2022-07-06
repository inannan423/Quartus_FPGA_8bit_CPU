module rom(addr, read, data);
input[4:0] addr;
input read;
output [7:0]data;
reg [7:0]data;
reg [7:0]memory[31:0];
//assign data=(read)?memory[addr]:8'bzzzzzzzz; 
always @(read or addr)
	if(read)
		data=memory[addr];
//initial
//	begin 	
//			memory[0]=8'b00000001;//ldac T1=14
//			memory[1]=8'b00001110;
//			memory[2]=8'b00000000;
//			memory[3]=8'b00000000;//nop
//			memory[4]=8'b00001000;//add
//			memory[5]=8'b00001010;//inc
//			memory[6]=8'b00000011;//movac
//			memory[7]=8'b00000001;//ldac T2=15
//			memory[8]=8'b00001111;
//			memory[9]=8'b00000000;
//			memory[10]=8'b00001001;//sub AC<-AC-R;
//			memory[11]=8'b00000111;//jpnz T3=16;
//			memory[12]=8'b00010000;
//			memory[13]=8'b00000000;
//			memory[14]=8'b00000100;//04h
//			memory[15]=8'b00001010;//10h 
//			memory[16]=8'b00000010;//stac T4=32 in ram
//			memory[17]=8'b00100000;
//			memory[18]=8'b00000000;	
//			memory[19]=8'b00000100;//movr
//			memory[20]=8'b00000110;//jmpz here z!=0,not jump
//			memory[21]=8'b00001000;
//			memory[22]=8'b01001000;
//			memory[23]=8'b00000001;//ldac T5=32;load ram
//			memory[24]=8'b00100000;
//			memory[25]=8'b00000000;
//			memory[26]=8'b00001111;//not
//			memory[27]=8'b00001100;//and
//			memory[28]=8'b00001011;//clac clear aluout put z=0
//			memory[29]=8'b00000110;//jmpz here z=0,jump to T6=0;
//			memory[30]=8'b00000000;
//			memory[31]=8'b00000000;
//			
//		
//
//			
//	end

endmodule