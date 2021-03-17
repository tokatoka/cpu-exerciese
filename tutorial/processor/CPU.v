`include "Types.v"

module CPU(

	input logic clk,	// クロック
	input logic rst,	// リセット
	
	output `InsnAddrPath insnAddr,		// 命令メモリへのアドレス出力
	output `DataAddrPath dataAddr,		// データバスへのアドレス出力
	output `DataPath     dataOut,		// 書き込みデータ出力
										// dataAddr で指定したアドレスに対して書き込む値を出力する．
	output logic         dataWrEnable,	// データ書き込み有効

	input  `InsnPath 	 insn,			// 命令メモリからの入力
	input  `DataPath     dataIn			// 読み出しデータ入力
										// dataAddr で指定したアドレスから読んだ値が入力される．
);
	
	//PC
	`InsnAddrPath pcOut;
	`InsnAddrPath pcIn;
	logic pcWrEnable;

	//IMem
	`InsnPath imemInsnCode;

	//Decoder
	`OpPath dcOp;
	`RegNumPath dcRS;
	`RegNumPath dcRT;
	`RegNumPath dcRD;
	`ShamtPath dcShamt;
	`FunctPath dcFunct;
	`ConstantPath dcConstant;
	`ALUCodePath dcALUCode;
	`BrCodePath dcBrCode;
	logic dcIsSrcA_Rt;
	logic dcIsDstRt;
	logic dcIsALUInConstant;
	logic dcIsLoadInsn;
	logic dcIsStoreInsn;

	//Register files
	`DataPath rfRdDataS;
	`DataPath rfRdDataT;
	`DataPath rfWrData;
	`RegNumPath rfWrNum;
	logic rfWrEnable;

	//ALU
	`DataPath aluOut;
	`DataPath aluInA;
	`DataPath aluInB;

	logic brTaken;

	//hazard detection
	logic cHazard;
	//ifid
	logic `InsnAddrPath ifidPCAddrOut;
	logic `InsnPath ifidInsnOut;

	//idex
	`InsnAddrPath idexInsnIn;
	`OpPath idexOpIn;
	`RegNumPath idexRSIn;
	`RegNumPath idexRTIn;
	`RegNumPath idexRDIn;
	`ShamtPath idexShamtIn;
	`FunctPath idexFunctIn;
	`ConstantPath idexConstatnIn;
	`ALUCodePath idexALUCodeIn;
	`BrCodePath idexBrCodeIn;

	logic idexPcWrEnableIn;
	logic idexIsLoadInsnIn;
	logic idexIsStoreInsnIn;
	logic idexIsSrcA_RtIn;
	logic idexIsDstRtIn;
	logic idexRfWrEnableIn;
	logic idexIsALUInConstantIn;

	`DataPath idexRdDataAIn;
	`DataPath idexRdDataBIn;



	`InsnAddrPath idexInsnOut;
	`RegNumPath idexRSOut;
	`RegNumPath idexRTOut;
	`RegNumPath idexRDOut;
	`ShamtPath idexShamtOut;
	`FunctPath idexFunctOut;
	`ConstantPath idexConstatnOut;
	`ALUCodePath idexALUCodeOut;
	`BrCodePath idexBrCodeOut;

	logic idexPcWrEnableOut;
	logic idexIsLoadInsnOut;
	logic idexIsStoreInsnOut;
	logic idexIsSrcA_RtOut;
	logic idexIsDstRtOut;
	logic idexRfWrEnableout;
	logic idexIsALUInConstantOut;

	`DataPath idexRdDataAOut;
	`DataPath idexRdDataBOut;

	IFID ifid(
		//common
		.clk,
		.rst,
		.cHazard,
		//input
		.pcOut,
		.insn,
		//output
		.ifidPCAddrOut,
		.ifidInsnOut,
	);

	IDEX idex(
		//common
		.clk,
		.rst,
		.cHazard,

		//input
		.idexInsnIn,
		
		.idexIsDstRtIn,
		.idexPcWrEnableIn,
		.idexIsLoadInsnIn,
		.idexIsStoreInsnIn,
		.idexIsSrcA_RtIn,
		.idexRfWrEnableIn,
		.idexIsALUInConstantIn,
		.idexBrCodeIn,
		.idexALUCodeIn,

		.idexShamtIn,
		.idexFunctIn,
		.idexRdDataAIn,
		.idexRdDataBIn,
		.idexConstatnIn,

		.idexRSIn,
		.idexRTIn,
		.idexRDIn,

		//output
		.idexInsnOut,

		.idexIsDstRtOut,
		.idexPcWrEnableOut,
		.idexIsLoadInsnOut,
		.idexIsStoreInsnOut,
		.idexIsSrcA_RtOut,
		.idexRfWrEnableout,
		.idexIsALUInConstantOut,
		.idexBrCodeOut,
		.idexALUCodeOut,

		.idexShamtOut,
		.idexFunctOut,
		.idexRdDataAOut,
		.idexRdDataBOut,
		.idexConstantOut,

		.idexRSOut,
		.idexRTOut,
		.idexRDOut,
	);

	EXMEM exmem(

	);

	MEMWB(

	);

	Decoder decoder(
		.idexOpIn,
		.idexRSIn,
		.idexRTIn,
		.idexRDIn,
		.idexShamtIn,
		.idexFunctIn,
		.idexConstatnIn,
		.idexALUCodeIn,
		.idexBrCodeIn,
		
		.idexPcWrEnableIn,
		.idexIsLoadInsnIn,
		.idexIsStoreInsnIn,
		.idexIsSrcA_RtIn,
		.idexIsDstRtIn,
		.idexRfWrEnableIn,
		.idexIsALUInConstantIn,

		.ifidInsnOut
	);



	PC pc(
		.addrOut ( pcOut ),
		.clk ( clk ),
		.rst ( rst ),
		.addrIn ( pcIn ),
		.wrEnable ( pcWrEnable )
	);

	BranchUnit branch(
		.pcOut ( pcIn ),
		.pcIn ( pcOut ),
		.brCode ( dcBrCode ),
		.regRS ( rfRdDataS ),
		.regRT ( rfRdDataT ),
		.constant ( dcConstant )
	);

	RegisterFile regFile(
		.clk,

		.idexRdDataAIn,
		.idexRdDataBIn,

		.idexRSIn,
		.idexRTIn,

		.wrData ( rfWrData ),
		.wrNum ( rfWrNum ),
		.wrEnable ( rfWrEnable )
	);

	ALU alu(
		.aluOut ( aluOut ),
		
		.aluInA ( aluInA ),
		.aluInB ( aluInB ),
		.code ( dcALUCode )
	);

	always_comb begin
		cHazard = `FALSE;

		idexInsnIn = ifidInsnOut;


		imemInsnCode = insn;
		insnAddr = pcOut;

		dataOut = rfRdDataT;
		dataAddr = rfRdDataS[ `DATA_ADDR_WIDTH - 1 : 0 ] + `EXPAND_ADDRESS( dcConstant );

		rfWrData = dcIsLoadInsn ? dataIn : aluOut;
		rfWrNum = dcIsDstRt ? dcRT : dcRD;

		aluInA = dcIsSrcA_Rt ? rfRdDataT : rfRdDataS;
		aluInB = dcIsALUInConstant ? dcConstant : rfRdDataT;

		dataWrEnable = dcIsStoreInsn;
	end

endmodule

