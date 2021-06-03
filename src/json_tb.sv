module json_tb;

	import json::*;

	function automatic void f_create();
		int fd;
		int res;
		string s, t;
		Object root;
		Object waehrung, inhaber, hobbys, golfen;

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

		waehrung = root.getByKey("Waehrung");
		inhaber = root.getByKey("Inhaber");
		hobbys = inhaber.getByKey("Hobbys");
		golfen = hobbys.getByIndex(1);

		$display("");
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
