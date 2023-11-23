`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/11/2023 04:51:56 AM
// Design Name: 
// Module Name: 8_bit_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 

//////////////////////////////////////////////////////////////////////////////////


module eight_bit_counter(
    input clk, //slow clock
    output [7:0] Q //8-bit-output
    );
    logic [7:0] temp=0; // initial counter is set to 0
    always @(posedge clk) // when positive edge of the clock arrives, clock goes up by 1
    begin
    temp= temp + 1;     //value of temp is incremented at every clock edge
    end
    assign Q = temp; 
    
endmodule
