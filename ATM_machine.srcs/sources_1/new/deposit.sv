`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2023 09:01:11 PM
// Design Name: 
// Module Name: Deposit
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

module Deposit(
    input logic clk,
    input logic reset,
    input logic Up_Button,  // Deposit money
    output logic count_up   // Triggers increment signal
);

    typedef enum logic [1:0] { 
        S00 = 2'b00,
        FLAG = 2'b01
    } state_t;                                      //declaring two transition states

    state_t current_state, next_state;
    logic set_flag;

    //
    // Next state sequential logic
    //
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= S00;
        end else begin
            current_state <= next_state;
        end
    end

    //
    // Next state combinational logic
    //
    always_comb begin
        case (current_state)
            S00: begin                               //if current state is s00 then this block
                if (Up_Button) begin
                    next_state = FLAG;
                end else begin
                    next_state = S00;
                end
            end
            FLAG: begin                              //if current state is flag then this block
                next_state = S00;
            end
            default: begin                            //default case
                next_state = S00;
            end
        endcase
    end

    //
    // Combinational output logic for each state
    //
    always_comb begin
        case (current_state)
            S00: begin
                set_flag = 1'b0;
            end
            FLAG: begin
                set_flag = 1'b1;
            end
            default: begin
                set_flag = 1'b0;
            end
        endcase
    end

    //
    // Output assignment
    //
    assign count_up = set_flag;

endmodule
