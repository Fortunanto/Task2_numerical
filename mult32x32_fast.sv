// 32X32 Iterative Multiplier template
module mult32x32_fast (
    input  logic [31:0] a,        // Input a
    input  logic [31:0] b,        // Input b
    input  logic start,           // Start signal
    output logic [63:0] product,  // Miltiplication product
    output logic valid,           // Operation valid indication
    
    input  logic clk,             // Clock
    input  logic reset            // Reset
);

// Put your code here
// ------------------
    logic clr,upd;  
    logic [1:0] a_sel;
    logic b_sel;
    logic [5:0] shift_a_val;
    logic [5:0] shift_b_val;
    logic a_msb_is_0;
    
    assign a_msb_is_0 = (a[31:24]==0);

    mult32x32_fast_fsm fsm(
        .start(start),
        .a_msb_is_0(a_msb_is_0),
        .clk(clk),
        .rst(reset),
        .a_sel(a_sel),
        .b_sel(b_sel),
        .shift_a_val(shift_a_val),
        .shift_b_val(shift_b_val),
        .upd_prod(upd),
        .clr_prod(clr),
        .valid(valid)
    );
    mult32x32_arith arith(
        .clk(clk),
        .rst(reset),
        .a(a),
        .b(b),
        .a_sel(a_sel),
        .b_sel(b_sel),
        .shift_a_val(shift_a_val),
        .shift_b_val(shift_b_val),
        .upd_prod(upd),
        .clr_prod(clr),
        .product(product)
    );
// End of your code

endmodule
