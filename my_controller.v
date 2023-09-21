module my_controller
(
  input  wire [2:0] opcode ,
  input  wire [2:0] phase  ,
  input  wire       zero   , 
  output reg        sel    , 
  output reg        rd     , 
  output reg        ld_ir  ,
  output reg        inc_pc ,
  output reg        halt   ,
  output reg        ld_pc  ,
  output reg        data_e ,
  output reg        ld_ac  , 
  output reg        wr       
);

localparam HLT=3'd0, SKZ=3'd1, ADD=3'd2, AND=3'd3, XOR=3'd4, LDA=3'd5, STO=3'd6, JMP=3'd7;

localparam INST_ADDR=0, INST_FETCH=1, INST_LOAD=2, IDLE=3, OP_ADDR=4, OP_FETCH=5, ALU_OP=6, STORE=7;

reg ALUOP,S_Z,H,J,S;

always @* begin

	ALUOP = (opcode == ADD || opcode == AND || opcode == XOR || opcode == LDA);
    S_Z = (opcode == SKZ && zero);
	H = (opcode == HLT);
    J = (opcode == JMP);
    S = (opcode == STO);
	case ( phase )
  0:begin sel=1;rd=0;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;end
  1:begin sel=1;rd=1;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;end
  2:begin sel=1;rd=1;ld_ir=1;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;end
  3:begin sel=1;rd=1;ld_ir=1;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;end
  4:begin sel=0;rd=0;ld_ir=0;inc_pc=1;halt=H;ld_pc=0;data_e=0;ld_ac=0;wr=0;end
  5:begin sel=0;rd=ALUOP;ld_ir=0;inc_pc=0;halt=0;ld_pc=0;data_e=0;ld_ac=0;wr=0;end
  6:begin sel=0;rd=ALUOP;ld_ir=0;inc_pc=S_Z;halt=0;ld_pc=J;data_e=S;ld_ac=0;wr=0;end
  7:begin sel=0;rd=ALUOP;ld_ir=0;inc_pc=0;halt=0;ld_pc=J;data_e=S;ld_ac=ALUOP;wr=S;end
      endcase
	end
endmodule