module Top_Module (
  input logic clk,          // System clock 100 MHz
  input logic Up_Button,   // Top button for deposit
  input logic Down_Button, // Bottom button for withdrawal
  input logic reset,       // Center button for resetting
  input logic [5:0] sw,    // 6 different bills (1, 5, 10, 20, 50, 100)
  output logic [2:0] LED,  // For errors and warnings
  output logic [3:0] an,   // To enable the segments on Basys 3 board
  output logic [6:0] seg   // Seven-segment display
);

  
  logic[3:0] zero = 4'b0000;

  // All wires that connect the output of submodules to the input of other submodules
  logic clk_out;            // 100 Hz clock
  logic deposit;            // Triggered signal that indicates money was deposited into the bank
  logic withdrawal;         // Triggered signal that indicates money was withdrawn from the bank
  logic [3:0] mux_out;      // Output of the Multiplexer
  logic [1:0] counter_out;  // Output of the 2-bit counter
  logic [3:0] ones, tens, hundreds; // Number that will be displayed on the segment
  logic [7:0] amount_count; // Bill amount, 1, 5,10,50,100 etc.
  logic Up_deb, Down_deb;   // Debounced signal from the pushbuttons
  logic [7:0] amount;       // Displays the total balance/amount/count in the account, 0 to 255 (why 255 limit is to simplify the implementation. 
                                                                                                   //can be increased by increasing the bit size)



  debounce U0(clk, Up_Button, Up_deb);
  debounce U1(clk, Down_Button, Down_deb);
  Binary_BCD_Converter U2(amount_count, ones, tens, hundreds);   //converts swtich input to decimal value
  four_to_one_Mux U3(ones, tens, hundreds, zero, counter_out, mux_out); 
  SlowClock_100Hz U4(clk, clk_out); // we use this to slow down the clock input, since the original clk input on basys3 board is 100Mhz which is high and prevents us from viewing the simulation graph
                                    //At lower frequencies, it becomes more feasible to observe signals, check state transitions
  eight_bit_counter U5(clk_out, counter_out);  //sets the maximum number that can be shown on the 7-segment display
  
  Decoder U6(counter_out, an);
  BCD_Seven_Segment U7(mux_out, seg); //7-SEG-DISP

  // triggered signal indicating whether money is deposited or withdrawn
  Deposit U8(clk, reset, Up_deb, deposit);
  Withdraw U9(clk, reset, Down_deb, withdrawal);

  // ATM Functioning, LED warning in case of overflows
  counter U10(clk, reset, deposit, withdrawal, amount, amount_count, LED[1], LED[2]);  
  ATM U11(sw, amount, LED[0]);

endmodule
