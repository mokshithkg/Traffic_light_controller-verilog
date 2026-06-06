`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2026 07:13:14 PM
// Design Name: 
// Module Name: traffic_light_tb
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

`timescale 1ns/1ps

module traffic_light_tb;

    reg clk;
    reg rst;

    wire [2:0] highway;
    wire [2:0] side;

    //------------------------------------------------
    // Instantiate DUT
    //------------------------------------------------

    traffic_light_controller dut (

        .clk(clk),
        .rst(rst),
        .highway(highway),
        .side(side)

    );

    //------------------------------------------------
    // Clock Generation
    //------------------------------------------------

    always #5 clk = ~clk;

    //------------------------------------------------
    // Initial Block
    //------------------------------------------------

    initial begin

        clk = 0;
        rst = 1;

        #20;

        rst = 0;

        #300;

        $finish;

    end

    //------------------------------------------------
    // Monitor Signals
    //------------------------------------------------

    initial begin

        $monitor("Time=%0t | State Highway=%b | Side=%b",
                  $time, highway, side);

    end

endmodule