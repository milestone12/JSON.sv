module json_tb;

	import json::*;

	function automatic void f_create();
		int fd;
		int res;
		string s, t;
		Object root;

		fd = $fopen("../../../src/json.json", "r");
		if (!fd) begin
			return;
		end

		while (!$feof(fd)) begin
			res = $fgets(t, fd);
			s = {s, t};
		end
		$fclose(fd);

		root = json::LoadS(util::String::new(s));

		$display("");
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
