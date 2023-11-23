module ATM(
   input [5:0] switch,
   output [7:0] amount,
   output LED
   );
   
   logic [7:0] bill_amount = 8'b00000000;
   always@(switch)
   begin
        case(switch)
            1:bill_amount=8'b00000001; // 1 rupees    we are sticking to 1,5,10,20,50,100 as we have a 4 digit display and we cannot show more than 4 digit number
            2:bill_amount=8'b00000101; // 5 rupees
            4:bill_amount=8'b00001010; // 10 rupees
            8:bill_amount=8'b00010100; //20 rupees
           16:bill_amount=8'b00110010; //50 rupees
           32:bill_amount=8'b01100100; //100 rupees
           default: bill_amount=8'b00000000; // 0 rupees
        endcase
    end

    assign amount= bill_amount;
    
    //only one switch has to be up at a time, if not then led lights up.
    logic active= 1'b0;
    always@(switch)
    begin
        case(switch)
            0:active=1'b0;   //0 rupees
            1:active=1'b0;   //1 rupees
            2:active=1'b0;   //5 rupees
            4:active=1'b0;   //10 rupees
            8:active=1'b0;   //20 rupees
           16:active=1'b0;   //50 rupees
           32:active=1'b0;   //100 rupees
           // if any of the above cases is not true then default case.
           default:active=1'b1;   //0 rupees    
        endcase
    end
    
    assign LED= active;
endmodule




