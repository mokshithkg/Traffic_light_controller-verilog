`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2026 07:08:18 PM
// Design Name: 
// Module Name: traffic_light_controller
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


module traffic_light_controller(

    input clk,
    input rst,

    output reg [2:0] highway,
    output reg [2:0] side

);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state, next_state;
reg [3:0] timer;

/////////////////////////////////////////////////
// State Register
/////////////////////////////////////////////////

always @(posedge clk or posedge rst)
begin
    if(rst)
        state <= S0;
    else
        state <= next_state;
end

/////////////////////////////////////////////////
// Timer Logic
/////////////////////////////////////////////////

always @(posedge clk or posedge rst)
begin

    if(rst)
        timer <= 0;

    else begin

        case(state)

            S0:
                if(timer < 9)
                    timer <= timer + 1;
                else
                    timer <= 0;

            S1:
                if(timer < 2)
                    timer <= timer + 1;
                else
                    timer <= 0;

            S2:
                if(timer < 9)
                    timer <= timer + 1;
                else
                    timer <= 0;

            S3:
                if(timer < 2)
                    timer <= timer + 1;
                else
                    timer <= 0;

        endcase

    end
end

/////////////////////////////////////////////////
// Next State Logic
/////////////////////////////////////////////////

always @(*)
begin

    case(state)

        S0:
            if(timer == 9)
                next_state = S1;
            else
                next_state = S0;

        S1:
            if(timer == 2)
                next_state = S2;
            else
                next_state = S1;

        S2:
            if(timer == 9)
                next_state = S3;
            else
                next_state = S2;

        S3:
            if(timer == 2)
                next_state = S0;
            else
                next_state = S3;

        default:
            next_state = S0;

    endcase

end

/////////////////////////////////////////////////
// Output Logic
/////////////////////////////////////////////////

always @(*)
begin

    highway = 3'b000;
    side    = 3'b000;

    case(state)

        S0: begin
            highway = 3'b001;
            side    = 3'b100;
        end

        S1: begin
            highway = 3'b010;
            side    = 3'b100;
        end

        S2: begin
            highway = 3'b100;
            side    = 3'b001;
        end

        S3: begin
            highway = 3'b100;
            side    = 3'b010;
        end

    endcase

end

endmodule
