// 32X32 Multiplier FSM
module mult32x32_fast_fsm (
    output logic valid,             // Operation valid indication
    output logic  [1:0] a_sel,      // Select one byte from A
    output logic        b_sel,      // Select one 2-byte word from B
    output logic  [5:0] shift_a_val,// Shift value of 8-bit mult product
    output logic  [5:0] shift_b_val,// Shift value of 8-bit mult product
    output logic upd_prod,          // Update the product register
    output logic clr_prod,          // Clear the product register

    input logic start,              // Start signal
    input logic a_msb_is_0,   		// Indicates the MSB byte of a is zero
    input logic clk,                // Clock
    input logic rst                 // Reset
);

// Put your code here
// ------------------

    localparam state_a=4'd0;
    localparam state_b=4'd1;
    localparam state_c=4'd2;
    localparam state_d=4'd3;
    localparam state_e=4'd4;
    localparam state_f=4'd5;
    localparam state_g=4'd6;
    localparam state_h=4'd7;
    localparam state_i=4'd8;
    
    logic [3:0] cur_state; 
    
    always_ff @(posedge clk, posedge rst) begin
        if(rst == 1) begin
            cur_state=state_a;
        end
        case(cur_state)
            state_a: begin
                if(start == 1'b0) begin
                    valid<=1;
                    upd_prod<=0;
                end
                else begin
                    cur_state<=state_b;
                    a_sel<=0;
                    b_sel<=0;
                    shift_a_val<=16;
                    shift_b_val<=0;
                    upd_prod<=1;
                    clr_prod<=0;
                    valid<=0;
                end
            end
            state_b: begin
                cur_state<=state_c;
                a_sel<=0;
                b_sel<=1;
                shift_a_val<=24;
                shift_b_val<=8;
                upd_prod<=1;
                clr_prod<=0;
                valid<=0;
            end
            state_c: begin
                cur_state<=state_d;
                a_sel<=1;
                b_sel<=0;
                shift_a_val<=24;
                shift_b_val<=8;
                upd_prod<=1;
                clr_prod<=0;
                valid<=0;
            end
            state_d: begin
                cur_state<=state_e;
                a_sel<=1;
                b_sel<=1;
                shift_a_val<=32;
                shift_b_val<=16;
                upd_prod<=1;
                clr_prod<=0;
                valid<=0;
            end
            state_e: begin
                cur_state<=state_f;
                a_sel<=2;
                b_sel<=0;
                shift_a_val<=32;
                shift_b_val<=16;
                upd_prod<=1;
                clr_prod<=0;
                valid<=0;
            end
            state_f: begin
                cur_state<=state_g;
                a_sel<=2;
                b_sel<=1;
                shift_a_val<=40;
                shift_b_val<=24;
                upd_prod<=1;
                clr_prod<=0;
                valid<=0;
            end    
            state_g: begin
                if (a_msb_is_0==1'b1) begin
                    cur_state<=state_a;
                    upd_prod<=1
                    valid<=0;
                end
                else begin
                    cur_state<=state_h;
                    a_sel<=3;
                    b_sel<=0;
                    shift_a_val<=40;
                    shift_b_val<=24;
                    upd_prod<=1;
                    clr_prod<=0;
                    valid<=0;
                end
            end
            state_h: begin
                cur_state<=state_i;
                a_sel<=3;
                b_sel<=1;
                shift_a_val<=48;
                shift_b_val<=32;
                upd_prod<=1;
                clr_prod<=0;
                valid<=0;
            end
            state_i: begin
                cur_state<=state_a;
                upd_prod<=1;
                valid<=0;
            end
        endcase                
    end
    
// End of your code

endmodule

