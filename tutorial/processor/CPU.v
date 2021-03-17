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

	//Register files
	`DataPath rfWrData;

	//ALU
	`DataPath aluOut;
	`DataPath aluInA;
	`DataPath aluInB;

	//hazard detection
	logic cHazard;
	//ifid
	`InsnAddrPath ifidPCAddrOut;
	`InsnPath ifidInsnOut;

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
	`ConstantPath idexConstantOut;
	`ALUCodePath idexALUCodeOut;
	`BrCodePath idexBrCodeOut;

	logic idexPcWrEnableOut;
	logic idexIsLoadInsnOut;
	logic idexIsStoreInsnOut;
	logic idexIsSrcA_RtOut;
	logic idexIsDstRtOut;
	logic idexRfWrEnableOut;
	logic idexIsALUInConstantOut;

	`DataPath idexRdDataAOut;
	`DataPath idexRdDataBOut;

	//exmem
	`InsnAddrPath exmemInsnIn;
	`DataPath exmemALUOutIn;
	`BrCodePath exmemBrCodeIn;
	logic exmemIsDstRtIn;
	logic exmemRfWrEnableIn;
	logic exmemIsStoreInsnIn;
	logic exmemIsLoadInsnIn;
	logic exmemPcWrEnableIn;

	`DataPath exmemRdDataAIn;
	`DataPath exmemRdDataBIn;
	`ConstantPath exmemConstantIn;
	`RegNumPath exmemWrNumIn;
	`RegNumPath exmemRSIn;
	`RegNumPath exmemRTIn;
	`RegNumPath exmemRDIn;

	`InsnAddrPath exmemInsnOut;
	`DataPath exmemALUOutOut;
	`BrCodePath exmemBrCodeOut;
	logic exmemIsDstRtOut;
	logic exmemRfWrEnableOut;
	logic exmemIsStoreInsnOut;
	logic exmemIsLoadInsnOut;
	logic exmemPcWrEnableOut;

	`DataPath exmemRdDataAOut;
	`DataPath exmemRdDataBOut;
	`ConstantPath exmemConstantOut;
	`RegNumPath exmemWrNumOut;
	`RegNumPath exmemRSOut;
	`RegNumPath exmemRTOut;
	`RegNumPath exmemRDOut;

	//memwb
	`DataPath memwbAluOutIn;
	`RegNumPath memwbWrNumIn;
	logic memwbIsLoadInsnIn;
	logic memwbRfWrEnableIn;

	`DataPath memwbDataOut;
	`DataPath memwbAluOutOut;
	`RegNumPath memwbWrNumOut;
	logic memwbIsLoadInsnOut;
	logic memwbRfWrEnableOut;


	IFID ifid(
		//common
		clk,
		rst,
		cHazard,
		//input
		pcOut,
		insn,
		//output
		ifidPCAddrOut,
		ifidInsnOut
	);


	IDEX idex(
		//common
		clk,
		rst,
		cHazard,

		//input
		idexInsnIn,
	
		idexIsDstRtIn,
		idexPcWrEnableIn,
		idexIsLoadInsnIn,
		idexIsStoreInsnIn,
		idexIsSrcA_RtIn,
		idexRfWrEnableIn,
		idexIsALUInConstantIn,
		idexBrCodeIn,
		idexALUCodeIn,

		idexShamtIn,
		idexFunctIn,
		idexRdDataAIn,
		idexRdDataBIn,
		idexConstatnIn,

		idexRSIn,
		idexRTIn,
		idexRDIn,

		//output
		idexInsnOut,

		idexIsDstRtOut,
		idexPcWrEnableOut,
		idexIsLoadInsnOut,
		idexIsStoreInsnOut,
		idexIsSrcA_RtOut,
		idexRfWrEnableOut,
		idexIsALUInConstantOut,
		idexBrCodeOut,
		idexALUCodeOut,

		idexShamtOut,
		idexFunctOut,
		idexRdDataAOut,
		idexRdDataBOut,
		idexConstantOut,

		idexRSOut,
		idexRTOut,
		idexRDOut
	);

	EXMEM exmem(
		clk,
		rst,
		cHazard,

		exmemInsnIn,
		exmemALUOutIn,
		exmemBrCodeIn,
		exmemIsDstRtIn,
		exmemRfWrEnableIn,
		exmemIsStoreInsnIn,
		exmemIsLoadInsnIn,
		exmemPcWrEnableIn,

		exmemRdDataAIn,
		exmemRdDataBIn,
		exmemConstantIn,
		exmemWrNumIn,
		exmemRSIn,
		exmemRTIn,
		exmemRDIn,

		exmemInsnOut,
		exmemALUOutOut,
		exmemBrCodeOut,
		exmemIsDstRtOut,
		exmemRfWrEnableOut,
		exmemIsStoreInsnOut,
		exmemIsLoadInsnOut,
		exmemPcWrEnableOut,

		exmemRdDataAOut,
		exmemRdDataBOut,
		exmemConstantOut,
		exmemWrNumOut,
		exmemRSOut,
		exmemRTOut,
		exmemRDOut
	);


	MEMWB memwb(
		clk,
		rst,

		dataIn,
		memwbAluOutIn,
		memwbWrNumIn,
		memwbIsLoadInsnIn,
		memwbRfWrEnableIn,

		memwbDataOut,
		memwbAluOutOut,
		memwbWrNumOut,
		memwbIsLoadInsnOut,
		memwbRfWrEnableOut
	);

	Decoder decoder(
		idexOpIn,
		idexRSIn,
		idexRTIn,
		idexRDIn,
		idexShamtIn,
		idexFunctIn,
		idexConstatnIn,
		idexALUCodeIn,
		idexBrCodeIn,
	
		idexPcWrEnableIn,
		idexIsLoadInsnIn,
		idexIsStoreInsnIn,
		idexIsSrcA_RtIn,
		idexIsDstRtIn,
		idexRfWrEnableIn,
		idexIsALUInConstantIn,

		ifidInsnOut
	);



	PC pc(
		clk,
		rst,
		//output
		pcOut,
		//input
		pcIn,
		exmemPcWrEnableOut
	);

	BranchUnit branch(
		//output
		pcIn,

		//input
		pcOut,
		exmemBrCodeOut,
		exmemRdDataAOut,
		exmemRdDataBOut,
		exmemConstantOut
	);

	RegisterFile regFile(
		clk,

		idexRdDataAIn,
		idexRdDataBIn,

		idexRSIn,
		idexRTIn,

		rfWrData,
		memwbWrNumOut,
		memwbRfWrEnableOut
	);

	ALU alu(
		exmemALUOutIn,
	
		aluInA,
		aluInB,
		idexALUCodeOut
	);

	always_comb begin
		cHazard = `FALSE;

		//directly forwarding between pipeline registers
		idexInsnIn = ifidInsnOut;

		exmemInsnIn = idexInsnOut;
		exmemBrCodeIn = idexBrCodeOut;
		exmemIsDstRtIn = idexIsDstRtOut;
		exmemRfWrEnableIn = idexRfWrEnableOut;
		exmemIsStoreInsnIn = idexIsStoreInsnOut;
		exmemIsLoadInsnIn = idexIsLoadInsnOut;
		exmemPcWrEnableIn = idexPcWrEnableOut;

		exmemRdDataAIn = idexRdDataAOut;
		exmemRdDataBIn = idexRdDataBOut;
		exmemConstantIn = idexConstantOut;
		exmemRSIn = idexRSOut;
		exmemRTIn = idexRTOut;
		exmemRDIn = idexRDOut;


		insnAddr = pcIn;

		dataOut = exmemRdDataBOut;
		dataAddr = exmemRdDataAOut[ `DATA_ADDR_WIDTH - 1 : 0 ] + `EXPAND_ADDRESS( exmemConstantOut );

		rfWrData = memwbIsLoadInsnOut ? memwbDataOut : memwbAluOutOut;
		exmemWrNumIn = idexIsDstRtOut ? idexRTOut : idexRDOut;

		aluInA = idexIsSrcA_RtOut ? idexRdDataBOut : idexRdDataAOut;
		aluInB = idexIsALUInConstantOut ? idexConstantOut : idexRdDataBOut;

		dataWrEnable = exmemIsStoreInsnOut;
	end

endmodule

