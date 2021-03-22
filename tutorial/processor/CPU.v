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
	`InsnAddrPath branchOut;
	logic pcWrEnable;

	//Register files
	`DataPath rfWrData;

	//ALU
	`DataPath aluInA;
	`DataPath aluInB;

	//branch
	logic brTaken;
	logic brPcWrEnable;

	//hazard detection
	logic cHazard;
	logic dHazard;
	logic hazardMuxPcWrEnable;
	logic hazardMuxIsLoadInsn;
	logic hazardMuxIsStoreInsn;
	logic hazardMuxIsSrcA_Rt;
	logic hazardMuxIsDstRt;
	logic hazardMuxRfWrEnable;
	logic hazardMuxIsALUInConstant;

	//ifid
	`InsnAddrPath ifidPCAddrOut;
	`InsnPath ifidInsnOut;
	`RegNumPath ifidRSOut;
	`RegNumPath ifidRTOut;

	//dead variable
	`OpPath idexOpIn;
	`ShamtPath idexShamtIn;
	`FunctPath idexFunctIn;

	//idex
	`InsnAddrPath idexPCAddrIn;
	`RegNumPath idexRSIn;
	`RegNumPath idexRTIn;
	`RegNumPath idexRDIn;
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


	`InsnAddrPath idexPCAddrOut;
	`RegNumPath idexRSOut;
	`RegNumPath idexRTOut;
	`RegNumPath idexRDOut;
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
	`InsnAddrPath exmemPCAddrIn;
	`DataPath exmemALUOutIn;
	`BrCodePath exmemBrCodeIn;
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

	`InsnAddrPath exmemPCAddrOut;
	`DataPath exmemALUOutOut;
	`BrCodePath exmemBrCodeOut;
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
	`RegNumPath memwbRSIn;
	`RegNumPath memwbRTIn;
	`RegNumPath memwbRDIn;

	`DataPath memwbDataOut;
	`DataPath memwbAluOutOut;
	`RegNumPath memwbWrNumOut;
	logic memwbIsLoadInsnOut;
	logic memwbRfWrEnableOut;
	`RegNumPath memwbRSOut;
	`RegNumPath memwbRTOut;
	`RegNumPath memwbRDOut;

	//forwardcode
	`ForwardCodePath forwardA;
	`ForwardCodePath forwardB;
	`ForwardCodePath forwardC;
	`ForwardCodePath forwardD;
	`DataPath selectedA;
	`DataPath selectedB;
	`DataPath selectedC;
	`DataPath selectedD;

	IFID ifid(
		//common
		clk,
		rst,
		cHazard,
		dHazard,
		//input
		pcOut,
		insn,
		//output
		ifidPCAddrOut,
		ifidInsnOut,

		ifidRSOut,
		ifidRTOut
	);


	IDEX idex(
		//common
		clk,
		rst,

		//input
		idexPCAddrIn,
	
		idexIsDstRtIn,
		idexPcWrEnableIn,
		idexIsLoadInsnIn,
		idexIsStoreInsnIn,
		idexIsSrcA_RtIn,
		idexRfWrEnableIn,
		idexIsALUInConstantIn,
		idexBrCodeIn,
		idexALUCodeIn,

		selectedC,
		selectedD,
		idexConstatnIn,

		idexRSIn,
		idexRTIn,
		idexRDIn,

		//output
		idexPCAddrOut,

		idexIsDstRtOut,
		idexPcWrEnableOut,
		idexIsLoadInsnOut,
		idexIsStoreInsnOut,
		idexIsSrcA_RtOut,
		idexRfWrEnableOut,
		idexIsALUInConstantOut,
		idexBrCodeOut,
		idexALUCodeOut,

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

		exmemPCAddrIn,
		exmemALUOutIn,
		exmemBrCodeIn,
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

		exmemPCAddrOut,
		exmemALUOutOut,
		exmemBrCodeOut,
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
		memwbRSIn,
		memwbRTIn,
		memwbRDIn,

		memwbDataOut,
		memwbAluOutOut,
		memwbWrNumOut,
		memwbIsLoadInsnOut,
		memwbRfWrEnableOut,
		memwbRSOut,
		memwbRTOut,
		memwbRDOut
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
	
		hazardMuxPcWrEnable,
		hazardMuxIsLoadInsn,
		hazardMuxIsStoreInsn,
		hazardMuxIsSrcA_Rt,
		hazardMuxIsDstRt,
		hazardMuxRfWrEnable,
		hazardMuxIsALUInConstant,

		ifidInsnOut
	);

	HazardMux hazardmux(
		hazardMuxPcWrEnable,
		hazardMuxIsLoadInsn,
		hazardMuxIsStoreInsn,
		hazardMuxIsSrcA_Rt,
		hazardMuxIsDstRt,
		hazardMuxRfWrEnable,
		hazardMuxIsALUInConstant,
		dHazard,

		idexPcWrEnableIn,
		idexIsLoadInsnIn,
		idexIsStoreInsnIn,
		idexIsSrcA_RtIn,
		idexIsDstRtIn,
		idexRfWrEnableIn,
		idexIsALUInConstantIn
	);

	InsnFeeder insnfeeder(
		//output
		insnAddr,
		//input
		pcOut,
		dHazard,
		branchOut,
		brPcWrEnable
	);

	PC pc(
		clk,
		rst,
		dHazard,
		//output
		pcOut,
		//input
		branchOut,
		brPcWrEnable
	);

	BranchUnit branch(
		//output
		branchOut,
		brTaken,
		brPcWrEnable,

		//input
		idexPCAddrIn,
		idexBrCodeIn,
		idexRdDataAIn,
		idexRdDataBIn,
		idexConstatnIn,
		idexPcWrEnableIn
	);

	RegisterFile regFile(
		clk,
		rst,
		
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

	Forward forward(
		exmemRfWrEnableOut,
		exmemIsLoadInsnOut,
		exmemWrNumOut,
		idexRSOut,
		idexRTOut,
		ifidRSOut,
		ifidRTOut,
		memwbRfWrEnableOut,
		memwbWrNumOut,

		forwardA,
		forwardB,
		forwardC,
		forwardD
	);

	//this guy takes care of forwarding RS register
	ForwardMUXAfter forwardRS(
		idexRdDataAOut,
		exmemALUOutOut,
		rfWrData,
		forwardA,
		selectedA
	);

	ForwardMUXAfter forwardRT(
		idexRdDataBOut,
		exmemALUOutOut,
		rfWrData,
		forwardB,
		selectedB
	);

	ForwardMUXBefore ForwardRSb(
		idexRdDataAIn,
		rfWrData,
		forwardC,
		selectedC
	);

	ForwardMUXBefore ForwardRTb(
		idexRdDataBIn,
		rfWrData,
		forwardD,
		selectedD
	);

	Hazard hazard(
		clk,
		rst,

		ifidRSOut,
		ifidRTOut,
		idexRDOut,
		idexRTOut,
		exmemRTOut,

		idexOpIn,
		idexRfWrEnableOut,
		exmemRfWrEnableOut,
		idexIsLoadInsnOut,
		exmemIsLoadInsnOut,

		brTaken,
		cHazard,
		dHazard
	);

	always_comb begin
		cHazard = `FALSE;

		//directly forwarding between pipeline registers
		idexPCAddrIn = ifidPCAddrOut;

		exmemPCAddrIn = idexPCAddrOut;
		exmemBrCodeIn = idexBrCodeOut;
		exmemRfWrEnableIn = idexRfWrEnableOut;
		exmemIsStoreInsnIn = idexIsStoreInsnOut;
		exmemIsLoadInsnIn = idexIsLoadInsnOut;
		exmemPcWrEnableIn = idexPcWrEnableOut;

		exmemRdDataAIn = selectedA;
		exmemRdDataBIn = selectedB;
		exmemConstantIn = idexConstantOut;
		exmemRSIn = idexRSOut;
		exmemRTIn = idexRTOut;
		exmemRDIn = idexRDOut;

		memwbAluOutIn = exmemALUOutOut;
		memwbRfWrEnableIn = exmemRfWrEnableOut;
		memwbIsLoadInsnIn = exmemIsLoadInsnOut;
		memwbWrNumIn = exmemWrNumOut;
		memwbRSIn = exmemRSOut;
		memwbRTIn = exmemRTOut;
		memwbRDIn = exmemRDOut;

		dataOut = exmemRdDataBOut;
		dataAddr = exmemRdDataAOut[ `DATA_ADDR_WIDTH - 1 : 0 ] + `EXPAND_ADDRESS( exmemConstantOut );

		rfWrData = memwbIsLoadInsnOut ? memwbDataOut : memwbAluOutOut;
		exmemWrNumIn = idexIsDstRtOut ? idexRTOut : idexRDOut;

		aluInA = idexIsSrcA_RtOut ? selectedB : selectedA;
		aluInB = idexIsALUInConstantOut ? idexConstantOut : selectedB;

		dataWrEnable = exmemIsStoreInsnOut;
	end

endmodule

