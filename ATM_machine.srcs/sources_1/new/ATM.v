module ATM(
   input [5:0] switch,
   output [7:0] amount,
   output LED
   );
   
   reg [7:0] bill_amount = 8'b00000000;
   always@(switch)
   begin
        case(switch)
            1:bill_amount=8'b00000001; // 1
            2:bill_amount=8'b00000101; // 5
            4:bill_amount=8'b00001010; // 10
            8:bill_amount=8'b00010100; //20
           16:bill_amount=8'b00110010; //5000
           32:bill_amount=8'b011001100; //100
           default: bill_amount=8'b00000000; // 0
        endcase
    end

    assign amount= bill_amount;
    reg active= 1'b0;
    always@(switch)
    begin
        case(switch)
            0:active=1'b0;
            1:active=1'b0;
            2:active=1'b0;
            4:active=1'b0;
           16:active=1'b0;
           32:active=1'b0;
           default:active=1'b1;
        endcase
    end
    
    assign LED= active;
endmodule




