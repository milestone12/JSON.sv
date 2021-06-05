/*
 * Copyright 2021 Alexander Preissner
 * SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
 * 
 * Licensed under the Solderpad Hardware License v 2.1 (the “License”);
 * you may not use this file except in compliance with the License, or, at your
 * option, the Apache License version 2.0.
 * You may obtain a copy of the License at
 * 
 * https://solderpad.org/licenses/SHL-2.1/
 * 
 * Unless required by applicable law or agreed to in writing, any work
 * distributed under the License is distributed on an “AS IS” BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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

		fd = $fopen("../../../json.json", "r");
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

		fd = $fopen("./json_out.json", "w");
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
