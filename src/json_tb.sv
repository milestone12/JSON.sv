module json_tb;

	import json::*;

	function automatic void f_create();
		Array a;
		Boolean b;
		Null n;
		a = Array::new();
		b = Boolean::new(1);
		n = Null::new();
		$display("");
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
