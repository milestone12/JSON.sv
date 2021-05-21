module json_tb;

	import json::*;

	function automatic void f_create();
		Array a;
		Boolean b;
		Null nul;
		Number num;
		a = Array::new();
		b = Boolean::new(1);
		nul = Null::new();
		num = Number::new(42.0);
		$display("");
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
