module MEFRolha(
    input repondo,
    input clk,
    input rst,
    input meio_rst,
    input start,
    input dcr_rolha,
    
    output alarme,
    output fim_mefRolha,
    output [6:0] qtd_rolha,
    output [6:0] qtd_estoque);
        
    wire icr_estoque, dcr_estoque, icr_rolha, icr_rolha15;
     wire R1pR2, R1pR4, R3pR4, R7pR6, R7pR7;

    wire [3:0] qtd_repo15;
       
    reg [2:0] estado, prox;
    
    parameter R0 = 3'b000;
    parameter R1 = 3'b001;
    parameter R2 = 3'b010;
    parameter R3 = 3'b011;
    parameter R4 = 3'b100;
    parameter R5 = 3'b101;
    parameter R6 = 3'b110;
    parameter R7 = 3'b111;
    
    wire RESETestados;
    or(RESETestados, meio_rst, rst);
    
    always @ (posedge clk) begin
        if (RESETestados) estado <= R0;
        else estado <= prox ;
    end
    
    always @ (*) begin
        prox = estado;
            case (estado)
                R0: if(start == 1) prox = R1;
                else prox = R0;
                
                R1: if (R1pR2) prox = R2;
                else if(R1pR4) prox = R4;
                else prox = R5;
            
                R2: prox = R3;
            
                R3: if(R3pR4) prox = R4;
                else prox = R2;
                
                R4: prox = R4;
            
                R5: if (repondo) prox = R6;
                else prox = R5;
            
                R6: if(repondo) prox = R7;
                else prox = R1;
            
                R7: if(R7pR6) prox = R6;
                else if(R7pR7) prox = R7;
                else prox = R1;
                
                default: prox = R0;
            endcase
    end
                
    saidaLogic (.estado(estado), .qtd_rolha(qtd_rolha), .qtd_estoque(qtd_estoque), .qtd_repo15(qtd_repo15), .repondo(repondo), 
     .icr_estoque(icr_estoque), .dcr_estoque(dcr_estoque), .icr_rolha(icr_rolha), .icr_rolha15(icr_rolha15), .alarme(alarme), 
     .fim_mefRolha(fim_mefRolha), .R1pR2(R1pR2), .R1pR4(R1pR4), .R3pR4(R3pR4), .R7pR6(R7pR6), .R7pR7(R7pR7));
    
    cont99(.clk(clk), .rst(rst), .repondo(icr_estoque), .decr(dcr_estoque), .cont(qtd_estoque));
    cont99(.clk(clk), .rst(rst), .repondo(icr_rolha), .decr(dcr_rolha), .cont(qtd_rolha));
    cont15(.clk(clk), .reset(RESETestados), .avanca(icr_rolha15), .repo15(qtd_repo15));
        
endmodule



module saidaLogic (
    input [2:0] estado,
     input [6:0] qtd_rolha,
     input [6:0] qtd_estoque,
     input [3:0] qtd_repo15,
     input repondo,
    
    output icr_estoque,
    output dcr_estoque,
    output icr_rolha,
    output icr_rolha15,
    output alarme, 
    output fim_mefRolha,
     
     output R1pR2,
     output R1pR4,
     output R3pR4,
     output R7pR6,
     output R7pR7);

    wire nE0, nE1, nE2;

    not (nE0, estado[0]);
    not (nE1, estado[1]);
    not (nE2, estado[2]);

    and (icr_rolha, nE2, estado[1], nE0);
    and (dcr_estoque, nE2, estado[1], nE0);
    and (icr_rolha15, nE2, estado[1], nE0);

    and (alarme, estado[2], nE1, estado[0]);
    and (fim_mefRolha, estado[2], nE1, nE0);

    and (icr_estoque, estado[2], estado[1], nE0);
     
     wire [6:0] nEstoque;
     not(nEstoque[0], qtd_estoque[0]); not(nEstoque[1], qtd_estoque[1]); not(nEstoque[2], qtd_estoque[2]); not(nEstoque[3], qtd_estoque[3]);
     not(nEstoque[4], qtd_estoque[4]); not(nEstoque[5], qtd_estoque[5]); not(nEstoque[6], qtd_estoque[6]);
     
     wire estoque0, estoqueMa0, estoqueI99, estoqueMe99;
     
     and (estoque0, nEstoque[6], nEstoque[5], nEstoque[4], nEstoque[3], nEstoque[2], nEstoque[1], nEstoque[0]);
     or (estoqueMa0, qtd_estoque[6], qtd_estoque[5], qtd_estoque[4], qtd_estoque[3], qtd_estoque[2], qtd_estoque[1], qtd_estoque[0]);
     and (estoqueI99, qtd_estoque[6], qtd_estoque[5], nEstoque[4], nEstoque[3], nEstoque[2], qtd_estoque[1], qtd_estoque[0]);
     not(estoqueMe99, estoqueI99);
     
     wire meioRolha1, meioRolha2, rolhaMa5, rolhaMa0, rolhaMI5;
     or (rolhaMa0, qtd_rolha[6], qtd_rolha[5], qtd_rolha[4], qtd_rolha[3], qtd_rolha[2], qtd_rolha[1], qtd_rolha[0]);
     and (meioRolha, qtd_rolha[2], qtd_rolha[1]);
     or (rolhaMa5, qtd_rolha[6], qtd_rolha[5], qtd_rolha[4], qtd_rolha[3], meioRolha);
     not(rolhaMI5, rolhaMa5);
    
     wire repo15i15;
     and (repo15i15, qtd_repo15[3], qtd_repo15[2], qtd_repo15[1], qtd_repo15[0]);
     and (meioRolha2, estoque0, rolhaMa0);
     
     and (R1pR2, estoqueMa0, rolhaMI5);
     or (R1pR4, meioRolha2, rolhaMa5);
     or (R3pR4, repo15i15, estoque0);
     and (R7pR6, repondo, estoqueMe99);
     and(R7pR7, repondo, estoqueI99);
     
endmodule
