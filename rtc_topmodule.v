`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahesh Bhat K
// 
// Create Date: 
// Design Name: 
// Module Name: rtc_topmodule
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


module rtc_topmodule(clk,rst,hrm,hrl,min_m,min_l,sec_m,sec_l);
input clk;  //1Hz Clock
input rst; //active low reset
output  [6:0] hrm;
output  [6:0] hrl;
output  [6:0] min_m;
output  [6:0] min_l;
output  [6:0] sec_m;
output  [6:0] sec_l;

wire clk_1Hz;
clock_div clockdivider(clk,rst,clk_1Hz);
rtc realtimeclock(clk,rst,hrm,hrl,min_m,min_l,sec_m,sec_l); 
//here for rtc simulation sending clk itself because simulation runs for 1000ns maximum;
//for board implementation send below clk_1Hz instead of clk to rtc module

endmodule
