module DivisorF (
    input T,
    input clk,
    output P);
    
    wire inD;
    xor(inD, P, T); 

    flipflopD(.clk(clk), .d(inD), .q(P));
    
endmodule

module flipflopD ( 
    input clk, 
    input d, 
    output reg q );
    
    always @ ( posedge clk ) begin
        q <= d;
    end

endmodule

module DivisorF24 (
    input T,
    input clock,
    output P);
     
    wire [23:0] clk;
    
    DivisorF(.clk(clock), .T(T), .P(clk[0]));
    DivisorF(.clk(clk[0]), .T(T), .P(clk[1]));
    DivisorF(.clk(clk[1]), .T(T), .P(clk[2]));
    DivisorF(.clk(clk[2]), .T(T), .P(clk[3]));
    DivisorF(.clk(clk[3]), .T(T), .P(clk[4]));
    DivisorF(.clk(clk[4]), .T(T), .P(clk[5]));
    DivisorF(.clk(clk[5]), .T(T), .P(clk[6]));
    DivisorF(.clk(clk[6]), .T(T), .P(clk[7]));
    DivisorF(.clk(clk[7]), .T(T), .P(clk[8]));
    DivisorF(.clk(clk[8]), .T(T), .P(clk[9]));
    DivisorF(.clk(clk[9]), .T(T), .P(clk[10]));
    DivisorF(.clk(clk[10]), .T(T), .P(clk[11]));
    DivisorF(.clk(clk[11]), .T(T), .P(clk[12]));
    DivisorF(.clk(clk[12]), .T(T), .P(clk[13]));
    DivisorF(.clk(clk[13]), .T(T), .P(clk[14]));
    DivisorF(.clk(clk[14]), .T(T), .P(clk[15]));
    DivisorF(.clk(clk[15]), .T(T), .P(clk[16]));
    DivisorF(.clk(clk[16]), .T(T), .P(clk[17]));
    DivisorF(.clk(clk[17]), .T(T), .P(clk[18]));
    DivisorF(.clk(clk[18]), .T(T), .P(clk[19]));
    DivisorF(.clk(clk[19]), .T(T), .P(clk[20]));
    DivisorF(.clk(clk[20]), .T(T), .P(clk[21]));
    DivisorF(.clk(clk[21]), .T(T), .P(P));
     
endmodule
