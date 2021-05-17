module json_tb;

	import json::*;

	function automatic f_create();
		automatic Object o;
		automatic Boolean b;
		b = Boolean::new();
		o = b;
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
