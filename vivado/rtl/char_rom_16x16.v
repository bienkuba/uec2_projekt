`timescale 1ns / 1ps
  
module char_rom_16x16(
    input wire pclk,
    input wire rst,
    input wire [7:0]  char_xy,
    input wire [23:0] points,
    input wire [23:0] ext_data_1,
    input wire [23:0] ext_data_2,
    
    output reg [6:0]  char_code 
);

    reg [3:0] P1_D1, P1_D2, P1_D3, P1_D4, P1_D5, P1_D6;
    reg [3:0] P2_D1, P2_D2, P2_D3, P2_D4, P2_D5, P2_D6;
    reg [3:0] P3_D1, P3_D2, P3_D3, P3_D4, P3_D5, P3_D6;
    
    localparam SPACE = 7'h20;
    localparam COLON = 7'h3A;
    localparam greater = 7'h3E;
    localparam less = 7'h3C;
    
    localparam NUM0 = 7'h30;
    localparam NUM1 = 7'h31;
    localparam NUM2 = 7'h32;
    localparam NUM3 = 7'h33;
    localparam NUM4 = 7'h34;
    localparam NUM5 = 7'h35;
    localparam NUM6 = 7'h36;
    localparam NUM7 = 7'h37;
    localparam NUM8 = 7'h38;
    localparam NUM9 = 7'h39;

    localparam A = 7'h41;
    localparam B = 7'h42;
    localparam C = 7'h43;
    localparam D = 7'h44;
    localparam E = 7'h45;
    localparam F = 7'h46;
    localparam G = 7'h47;
    localparam H = 7'h48;
    localparam I = 7'h49;
    localparam J = 7'h4A;
    localparam K = 7'h4B;
    localparam L = 7'h4C;
    localparam M = 7'h4D;
    localparam N = 7'h4E;
    localparam O = 7'h4F;
    localparam P = 7'h50;
    localparam Q = 7'h51;
    localparam R = 7'h52;
    localparam S = 7'h53;
    localparam T = 7'h54;
    localparam U = 7'h55;
    localparam V = 7'h56;
    localparam W = 7'h57;
    localparam X = 7'h58;
    localparam Y = 7'h59;
    localparam Z = 7'h5A;
    
    localparam a = 7'h61;
    localparam b = 7'h62;
    localparam c = 7'h63;
    localparam d = 7'h64;
    localparam e = 7'h65;
    localparam f = 7'h66;
    localparam g = 7'h67;
    localparam h = 7'h68;
    localparam i = 7'h69;
    localparam j = 7'h6A;
    localparam k = 7'h6B;
    localparam l = 7'h6C;
    localparam m = 7'h6D;
    localparam n = 7'h6E;
    localparam o = 7'h6F;
    localparam p = 7'h70;
    localparam q = 7'h71;
    localparam r = 7'h72;
    localparam s = 7'h73;
    localparam t = 7'h74;
    localparam u = 7'h75;
    localparam v = 7'h76;
    localparam w = 7'h77;
    localparam x = 7'h78;
    localparam y = 7'h79;
    localparam z = 7'h7A;
    
 always@(posedge pclk) begin
    if(rst) begin
        P1_D1 <= 0;
        P1_D2 <= 0;
        P1_D3 <= 0;
        P1_D4 <= 0;
        
        P2_D1 <= 0;
        P2_D2 <= 0;
        P2_D3 <= 0;
        P2_D4 <= 0;
        
        P3_D1 <= 0;
        P3_D2 <= 0;
        P3_D3 <= 0;
        P3_D4 <= 0;
    end
    else begin     
        P1_D1 <= points[23:20]; 
        P1_D2 <= points[19:16]; 
        P1_D3 <= points[15:12]; 
        P1_D4 <= points[11:8];  
        P1_D5 <= points[7:4];   
        P1_D6 <= points[3:0];   
     
        P2_D1 <= ext_data_1[23:20]; 
        P2_D2 <= ext_data_1[19:16]; 
        P2_D3 <= ext_data_1[15:12]; 
        P2_D4 <= ext_data_1[11:8];  
        P2_D5 <= ext_data_1[7:4];   
        P2_D6 <= ext_data_1[3:0];   
        
        P3_D1 <= ext_data_2[23:20];
        P3_D2 <= ext_data_2[19:16];
        P3_D3 <= ext_data_2[15:12];
        P3_D4 <= ext_data_2[11:8]; 
        P3_D5 <= ext_data_2[7:4];  
        P3_D6 <= ext_data_2[3:0];        
    end
 end

    always@*   
      case(char_xy)
        8'h00: char_code = greater;
        8'h01: char_code = greater;
        8'h02: char_code = greater;
        8'h03: char_code = greater;
        8'h04: char_code = greater;
        8'h05: char_code = S;       
        8'h06: char_code = C;
        8'h07: char_code = O;
        8'h08: char_code = R;
        8'h09: char_code = E;
        8'h0a: char_code = COLON; 
        8'h0b: char_code = less; 
        8'h0c: char_code = less;
        8'h0d: char_code = less;
        8'h0e: char_code = less;
        8'h0f: char_code = less;
        
        8'h10: char_code = P;         
        8'h11: char_code = l; 
        8'h12: char_code = a; 
        8'h13: char_code = y; 
        8'h14: char_code = e;
        8'h15: char_code = r; 
        8'h16: char_code = NUM1;  
        8'h17: char_code = COLON; 
        8'h18: char_code = SPACE; 
        8'h19: char_code = SPACE;
        8'h1a: char_code = {4'b0011, P1_D1}; 
        8'h1b: char_code = {4'b0011, P1_D2}; 
        8'h1c: char_code = {4'b0011, P1_D3};
        8'h1d: char_code = {4'b0011, P1_D4}; 
        8'h1e: char_code = {4'b0011, P1_D5};
        8'h1f: char_code = {4'b0011, P1_D6};         
                   
        8'h20: char_code = P; 
        8'h21: char_code = l; 
        8'h22: char_code = a;   
        8'h23: char_code = y;   
        8'h24: char_code = e;   
        8'h25: char_code = r;   
        8'h26: char_code = NUM2;   
        8'h27: char_code = COLON;   
        8'h28: char_code = SPACE;   
        8'h29: char_code = SPACE;   
        8'h2a: char_code = {4'b0011, P2_D1}; 
        8'h2b: char_code = {4'b0011, P2_D2}; 
        8'h2c: char_code = {4'b0011, P2_D3};
        8'h2d: char_code = {4'b0011, P2_D4}; 
        8'h2e: char_code = {4'b0011, P2_D5};
        8'h2f: char_code = {4'b0011, P2_D6};
                  
        8'h30: char_code = P;   
        8'h31: char_code = l;   
        8'h32: char_code = a;   
        8'h33: char_code = y;   
        8'h34: char_code = e;   
        8'h35: char_code = r;   
        8'h36: char_code = NUM3;   
        8'h37: char_code = COLON;   
        8'h38: char_code = SPACE;   
        8'h39: char_code = SPACE;   
        8'h3a: char_code = {4'b0011, P3_D1}; 
        8'h3b: char_code = {4'b0011, P3_D2}; 
        8'h3c: char_code = {4'b0011, P3_D3};
        8'h3d: char_code = {4'b0011, P3_D4}; 
        8'h3e: char_code = {4'b0011, P3_D5};
        8'h3f: char_code = {4'b0011, P3_D6};
                   
        8'h40: char_code = SPACE;   
        8'h41: char_code = SPACE;   
        8'h42: char_code = SPACE;   
        8'h43: char_code = SPACE;   
        8'h44: char_code = SPACE;   
        8'h45: char_code = SPACE;   
        8'h46: char_code = SPACE;   
        8'h47: char_code = SPACE;   
        8'h48: char_code = SPACE;   
        8'h49: char_code = SPACE;   
        8'h4a: char_code = SPACE;   
        8'h4b: char_code = SPACE;   
        8'h4c: char_code = SPACE;   
        8'h4d: char_code = SPACE;   
        8'h4e: char_code = SPACE;   
        8'h4f: char_code = SPACE; 

        8'h50: char_code = SPACE;     
        8'h51: char_code = SPACE;
        8'h52: char_code = SPACE;
        8'h53: char_code = SPACE;
        8'h54: char_code = SPACE;
        8'h55: char_code = SPACE;
        8'h56: char_code = SPACE;
        8'h57: char_code = SPACE;
        8'h58: char_code = SPACE;
        8'h59: char_code = SPACE;
        8'h5a: char_code = SPACE;
        8'h5b: char_code = SPACE;
        8'h5c: char_code = SPACE;
        8'h5d: char_code = SPACE;
        8'h5e: char_code = SPACE;
        8'h5f: char_code = SPACE;
     
        8'h60: char_code = SPACE;           
        8'h61: char_code = SPACE;   
        8'h62: char_code = SPACE;   
        8'h63: char_code = SPACE;   
        8'h64: char_code = SPACE;   
        8'h65: char_code = SPACE;   
        8'h66: char_code = SPACE;   
        8'h67: char_code = SPACE;   
        8'h68: char_code = SPACE;   
        8'h69: char_code = SPACE;   
        8'h6a: char_code = SPACE;   
        8'h6b: char_code = SPACE;   
        8'h6c: char_code = SPACE;   
        8'h6d: char_code = SPACE;   
        8'h6e: char_code = SPACE;   
        8'h6f: char_code = SPACE;   
        
        8'h70: char_code = SPACE;           
        8'h71: char_code = SPACE;   
        8'h72: char_code = SPACE;   
        8'h73: char_code = SPACE;  
        8'h74: char_code = SPACE;   
        8'h75: char_code = SPACE;   
        8'h76: char_code = SPACE;   
        8'h77: char_code = SPACE;   
        8'h78: char_code = SPACE;   
        8'h79: char_code = SPACE;   
        8'h7a: char_code = SPACE;   
        8'h7b: char_code = SPACE;   
        8'h7c: char_code = SPACE;   
        8'h7d: char_code = SPACE;   
        8'h7e: char_code = SPACE;   
        8'h7f: char_code = SPACE;   
        
        8'h80: char_code = SPACE;           
        8'h81: char_code = SPACE;   
        8'h82: char_code = SPACE;   
        8'h83: char_code = SPACE;   
        8'h84: char_code = SPACE;   
        8'h85: char_code = SPACE;   
        8'h86: char_code = SPACE;   
        8'h87: char_code = SPACE;   
        8'h88: char_code = SPACE;   
        8'h89: char_code = SPACE;   
        8'h8a: char_code = SPACE; 
        8'h8b: char_code = SPACE;  
        8'h8c: char_code = SPACE;   
        8'h8d: char_code = SPACE;   
        8'h8e: char_code = SPACE;   
        8'h8f: char_code = SPACE;   
       
        8'h90: char_code = SPACE;           
        8'h91: char_code = SPACE;   
        8'h92: char_code = SPACE;   
        8'h93: char_code = SPACE;   
        8'h94: char_code = SPACE;   
        8'h95: char_code = SPACE;   
        8'h96: char_code = SPACE;   
        8'h97: char_code = SPACE;   
        8'h98: char_code = SPACE;   
        8'h99: char_code = SPACE;   
        8'h9a: char_code = SPACE;   
        8'h9b: char_code = SPACE;   
        8'h9c: char_code = SPACE;   
        8'h9d: char_code = SPACE;   
        8'h9e: char_code = SPACE;   
        8'h9f: char_code = SPACE;   
        
        8'ha0: char_code = SPACE;           
        8'ha1: char_code = SPACE;   
        8'ha2: char_code = SPACE;   
        8'ha3: char_code = SPACE;   
        8'ha4: char_code = SPACE;   
        8'ha5: char_code = SPACE;   
        8'ha6: char_code = SPACE;   
        8'ha7: char_code = SPACE;   
        8'ha8: char_code = SPACE;   
        8'ha9: char_code = SPACE;   
        8'haa: char_code = SPACE; 
        8'hab: char_code = SPACE;   
        8'hac: char_code = SPACE;   
        8'had: char_code = SPACE;   
        8'hae: char_code = SPACE;   
        8'haf: char_code = SPACE;   
        
        8'hb0: char_code = SPACE;           
        8'hb1: char_code = SPACE;   
        8'hb2: char_code = SPACE;   
        8'hb3: char_code = SPACE;  
        8'hb4: char_code = SPACE;   
        8'hb5: char_code = SPACE;   
        8'hb6: char_code = SPACE;   
        8'hb7: char_code = SPACE;   
        8'hb8: char_code = SPACE;   
        8'hb9: char_code = SPACE;   
        8'hba: char_code = SPACE;   
        8'hbb: char_code = SPACE;   
        8'hbc: char_code = SPACE;   
        8'hbd: char_code = SPACE;   
        8'hbe: char_code = SPACE;   
        8'hbf: char_code = SPACE;   
       
        8'hc0: char_code = SPACE;           
        8'hc1: char_code = SPACE;   
        8'hc2: char_code = SPACE;   
        8'hc3: char_code = SPACE;   
        8'hc4: char_code = SPACE;   
        8'hc5: char_code = SPACE;   
        8'hc6: char_code = SPACE;   
        8'hc7: char_code = SPACE;   
        8'hc8: char_code = SPACE;   
        8'hc9: char_code = SPACE;   
        8'hca: char_code = SPACE;  
        8'hcb: char_code = SPACE;  
        8'hcc: char_code = SPACE;   
        8'hcd: char_code = SPACE;   
        8'hce: char_code = SPACE;   
        8'hcf: char_code = SPACE;   
      
        8'hd0: char_code = SPACE;          
        8'hd1: char_code = SPACE;   
        8'hd2: char_code = SPACE;  
        8'hd3: char_code = SPACE;   
        8'hd4: char_code = SPACE;   
        8'hd5: char_code = SPACE;   
        8'hd6: char_code = SPACE;   
        8'hd7: char_code = SPACE;   
        8'hd8: char_code = SPACE;   
        8'hd9: char_code = SPACE;   
        8'hda: char_code = SPACE;   
        8'hdb: char_code = SPACE;   
        8'hdc: char_code = SPACE;   
        8'hdd: char_code = SPACE;   
        8'hde: char_code = SPACE;   
        8'hdf: char_code = SPACE;   
      
        8'he0: char_code = SPACE;           
        8'he1: char_code = SPACE;   
        8'he2: char_code = SPACE;   
        8'he3: char_code = SPACE;   
        8'he4: char_code = SPACE;   
        8'he5: char_code = SPACE;   
        8'he6: char_code = SPACE;   
        8'he7: char_code = SPACE;   
        8'he8: char_code = SPACE;   
        8'he9: char_code = SPACE;   
        8'hea: char_code = SPACE;   
        8'heb: char_code = SPACE;   
        8'hec: char_code = SPACE;   
        8'hed: char_code = SPACE;   
        8'hee: char_code = SPACE;  
        8'hef: char_code = SPACE;  
 
        8'hf0: char_code = SPACE;   
        8'hf1: char_code = SPACE;
        8'hf2: char_code = SPACE;
        8'hf3: char_code = SPACE;
        8'hf4: char_code = SPACE;
        8'hf5: char_code = SPACE;
        8'hf6: char_code = SPACE;
        8'hf7: char_code = SPACE;
        8'hf8: char_code = SPACE;
        8'hf9: char_code = SPACE;
        8'hfa: char_code = SPACE;   
        8'hfb: char_code = SPACE;   
        8'hfc: char_code = SPACE;   
        8'hfd: char_code = SPACE;   
        8'hfe: char_code = SPACE;   
        8'hff: char_code = SPACE;        
      endcase
 
endmodule
