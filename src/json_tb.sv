module json_tb;

	import json::*;

	function automatic void f_create();
		int fd;
		int res;
		string s, t;
		util::String r_str;
		Object root;
		Object waehrung, inhaber, hobbys, golfen, o;
		Array a;

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

		r_str = new();
		root.dumpS(r_str);

		waehrung = root.getByKey("Waehrung");
		inhaber = root.getByKey("Inhaber");
		hobbys = inhaber.getByKey("Hobbys");
		golfen = hobbys.getByIndex(1);

		root.delete("Nummer");
		$cast(a, hobbys);
		a.delete(1);
		a = Array::new();
		a.append(Boolean::new(0));
		a.append(Number::new(42));
		a.append(String::new("Hallo Welt!"));
		root.append("Sonstiges", a);

		r_str = new();
		root.dumpS(r_str);

		$display(r_str.get());

		fd = $fopen("../../../src/json_out.json", "w");
		if (!fd) begin
			return;
		end
		$fwrite(fd, r_str.get());
		$fclose(fd);
	endfunction

	initial
	begin
		f_create();
		$finish;
	end

endmodule
