`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahesh Bhat K
// 
// Create Date: 
// Design Name: 
// Module Name: clock_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_div(clkin,rstn,clk_1hz);
input rstn; //active low reset
input clkin; //clock input
output clk_1hz; //1Hz clock output

parameter FREQ=50e+6; //50MHz input clock....Change according to FPGA board
parameter COUNT=FREQ/2;

reg [31:0]i;
reg tc;

assign clk_1hz=tc;

always @(negedge rstn or posedge clkin) 
begin
	if (rstn == 0) begin
		i = 0;
		tc=0;
	               end
	else 
			if (i == COUNT-1) begin
				 i = 0;
				 tc= ~tc;
			                  end
			else
				 i = i + 1;
end
endmodule
