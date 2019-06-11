// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic [31:0] a;        // Input a
    logic [31:0] b;        // Input b
    logic start;           // Start signal
    logic [63:0] product;  // Miltiplication product
    logic valid;           // Operation valid indication
    
    logic clk;             // Clock
    logic reset;           // Reset

// Put your code here
// ------------------

    mult32x32_fast mult(
    .a(a),
    .b(b),
    .start(start),
    .product(product),
    .valid(valid),
    .clk(clk),
    .reset(reset));
    initial begin  
        clk=0;
        reset=1;
        start=0;
        #5;
        reset=0;
        a=32'd316089952;
        b=32'd206038796;     
        
        repeat(3) begin
            @(posedge clk);
        end

        start=1;

        @(posedge clk);        
        start=0; 

        repeat(8) begin
            @(posedge clk);
        end
        
        a=32'hD72660;
        
      repeat(3) begin
            @(posedge clk);
        end   
        start=1;
                 @(posedge clk);

        start=0;
    end
    always begin
        #20 clk=~clk;              
    end     
// End of your code

endmodule
