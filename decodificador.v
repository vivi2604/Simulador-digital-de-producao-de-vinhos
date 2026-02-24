module decodificador (
	input [6:0] A,
	output [6:0] dU,
	output [6:0] dD);
	
	wire [3:0] U, D, F1, F2, F3;
	wire C;

	somsel (.A({1'b0, A[6], A[5], A[4]}), .S(F1));
	somsel (.A({F1[2], F1[1], F1[0], A[3]}), .S(F2));
 	somsel (.A({F2[2], F2[1], F2[0], A[2]}), .S(F3));
 	somsel (.A({F3[2], F3[1], F3[0], A[1]}), .S({D[0], U[3], U[2], U[1]}));
	
	or (U[0], 1'b0, A[0]);
	  
 	somsel (.A({1'b0, F1[3], F2[3], F3[3]}), .S({C, D[3], D[2], D[1]}));

	display (.A(U[3]), .B(U[2]), .C(U[1]), .D(U[0]), .d(dU));
	display (.A(D[3]), .B(D[2]), .C(D[1]), .D(D[0]), .d(dD));
	
endmodule 

module somsel(
    input [3:0] A,
    output [3:0] S);
    
    wire f1, f2, f3, s_mux, descarte;
    wire [3:0] c;
    
    and(f1, A[2], A[1]);
    and(f2, A[2], A[0]);
    or(f3, f1, f2, A[3]);
    
    mux2x1(.i0(1'b0), .i1(1'b1), .sel(f3), .out(s_mux));
    
    meiosomador (.A(A[0]), .B(s_mux),  .S(S[0]), .Cout(c[0]));
    somadorcompleto (.A(A[1]), .B(s_mux), .Cin(c[0]),  .S(S[1]), .Cout(c[1]));
    meiosomador (.A(A[2]), .B(c[1]),  .S(S[2]), .Cout(c[2]));
    meiosomador (.A(A[3]), .B(c[2]),  .S(S[3]), .Cout(descarte));

endmodule

module mux2x1(
    input i0, 
    input i1, 
    input sel,
    output out);
    
    wire f1, f2, notsel;
    
    not(notsel, sel);
     
    and(f1, i0, notsel);
    and(f2, i1, sel);
    or(out, f1, f2);
    
endmodule

module display(
    input A, 
	 input B, 
	 input C, 
	 input D,
    output [6:0] d);
    
    wire notA, notB, notC, notD;
    wire [26:0] w;
    
    not(notA, A);
    not(notB, B);
    not(notC, C);
    not(notD, D);
    
    and(w[0], A, C);
    and(w[1], notC, notD, B);
	 and(w[2], A, B);
	 and(w[3], notA, notB, notC, D);
    or(d[0], w[0], w[1], w[2], w[3]);
    
    and(w[4], B, notC, D);
    and(w[5], notD, B, C);
	 and(w[6], A, C);
	 and(w[7], A, B);
    or(d[1], w[4], w[5], w[6], w[7]);
    
	 and(w[8], notD, notB, C);
	 and(w[9], A, B);
	 and(w[10], A, C);
    or(d[2], w[8], w[9], w[10], w[11]);
    
    and(w[12], A, B);
    and(w[13], A, C);
    and(w[14], B, C, D);
	 and(w[15], notC, B, notD);
	 and(w[16], notA, notB, notC, D);
    or(d[3], w[12], w[13], w[14], w[15], w[16]);
    
    and(w[17], notC, B);
	 and(w[18], A, C);
    or(d[4], D, w[17], w[18]);
    
    and(w[19], A, B);
	 and(w[20], C, D);
    and(w[21], notB, C);
	 and(w[22], notA, D, notB);
    or(d[5], w[19], w[20], w[21], w[22]);
    
    and(w[23], A, B);
    and(w[24], A, C);
	 and(w[25], B, C, D);
	 and(w[26], notA, notB, notC);
    or(d[6], w[23], w[24], w[25], w[26]);

endmodule

module meiosomador(
    input A, B,
    output S, Cout);
    
    xor(S, A, B);
    and(Cout, A, B);
    
endmodule

module somadorcompleto(
    input A, B, Cin,
    output S, Cout);
    
    wire F1, F2, F3;
    
    xor(S, A, B, Cin);
    
    and(F1, A, B);
    xor(F2, A, B);
    and(F3, F2, Cin);
    or(Cout, F1, F3);
    
endmodule 

