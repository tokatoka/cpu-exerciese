//
// 検証用モジュール
//



// 基本的な型を定義したファイルの読み込み
`include "Types.v" 



// シミュレーションの単位時間の設定
// #~ と書いた場合，この時間が経過する．
`timescale 1ns/1ns


//
// 全体の検証用モジュール
//
module H3_MainSim;

	parameter CYCLE_TIME = 200; // 1サイクルを 200ns に設定

	integer i;

	integer cycle;		// サイクル
	integer cycleX4;	// 4倍速サイクル

	logic countCycle;

	logic clkX4;		// 4倍速クロック
	logic rst;

	logic sigCH;
	logic sigCE;
	logic sigCP;

	`DD_OutArray led;
	`DD_GateArray	gate;
	`LampPath lamp;	// Lamp?
	

	// Main モジュール
	Main main(
		sigCH,
		sigCE,
		sigCP,

		led,
		gate,
		lamp,	// Lamp?
		clkX4,	// 4倍速クロック
		rst 	// リセット（0でリセット）
	);

	// 検証動作を記述する
	initial begin
		
		//
		// 初期化
		//
		for( i = 0; i < `REG_FILE_SIZE; i++ ) begin
			main.cpu.regFile.strage[ i ] = 32'hcdcdcdcd;
		end
		
		main.cpu.pc.pc = 0;
		sigCE = 1'b1;
		sigCH = 1'b1;
		sigCP = 1'b1;

		
		//
		// リセット
		//
		rst = 1'b0;
		#(CYCLE_TIME/8*3)

		rst = 1'b1;
		#(CYCLE_TIME/8)
		#(CYCLE_TIME)
		#(CYCLE_TIME)
		
		// CH On
		sigCH = 1'b0;

		//
		// シミュレーション開始
		//

		// 70 サイクル 
		#(CYCLE_TIME*70)
		sigCP = 1'b0;

		// 40
		#(CYCLE_TIME*40)
		sigCP = 1'b1;

		// 10
		#(CYCLE_TIME*10)
		sigCP = 1'b0;

		// 100 サイクル 
		#(CYCLE_TIME*1000)
		$finish;


     
	end

	// クロック
	initial begin 
		countCycle = 0;
		clkX4   = 1'b1;
		cycleX4 = 0;
		cycle = 0;
		
	    forever #(CYCLE_TIME / 2 / 4) begin
	
			// 4倍速
	    	clkX4 = !clkX4 ;
	    	
	    	if( countCycle ) begin

				cycleX4 = cycleX4 + 1;
				// 等速
				if( cycleX4 % 8 == 0 ) begin
			    	cycle = cycle + 1 ;
			    end

			end
			
		    
		    // カウント開始
		    if( rst && clkX4 ) begin
		    	countCycle = 1;
		    end
	    end
	end

endmodule


