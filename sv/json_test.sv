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
program json_test;

	/* Import JSON package to make the API available */
	import json::*;

	function automatic void f_create();
		int fd;
		int res;
		string s, t;
		/* Special string class that extends the SystemVerilog string
		* with some capabilitites that C++ STL strings have */
		util::String r_str;
		Object root;
		Object waehrung, deckung, inhaber, hobbys, golfen, o;
		Array a;

		/* Load the JSON object tree from JSON formatted file */
		root = json::Load("../../../json.json");

		/* Dump the JSON string and print it as a log message */
		r_str = new();
		root.dumpS(r_str);
		$display(r_str.get());

		/* Object getter examples */
		waehrung = root.getByKey("Waehrung"); /* Get child object by key */
		deckung  = root.getByKey("Deckung");
		inhaber  = root.getByKey("Inhaber");
		hobbys   = inhaber.getByKey("Hobbys");
		golfen   = hobbys.getByIndex(1); /* Get array element by index */

		/* Object / tree manipulation examples */
		root.delete("Nummer"); /* Delete child object */
		$cast(a, hobbys);
		a.delete(1); /* Delete array element */
		a = Array::new(); /* Create new array object */
		a.append(Boolean::new(0)); /* Append new objects to array */
		a.append(Number::new(42));
		a.append(String::new("Hallo Welt!"));
		root.append("Sonstiges", a); /* Append array as a child object */

		/* Dump the manipulated JSON object tree */
		r_str = new();
		root.dumpS(r_str);
		$display(r_str.get());

		/* Object attribute query methods */
		$display("%b", hobbys.isArray());
		$display("%b", root.isTrue());
		$display("%b", root.isNull());
		$display("%d", a.size());
		$display("%s", waehrung.asString());
		$display("%f", deckung.asReal());

		/* Write the manipulated JSON object tree out to a file */
		root.dump("./json_out.json");
	endfunction

	initial
	begin
		f_create();
	end

endprogram
