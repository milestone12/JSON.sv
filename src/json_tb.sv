module json_tb;

	import json::*;

	function automatic void f_create();
		Boolean o;
		bit b;
		o = Boolean::new(1);
		b = o.isTrue();
		$display("true: %b", b);
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
