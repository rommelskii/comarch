module SmartWasteManagement (
    input clk,
    input rst,
    input [7:0] bin1_cap, bin2_cap, bin3_cap,
    input sel1, sel2, sel3,
    output reg [7:0] leds,
    output reg [6:0] seg1, seg2,
    output buzzer1, buzzer2, buzzer3
);

// Select the current bin based on priority (sel1 > sel2 > sel3)
reg [7:0] selected_cap;
always @(*) begin
    if (sel1)       selected_cap = bin1_cap;
    else if (sel2)  selected_cap = bin2_cap;
    else if (sel3)  selected_cap = bin3_cap;
    else            selected_cap = 8'b0;
end

// LED Level Calculation (8 levels)
always @(*) begin
  if (selected_cap >= 224 && selected_cap <= 255) begin
    leds = 8'b11111111; // 87.5-100%
  end else if (selected_cap >= 192 && selected_cap <= 223) begin
    leds = 8'b01111111;
  end else if (selected_cap >= 160 && selected_cap <= 191) begin
    leds = 8'b00111111;
  end else if (selected_cap >= 128 && selected_cap <= 159) begin
    leds = 8'b00011111;
  end else if (selected_cap >= 96 && selected_cap <= 127) begin
    leds = 8'b00001111;
  end else if (selected_cap >= 64 && selected_cap <= 95) begin
    leds = 8'b00000111;
  end else if (selected_cap >= 32 && selected_cap <= 63) begin
    leds = 8'b00000011;
  end else if (selected_cap >= 0 && selected_cap <= 31) begin
    leds = 8'b00000001;
  end else begin
    leds = 8'b00000000;
  end
end
// Convert capacity to percentage (00-99)
wire [7:0] percent = (selected_cap * 100) >> 8; // Approximate %

// Seven-Segment Display
reg [3:0] tens, units;
always @(*) begin
    tens = percent / 10;
    units = percent % 10;
    
    // Common cathode 7-segment encoding
    case(tens)
        0: seg1 = 7'b0111111;
        1: seg1 = 7'b0000110;
        2: seg1 = 7'b1011011;
        3: seg1 = 7'b1001111;
        4: seg1 = 7'b1100110;
        5: seg1 = 7'b1101101;
        6: seg1 = 7'b1111101;
        7: seg1 = 7'b0000111;
        8: seg1 = 7'b1111111;
        9: seg1 = 7'b1101111;
        default: seg1 = 7'b0000000;
    endcase
    
    case(units)
        0: seg2 = 7'b0111111;
        1: seg2 = 7'b0000110;
        2: seg2 = 7'b1011011;
        3: seg2 = 7'b1001111;
        4: seg2 = 7'b1100110;
        5: seg2 = 7'b1101101;
        6: seg2 = 7'b1111101;
        7: seg2 = 7'b0000111;
        8: seg2 = 7'b1111111;
        9: seg2 = 7'b1101111;
        default: seg2 = 7'b0000000;
    endcase
end

// Buzzers (activate at >=90%)
assign buzzer1 = (bin1_cap >= 230) ? 1'b1 : 1'b0;
assign buzzer2 = (bin2_cap >= 230) ? 1'b1 : 1'b0;
assign buzzer3 = (bin3_cap >= 230) ? 1'b1 : 1'b0;

endmodule