`timescale 1ns / 1ps

module Decoder(
    input logic[1:0] en,
    output logic[3:0] an //
    );
    
    always @(en) //this is basically a counter that will go from 0 to 3
        begin
        case(en)
        0: an=4'b1110;
        1: an=4'b1101;
        2: an=4'b1011;
        3: an=4'b1111;
        endcase
        end
    
endmodule