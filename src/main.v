`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:50:33 02/20/2025 
// Design Name: 
// Module Name:    test 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module test(
	 input Clk,
	 input wire [2:0] CHOICE_button,
	 output reg [7:0] STATUS_led,
	 output reg [7:0] STATUS_7seg_ones,
	 output reg [7:0] STATUS_7seg_tens
    );

reg delayed_clk;
clock clk(Clk, delayed_clk);

reg [3:0] display_ones; 

	//insert logic display_ones => 7seg

reg [7:0] STATUS_LED_bin1;
reg [7:0] STATUS_LED_bin2;
reg [7:0] STATUS_LED_bin3; 
reg [7:0] SENSOR_bin1;
reg [7:0] SENSOR_bin2;
reg [7:0] SENSOR_bin3; 
reg [3:0] VALUE_bin1;
reg [3:0] VALUE_bin2;
reg [3:0] VALUE_bin3; 


/*
sensor_readings(
	delayed_clk,
	SENSOR_bin1,
	STATUS_bin1,
	VALUE_bin1,
	SENSOR_bin2,
	STATUS_bin2,
	VALUE_bin1,	
	SENSOR_bin3,
	STATUS_bin3,
	VALUE_bin1,
)
*/	

always @(posedge delayed_clk) begin
	case (CHOICE_button) begin
		001: 
	end
	
end


endmodule
