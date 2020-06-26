`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahesh Bhat K
// 
// Create Date:
// Design Name: 
// Module Name: rtc_topmodule_tb
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


module rtc_topmodule_tb( );
reg clk;
reg rst;
wire [6:0]hrm;
wire [6:0]hrl;
wire [6:0]min_m;
wire [6:0]min_l;
wire [6:0]sec_m;
wire [6:0]sec_l;

rtc_topmodule rtc1(clk,rst,hrm,hrl,min_m,min_l,sec_m,sec_l);
initial
clk=1'b0;
always
#2 clk=~clk;
initial
begin
rst=1'b0;
#5 rst=1'b1;
end
endmodule
