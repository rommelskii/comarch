module testbench();
    reg clk, rst;
    reg [7:0] bin1_cap, bin2_cap, bin3_cap;
    reg sel1, sel2, sel3;
    wire [7:0] leds;
    wire [6:0] seg1, seg2;
    wire buzzer1, buzzer2, buzzer3;

    SmartWasteManagement uut (
        .clk(clk), .rst(rst),
        .bin1_cap(bin1_cap), .bin2_cap(bin2_cap), .bin3_cap(bin3_cap),
        .sel1(sel1), .sel2(sel2), .sel3(sel3),
        .leds(leds), .seg1(seg1), .seg2(seg2),
        .buzzer1(buzzer1), .buzzer2(buzzer2), .buzzer3(buzzer3)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize
        rst = 1; #20; rst = 0;
        bin1_cap = 0; bin2_cap = 0; bin3_cap = 0;
        sel1 = 0; sel2 = 0; sel3 = 0;

        // Add monitor statements
        $monitor("Time=%0t, bin1_cap=%d, bin2_cap=%d, bin3_cap=%d, sel1=%b, sel2=%b, sel3=%b, leds=%b, seg1=%b, seg2=%b, buzzer1=%b, buzzer2=%b, buzzer3=%b",
                 $time, bin1_cap, bin2_cap, bin3_cap, sel1, sel2, sel3, leds, seg1, seg2, buzzer1, buzzer2, buzzer3);

        // Test Case 1: Select bin1 at 50% (128/255 ≈50%)
        bin1_cap = 128;
        sel1 = 1; #20;
        // LEDs should show 4 levels (00001111)
        // Seven-segment displays "5" and "0"

        // Test Case 2: Select bin3 at 95% (242)
        bin3_cap = 242;
        sel1 = 0; sel3 = 1; #20;
        // LEDs: 11111111, Seven-segment ≈95 (seg1=9, seg2=5)
        // Buzzer3 active

        // Test Case 3: Check buzzer thresholds
        bin1_cap = 230; #20; // Buzzer1 should activate

        $finish;
    end
endmodule