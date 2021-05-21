module json_tb;

	import json::*;

	function automatic void f_create();
		Array a;
		Boolean b;
		Null nul;
		Number num;
		String s;
		a = Array::new();
		b = Boolean::new(1);
		nul = Null::new();
		num = Number::new(42.0);
		s = String::new("hello world!");
		$display("");
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
