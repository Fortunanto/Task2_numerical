// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    output logic [63:0] product, 	// Miltiplication product
    
    // Multiplier controls
    input logic [31:0] a,        	// Input a
    input logic [31:0] b,        	// Input b
    input logic [1:0] a_sel,     	// Select one byte from A
    input logic       b_sel,     	// Select one 2-byte word from B
    input logic [5:0] shift_a_val, 	// Shift value of 8-bit mult product
    input logic [5:0] shift_b_val, 	// Shift value of 8-bit mult product
    input logic upd_prod,        	// Update the product register
    input logic clr_prod,        	// Clear the product register
    input logic clk,             	// Clock
    input logic rst              	// Reset
    );
    
    // Put your code here
    // ------------------
    logic [7:0] a_chunk;
    logic [7:0] b_chunk_1;
    logic [7:0] b_chunk_2;
    logic [15:0] mul_res_1;
    logic [15:0] mul_res_2;
    logic [63:0] shifted1;
    logic [63:0] shifted2;
    logic [63:0] temp_res;
    logic [63:0] prod_res;

    always_comb begin
        case (b_sel)
            0: begin
                b_chunk_1=b[7:0];
                b_chunk_2=b[23:16];
            end
            default: begin
                b_chunk_1=b[15:8];
                b_chunk_2=b[31:24];
            end
        endcase
        case (a_sel)
            0: begin a_chunk=a[7:0];
            end
            1: begin a_chunk=a[15:8];
            end
            2:begin a_chunk=a[23:16];
            end
            3:begin a_chunk=a[31:24];
            end
        endcase
        
        /*---  multiply sub_chunks                            ---*/
        /*------------------------------------*/
        mul_res_1=a_chunk*b_chunk_2;
        mul_res_2=a_chunk*b_chunk_1;

        /*---  shifting numbers according to values                            ---*/
        /*------------------------------------*/
        
        shifted1=mul_res_1 << shift_a_val;
        shifted2=mul_res_2 << shift_b_val;
        
        temp_res=shifted1+shifted2;
    end
    always_ff @(posedge clk,posedge rst) begin
        if(rst==1) begin
            prod_res<=0;
        end
        if(clr_prod==1) begin
            prod_res<=0;
        end
        if(upd_prod==1) begin
            prod_res<=prod_res+temp_res;
            product<=prod_res;
        end
        
    end
    // End of your code
endmodule
