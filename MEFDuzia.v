module MEFDuzia(
    input clk,
    input rst,
    input CQ,
    input estado1,
     input estado6,
    
    output fim_mefDuzia,
    
    output [3:0] duzia);
         
    wire resetEstado;
    or(resetEstado, rst, estado1);
    
    wire icr_cont, icr_duzia, cont12, duzia10;
     wire [3:0] cont;
            
    reg [2:0] estado, prox;
    
    parameter c0 = 3'b000;
    parameter c1 = 3'b001;
    parameter c2 = 3'b010;
    parameter c3 = 3'b011;
    parameter c4 = 3'b100;
     parameter c5 = 3'b101;
     parameter c6 = 3'b110;
    
    always @ (posedge clk) begin
        if (resetEstado) estado <= c0;
        else estado <= prox ;
    end
    
    always @ (*) begin
        prox = estado;
            case (estado)
                c0: if(CQ == 1 && estado6 == 1) prox = c1;
                else prox = c0;
                
                c1: prox = c2;
            
                c2: if(cont12) prox = c3;
                else prox = c6;
            
                c3: prox = c4;
                
                c4: if(duzia10) prox = c5;
                     else prox = c6;
                     
                     c5: prox = c6;
                     
                     c6: prox = c6;
            
                default: prox = c0;
            endcase
    end
         
    saidaMEFCont (.estado(estado), .cont(cont), .duzia(duzia), .icr_cont(icr_cont), 
     .icr_duzia(icr_duzia), .fim_mefDuzia(fim_mefDuzia), .duzia10(duzia10), .cont12(cont12));
    
    cont10(.clk(clk), .reset(rst), .avanca(icr_duzia), .duzia(duzia));
    cont12(.clk(clk), .reset(rst), .avanca(icr_cont), .cont(cont));
        
endmodule

module saidaMEFCont (
    input [2:0] estado,
     input [3:0] cont,
     input [3:0] duzia,
    
    output icr_cont,
    output icr_duzia,
    output fim_mefDuzia,
     output duzia10,
     output cont12);

    wire nE0, nE1, nE2;

    not (nE0, estado[0]);
    not (nE1, estado[1]);
    not (nE2, estado[2]);
     
     wire meio_cont, meio_duzia;
     wire resetcont;
    
     
    and (meio_cont, nE2, nE1, estado[0]);
     and (meio_duzia, nE2, estado[1], estado[0]);
     and (resetcont, estado[2], nE1, estado[0]);
     
     or(icr_cont, meio_cont, resetcont);
     or(icr_duzia, meio_duzia, resetcont);
    
    and (fim_mefDuzia, estado[2], estado[1], nE0);
     
     wire nCont0, nCont1;
     wire nDuzia0, nDuzia2;
     
     not(nCont0, cont[0]); not(nCont1, cont[1]);
     not(nDuzia0, duzia[0]); not(nDuzia2, duzia[2]);
     
     and(cont12, cont[3], cont[2], nCont1, nCont0);
     and(duzia10, duzia[3], nDuzia2, duzia[1], nDuzia0);

endmodule
