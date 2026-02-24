module MEFPrincipal(
    input repondo,
    input clk,
    input start,
    input rst,
    input EV,
    input VE,
    input CQ,
    input descarte,
    input garrafa,

    output reg [2:0] estado,
     
    output [6:0] S_estoque1, 
    output [6:0] S_estoque2, 
     
    output [6:0] S_rolha1, 
    output [6:0] S_rolha2,
    
    output [6:0] S_duzia1, 
    output [6:0] S_duzia2, 

    output alarme,
    output M,
    output ledEV,
    output ledVE,
    output leddescarte);
    
     wire nStart, nReset;
     not(nStart, start);
     not(nReset, rst);
 
    wire clock24;
    DivisorF24(.clock(clk), .T(1'b1), .P(clock24)); 
    
    decodificador(.A(cont_estoque), .dU(S_estoque1), .dD(S_estoque2));
    decodificador(.A(cont_rolha), .dU(S_rolha1), .dD(S_rolha2));
    decodificador(.A({3'b0, contDuzia}), .dU(S_duzia1), .dD(S_duzia2));
    
    reg [2:0] prox;
    parameter P0 = 3'b000;
    parameter P1 = 3'b001;
    parameter P2 = 3'b010;
    parameter P3 = 3'b011;
    parameter P4 = 3'b100;
    parameter P5 = 3'b101;
    parameter P6 = 3'b110;
    parameter P7 = 3'b111;
    
    wire dcr_rolha, icr_cont, icr_duzia, fim_mefRolha, estC4;
    wire start_rolha, resetEST36, estado6;
            
    wire [3:0] contDuzia;
    wire [6:0] cont_rolha, cont_estoque;

    
    always @ (posedge clock24) begin
        if (nReset == 1 || (nStart == 1 && estado != P0)) estado <= P0;
        else estado <= prox ;
    end
    
    always @ (*) begin
        prox = estado;
            case (estado)
                P0: if (nStart == 1 && garrafa == 0) prox = P1;
                else prox = P0;
            
                P1: if(EV == 1 && garrafa == 1) prox = P2;
                else prox = P1;
            
                P2: if(fim_mefRolha == 1) prox = P3;
                else prox = P2;
                
                P3: if(VE == 1) prox = P4;
                else prox = P3;
            
                P4: prox = P5;
            
                P5: if(fim_mefRolha == 1) prox = P6;
                else prox = P5;
            
                P6: if(CQ == 1 && estC4 == 1) prox = P1;
                else if(descarte == 1) prox = P7;
                
                P7: if(descarte == 1) prox = P7;
                else prox = P1;
            
                default: prox = P0;
            endcase
    end
    
     
    estruturalPrincipal(.estado(estado), .alarme(alarme), .garrafa(garrafa), .M(M), .ledEV(ledEV), .ledVE(ledVE), .leddescarte(leddescarte), .dcr_rolha(dcr_rolha), 
    .start_rolha(start_rolha), .resetEST36(resetEST36), .estado6(estado6));
         
    MEFDuzia (.clk(clock24), .rst(nReset), .CQ(CQ), .estado1(ledEV), .estado6(estado6), .fim_mefDuzia(estC4), .duzia(contDuzia));
    
    MEFRolha(.clk(clock24), .rst(nReset), .meio_rst(resetEST36), .repondo(repondo), .start(start_rolha), .dcr_rolha(dcr_rolha), 
    .alarme(alarme), .fim_mefRolha(fim_mefRolha), .qtd_rolha(cont_rolha), .qtd_estoque(cont_estoque));
    
endmodule

module estruturalPrincipal(
    input [2:0] estado,
    input alarme,
     input garrafa,
    
    output M,
    output ledEV,
    output ledVE,
    output leddescarte,
    output dcr_rolha,
    output start_rolha,
    output resetEST36, 
     output estado6);
    
    wire [1:0] rolha, meio_stRolha, rstRolha;    
     wire [2:0] motorzinho;
     
    wire nE2, nE1, nE0;
    not (nE2, estado[2]);
    not (nE1, estado[1]);
    not (nE0, estado[0]);
        
    and (ledEV, nE2, nE1, estado[0], garrafa);
    and (ledVE, nE2, estado[1], estado[0]);
    and (leddescarte, estado[2], estado[1], estado[0]);
    and (dcr_rolha, estado[2], nE1, nE0);

    and (meio_stRolha[0], nE2, estado[1], nE0);
     and (meio_stRolha[1], estado[2], nE1, estado[0]);
        
    or(start_rolha, meio_stRolha[1], meio_stRolha[0]);
    
     wire nAlarme;
     not(nAlarme, alarme);
     
     //A'D + A'C + A'B
    and(motorzinho[0], nAlarme, estado[0]);
    and(motorzinho[1], nAlarme, estado[1]);
     and(motorzinho[2], nAlarme, estado[2]);
    or(M, motorzinho[0], motorzinho[1], motorzinho[2]);
     
    and(rstRolha[0], nE2, estado[1], estado[0]);
    and(rstRolha[1], estado[2], estado[1], nE0);
    or(resetEST36, rstRolha[0], rstRolha[1]);
    
     or(estado6, rstRolha[1], 1'b0);
     
endmodule