module Withdraw(
    input logic clk,
    input logic reset,
    input logic Down_Button,  // Withdraw money
    output logic count_down   // Triggers decrement signal
);

    typedef enum logic [1:0] {
        S00 = 2'b00,
        FLAG = 2'b01
    } state_t;

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
            S00: begin
                if (Down_Button) begin
                    next_state = FLAG;
                end else begin
                    next_state = S00;
                end
            end
            FLAG: begin
                next_state = S00;
            end
            default: begin // Implied-latch free implementation
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
    assign count_down = set_flag;

endmodule
