`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2023 12:30:02
// Design Name: 
// Module Name: Counter
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


module counter(
input logic clk,
input logic reset,
input logic increment,     //money has been deopsited
input logic decrement,     //money has been withdrawn
input logic [7:0] amount,    //amount selected via dropswitch
output logic [7:0] count,    //total money (previously)
output logic LED2,           //to indicate max amount has reach
output logic LED3);          //to indicate bank balance is 0, no withdrawal possible

logic[7:0] current_count =0;  //will do the maths here, addition if deposit, subtraction if withdrawal

//computing the balance in account after deposit or withdrawal
//count is the amount you had(previously)
//amount is the new amount selected using the drop switch


// computing the balance in account after deposit and withdrawal
//for example, if balance (count) is 0 and 5 bill is deposited (amount), and deposit signal is triggered
// the current count will display 0 + 5 = 5. 

always_ff @(posedge clk or posedge reset) begin //sequential always block as it needs to keep track of count signal
    if(reset)
        current_count <=0;  //reset count to 0
    else if(increment && (count + amount) > count) //else if(increment)
        current_count<=count+amount;  //increased count by amount
    else if(decrement && amount <=count) 
        current_count<=count-amount; // decrement count by amount
    else
        current_count <=count;  //if no input, count remains the same
end
    assign count= current_count;
    
logic set2=0;

//determine LED2,exceeds maximum account value, i,e 255

always_ff @(posedge clk or posedge reset) begin //always@(posedge clk)begin
    if(reset)
        set2<=0; //reset count to 0
    else if(increment && (count + amount) > count) //else if(increment)
        set2<=0;
    else if(increment && amount <=count) 
        set2<=0;
    else if(increment && (count + amount) < count) 
        set2<=1;
    
    else
        set2<=LED2;
end
    assign LED2=set2;
    
logic set3=0;

// determine LED3, don't have enough money to withdraw, insufficien balance in the account

always_ff @(posedge clk or posedge reset) begin //always@(posedge clk)begin
    if(reset)
        set3<=0; //reset count to 0
    else if(increment && (count + amount) > count) //else if(increment)
        set3<=0;
    else if(increment && amount <=count) 
        set3<=0;
    else if(increment && amount > count)
        set3<=1;
    else
        set3<=LED3;
end
    assign LED3=set3;
    
endmodule
