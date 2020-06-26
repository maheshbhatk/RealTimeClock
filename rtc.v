`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mahesh Bhat K
// 
// Create Date: 
// Design Name: 
// Module Name: rtc
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


module rtc(clk,rstn,hrm,hrl,min_m,min_l,sec_m,sec_l);
input clk;  //1Hz Clock for real time
input rstn; //active low reset
output reg [6:0] hrm;
output reg [6:0] hrl;
output reg [6:0] min_m;
output reg [6:0] min_l;
output reg [6:0] sec_m;
output reg [6:0] sec_l;

reg [5:0] tmp_hour, tmp_minute, tmp_second; 
// counter for clock hour, minute and second
reg [1:0] c_hour1; 
/* The most significant hour digit of the clock. */ 
reg [3:0] c_hour0;
/* The least significant hour digit of the clock. */ 
reg [3:0] c_min1;
/* The most significant minute digit of the clock .*/ 
reg [3:0] c_min0;
/* The least significant minute digit of the clock.*/ 
reg [3:0] c_sec1;
/* The most significant second digit of the clock.*/ 
reg [3:0] c_sec0;
/* The least significant minute digit of the clock.*/ 

always @(posedge clk or negedge rstn)
begin
    if(rstn==0)
       begin     tmp_hour<=0;
                 tmp_minute<=0;
                 tmp_second<=0;
                 c_hour1<=0;
                 c_hour0<=0;
                 c_min1<=0;
                 c_min0<=0;
                 c_sec1<=0;
                 c_sec0<=0;
       end
    else 
        begin
        tmp_second <= tmp_second + 1;
        if(tmp_second >=59) begin // second > 59 then minute increases
            tmp_minute <= tmp_minute + 1;
            tmp_second <= 0;end
        if(tmp_minute >=59 && tmp_second>=59) begin // minute > 59 then hour increases
            tmp_minute <= 0;
            tmp_hour <= tmp_hour + 1;end
        if(tmp_hour >= 23 && tmp_minute>=59 && tmp_second>=59) begin // hour > 24 then set hour to 0
            tmp_hour <= 0;end
        end
end

/*
function [3:0] mod_10;          //mod10 function
input [5:0] number;
begin
mod_10 = (number >=50) ? 5 : ((number >= 40)? 4 :((number >= 30)? 3 :((number >= 20)? 2 :((number >= 10)? 1 :0))));
end
endfunction
*/

always @(*) 
begin
 if(tmp_hour>=20) begin
    c_hour1 = 2;  end
 else begin
    if(tmp_hour >=10) 
        c_hour1  = 1;
    else
        c_hour1 = 0;
    end
 c_hour0 = tmp_hour - c_hour1*10; 
 c_min1 = (tmp_minute >=50) ? 5 : ((tmp_minute >= 40)? 4 :((tmp_minute >= 30)? 3 :((tmp_minute >= 20)? 2 :((tmp_minute >= 10)? 1 :0))));
 // can call the mod10 function as well ----c_min1=mod_10(tmp_minute)
 c_min0 = tmp_minute - c_min1*10;
 c_sec1 = (tmp_second >=50) ? 5 : ((tmp_second >= 40)? 4 :((tmp_second >= 30)? 3 :((tmp_second >= 20)? 2 :((tmp_second >= 10)? 1 :0))));
 // can call the mod10 function as well ----c_sec1=mod_10(tmp_second)
 c_sec0 = tmp_second - c_sec1*10; 
 end
 
always @(c_hour1 or c_hour0 or c_min1 or c_min0 or c_sec1 or c_sec0)
begin 
 case(c_hour1)
    2'b00: hrm=7'b1111110;
    2'b01: hrm=7'b0110000;
    2'b10: hrm=7'b1101101;
    2'b11: hrm=7'b0000000;
    default: hrm=7'b0000000;
  endcase
  
 case(c_hour0)
   4'b0000 : begin hrl = 7'b1111110; end
   4'b0001 : begin hrl = 7'b0110000; end
   4'b0010 : begin hrl = 7'b1101101; end
   4'b0011 : begin hrl = 7'b1111001; end
   4'b0100 : begin hrl = 7'b0110011; end
   4'b0101 : begin hrl = 7'b1011011; end
   4'b0110 : begin hrl = 7'b1011111; end
   4'b0111 : begin hrl = 7'b1110000; end
   4'b1000 : begin hrl = 7'b1111111; end
   4'b1001 : begin hrl = 7'b1110011; end
   default : begin hrl = 7'b0000000; end
   endcase
  
  case(c_min1)
   4'b0000 : begin min_m = 7'b1111110; end
   4'b0001 : begin min_m = 7'b0110000; end
   4'b0010 : begin min_m = 7'b1101101; end
   4'b0011 : begin min_m = 7'b1111001; end
   4'b0100 : begin min_m = 7'b0110011; end
   4'b0101 : begin min_m = 7'b1011011; end
   4'b0110 : begin min_m = 7'b1011111; end
   4'b0111 : begin min_m = 7'b1110000; end
   4'b1000 : begin min_m = 7'b1111111; end
   4'b1001 : begin min_m = 7'b1110011; end
   default : begin min_m = 7'b0000000; end
   endcase
  
  case(c_min0)
   4'b0000 : begin min_l = 7'b1111110; end
   4'b0001 : begin min_l = 7'b0110000; end
   4'b0010 : begin min_l = 7'b1101101; end
   4'b0011 : begin min_l = 7'b1111001; end
   4'b0100 : begin min_l = 7'b0110011; end
   4'b0101 : begin min_l = 7'b1011011; end
   4'b0110 : begin min_l = 7'b1011111; end
   4'b0111 : begin min_l = 7'b1110000; end
   4'b1000 : begin min_l = 7'b1111111; end
   4'b1001 : begin min_l = 7'b1110011; end
   default : begin min_l = 7'b0000000; end
   endcase
  
  case(c_sec1)
   4'b0000 : begin sec_m = 7'b1111110; end
   4'b0001 : begin sec_m = 7'b0110000; end
   4'b0010 : begin sec_m = 7'b1101101; end
   4'b0011 : begin sec_m = 7'b1111001; end
   4'b0100 : begin sec_m = 7'b0110011; end
   4'b0101 : begin sec_m = 7'b1011011; end
   4'b0110 : begin sec_m = 7'b1011111; end
   4'b0111 : begin sec_m = 7'b1110000; end
   4'b1000 : begin sec_m = 7'b1111111; end
   4'b1001 : begin sec_m = 7'b1110011; end
   default : begin sec_m = 7'b0000000; end
   endcase
  
  case(c_sec0)
   4'b0000 : begin sec_l = 7'b1111110; end
   4'b0001 : begin sec_l = 7'b0110000; end
   4'b0010 : begin sec_l = 7'b1101101; end
   4'b0011 : begin sec_l = 7'b1111001; end
   4'b0100 : begin sec_l = 7'b0110011; end
   4'b0101 : begin sec_l = 7'b1011011; end
   4'b0110 : begin sec_l = 7'b1011111; end
   4'b0111 : begin sec_l = 7'b1110000; end
   4'b1000 : begin sec_l = 7'b1111111; end
   4'b1001 : begin sec_l = 7'b1110011; end
   default : begin sec_l = 7'b0000000; end
  endcase
end
endmodule
