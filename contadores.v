module cont99(
    input clk,
    input rst,
    input repondo,
    input decr,

    output reg [6:0] cont);

    parameter max = 7'b1100011;
    parameter min = 7'b0000000;

    always @(posedge clk) begin
        if (rst) begin cont <= min; end

        else if (repondo) begin
            if (cont < max) begin cont <= cont + 1; end
      end 
        
        else if (decr) begin
            if (cont > min) begin cont <= cont - 1; end
        end
    end

endmodule

module cont12 (
    input clk,
    input reset,
    input avanca,
    output reg [3:0] cont);
    
    reg [3:0] prox;
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    parameter s9 = 4'b1001;
    parameter s10 = 4'b1010;
    parameter s11 = 4'b1011;
    parameter s12 = 4'b1100;
    
    
    always @ ( posedge clk , posedge reset)
        if ( reset ) cont <= s0;
        else cont <= prox ;
        
    always @ (*)
        case ( cont )
            s0: if ( avanca ) prox = s1 ;
            else prox = s0 ;
            s1: if ( avanca ) prox = s2 ;
            else prox = s1 ;
            s2: if ( avanca ) prox = s3 ;
            else prox = s2;
            s3: if ( avanca ) prox = s4 ;
            else prox = s3;
            s4: if ( avanca ) prox = s5 ;
            else prox = s4 ;
            s5: if ( avanca ) prox = s6 ;
            else prox = s5 ;
            s6: if ( avanca ) prox = s7 ;
            else prox = s6;
            s7: if ( avanca ) prox = s8 ;
            else prox = s7;
            s8: if ( avanca ) prox = s9 ;
            else prox = s8 ;
            s9: if ( avanca ) prox = s10 ;
            else prox = s9 ;
            s10: if ( avanca ) prox = s11 ;
            else prox = s10;
            s11: if ( avanca ) prox = s12 ;
            else prox = s11;
            s12: if ( avanca ) prox = s1 ;
            else prox = s12;
            default: prox = s0 ;
        endcase
endmodule

module cont15 (
    input clk,
    input reset,
    input avanca,
    output reg [3:0] repo15);
    
    reg [3:0] prox;
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    parameter s9 = 4'b1001;
    parameter s10 = 4'b1010;
    parameter s11 = 4'b1011;
    parameter s12 = 4'b1100;
    parameter s13 = 4'b1101;
    parameter s14 = 4'b1110;
    parameter s15 = 4'b1111;
    
    always @ ( posedge clk , posedge reset)
        if (reset) repo15 <= s0;
        else repo15 <= prox ;
        
    always @ (*)
        case (repo15)
            s0: if (avanca) prox = s1 ;
            else prox = s0 ;
            s1: if (avanca) prox = s2 ;
            else prox = s1 ;
            s2: if (avanca) prox = s3 ;
            else prox = s2;
            s3: if (avanca) prox = s4 ;
            else prox = s3;
            s4: if (avanca) prox = s5 ;
            else prox = s4 ;
            s5: if (avanca) prox = s6 ;
            else prox = s5 ;
            s6: if (avanca) prox = s7 ;
            else prox = s6;
            s7: if (avanca) prox = s8 ;
            else prox = s7;
            s8: if (avanca) prox = s9 ;
            else prox = s8 ;
            s9: if (avanca) prox = s10 ;
            else prox = s9 ;
            s10: if (avanca) prox = s11 ;
            else prox = s10;
            s11: if (avanca) prox = s12 ;
            else prox = s11;
            s12: if (avanca) prox = s13 ;
            else prox = s12;
            s13: if (avanca) prox = s14 ;
            else prox = s13;
            s14: if (avanca) prox = s15 ;
            else prox = s14;
            s15: if (avanca) prox = s0 ;
            else prox = s15;
            default: prox = s0 ;
        endcase
endmodule

module cont10 (
    input clk,
    input reset,
    input avanca,
    output reg [3:0] duzia);
    
    reg [3:0] prox;
    parameter s0 = 4'b0000;
    parameter s1 = 4'b0001;
    parameter s2 = 4'b0010;
    parameter s3 = 4'b0011;
    parameter s4 = 4'b0100;
    parameter s5 = 4'b0101;
    parameter s6 = 4'b0110;
    parameter s7 = 4'b0111;
    parameter s8 = 4'b1000;
    parameter s9 = 4'b1001;
    parameter s10 = 4'b1010;
    
    
    always @ ( posedge clk , posedge reset)
        if ( reset ) duzia <= s0;
        else duzia <= prox ;
        
    always @ (*)
        case ( duzia )
            s0: if ( avanca ) prox = s1 ;
            else prox = s0 ;
            s1: if ( avanca ) prox = s2 ;
            else prox = s1 ;
            s2: if ( avanca ) prox = s3 ;
            else prox = s2;
            s3: if ( avanca ) prox = s4 ;
            else prox = s3;
            s4: if ( avanca ) prox = s5 ;
            else prox = s4 ;
            s5: if ( avanca ) prox = s6 ;
            else prox = s5 ;
            s6: if ( avanca ) prox = s7 ;
            else prox = s6;
            s7: if ( avanca ) prox = s8 ;
            else prox = s7;
            s8: if ( avanca ) prox = s9 ;
            else prox = s8 ;
            s9: if ( avanca ) prox = s10 ;
            else prox = s9 ;
            s10: if ( avanca ) prox = s0 ;
            else prox = s10;
            
            default: prox = s0 ;
        endcase
endmodule
