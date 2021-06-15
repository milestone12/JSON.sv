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
package json;

	class Object;
		/* Attributes */
		local Object m_Elements[string];
		protected static int unsigned n_dump_depth = 0;

		/* Methods */
		extern function new ();

		extern static function automatic Object Create (
			ref util::String r_str
		);

		extern function automatic void append (
			input string key,
			input Object elem
		);

		extern function automatic void delete (
			input string key
		);

		extern virtual protected function automatic void fromString (
			ref util::String r_str
		);

		extern virtual protected function automatic bit parseElement (
			ref util::String r_str
		);

		extern protected function automatic string parseKey (
			ref util::String r_str
		);

		extern protected function automatic Object parseObject (
			ref util::String r_str
		);

		extern virtual function automatic Object getByKey (
			input string key
		);
		extern virtual function automatic Object getByIndex (
			input int unsigned index
		);

		extern virtual function automatic bit isArray();
		extern virtual function automatic bit isTrue();
		extern virtual function automatic bit isNull();
		extern virtual function automatic int unsigned size();
		extern virtual function automatic string asString();
		extern virtual function automatic real asReal();

		extern virtual function automatic void dumpS(
			ref util::String r_str
		);

		extern function automatic void dump (
			input string file_path
		);
	endclass

	class Array extends Object;
		/* Attributes */
		local Object m_Elements[$];
		
		/* Methods */
		extern function new ();

		extern static function automatic Array Create (
			ref util::String r_str
		);

		extern function automatic void append (
			input Object elem
		);

		extern function automatic void delete (
			input int unsigned index
		);

		extern virtual protected function automatic bit parseElement (
			ref util::String r_str
		);

		extern virtual function automatic Object getByIndex (
			input int unsigned index
		);

		extern virtual function automatic bit isArray();
		extern virtual function automatic int unsigned size();

		extern local function automatic void dumpS(
			ref util::String r_str
		);
	endclass

	class Boolean extends Object;
		/* Attributes */
		local bit m_bool;

		/* Methods */
		extern function new(
			input bit b = 0
		);

		extern function automatic bit isTrue();

		extern local function automatic void dumpS(
			ref util::String r_str
		);
	endclass

	class Null extends Object;
		/* Methods */
		extern function new();

		extern virtual function automatic bit isNull();

		extern local function automatic void dumpS(
			ref util::String r_str
		);
	endclass

	class Number extends Object;
		/* Attributes */
		local real m_number;

		/* Methods */
		extern function new (
			input real num = 0.0
		);

		extern virtual function automatic real asReal();

		extern local function automatic void dumpS(
			ref util::String r_str
		);
	endclass

	class String extends Object;
		/* Attributes */
		local string m_string;

		/* Methods */
		extern function new (
			input string s = ""
		);

		extern virtual function automatic string asString();

		extern local function automatic void dumpS(
			ref util::String r_str
		);
	endclass

	function automatic Object LoadS (
		input util::String s
	);
		Object o;
		int n_start;
		string t;

		n_start = s.find_first_not_of(" \t\n");

		if (s.at(n_start) == "{") begin
			s = s.substr(n_start + 1);
		end else begin
			s = s.substr(n_start);
		end

		o = Object::Create(s);
		t = s.get();

		return o;
	endfunction

	function automatic Object Load (
		input string file_path
	);
		int fd;
		int res;
		string s, t;

		/* Open the JSON-formatted text file */
		fd = $fopen(file_path, "r");
		if (!fd) begin
			$error("Could not open file %s", file_path);
			return null;
		end

		/* Read all lines in the text file into a string */
		while (!$feof(fd)) begin
			res = $fgets(t, fd);
			s = {s, t};
		end
		$fclose(fd);

		return LoadS(util::String::new(s));
	endfunction


	function Object::new ();
	endfunction

	function automatic Object Object::Create (
		ref util::String r_str
	);
		Object o;

		if (r_str.at(0) == "[") begin
			Array a;
			r_str = r_str.substr(1);
			a = new();
			o = a;
		end else begin
			o = new();
			o.fromString(r_str);
		end

		return o;
	endfunction

	function automatic void Object::append (
		input string key,
		input Object elem
	);
		m_Elements[key] = elem;
	endfunction

	function automatic void Object::delete (
		input string key
	);
		if (m_Elements.exists(key)) begin
			m_Elements.delete(key);
		end
	endfunction

	function automatic void Object::fromString (
		ref util::String r_str
	);
		if (r_str != null) begin
			while (parseElement(r_str)) begin
			end
		end
	endfunction

	function automatic bit Object::parseElement (
		ref util::String r_str
	);
		Object o;
		string key = parseKey(r_str);

		if (key.len() == 0) begin
			return 0;
		end

		o  = parseObject(r_str);
		if (o != null) begin
			m_Elements[key] = o;
		end else begin
			return 0;
		end

		return 1;
	endfunction;

	function automatic string Object::parseKey (
		ref util::String r_str
	);
		string s;
		util::String key;
		int n_start, n_stop;

		n_start = r_str.find("\"");
		if (n_start < 0) begin
			return "";
		end

		n_stop = r_str.find("\"", (n_start + 1));
		if (n_stop < 0) begin
			return "";
		end

		n_start++;
		key = r_str.substr(n_start, (n_stop - n_start));

		n_start = r_str.find(":");
		n_start++;
		r_str = r_str.substr(n_start);

		return key.get();
	endfunction

	function automatic Object Object::parseObject (
		ref util::String r_str
	);
		int n_start, n_stop;
		Object o;

		n_start = r_str.find_first_not_of(" \t\n");

		r_str = r_str.substr(n_start);

		if (r_str.find("true") == 0) begin
			Boolean b = new (1);
			o = b;
		end else if (r_str.find("false") == 0) begin
			Boolean b = new (0);
			o = b;
		end else if (r_str.find("null") == 0) begin
			Null n = new ();
			o = n;
		end else if (r_str.find("\"") == 0) begin
			String s;
			n_stop = r_str.find("\"", 1);
			s = new (r_str.substr(1, n_stop - 1).get());
			o = s;
		end else if (r_str.find_first_of("+-0123456789.e") == 0) begin
			Number n;
			string s;
			n_stop = r_str.find_first_not_of("+-0123456789.e");
			if (n_stop < 0) begin
				s = r_str.substr(0).get();
			end else begin
				s = r_str.substr(0, n_stop).get();
			end
			n = new(s.atoreal());
			o = n;
		end else if (r_str.find("{") == 0) begin
			r_str = r_str.substr(1);
			o = new();
			o.fromString(r_str);
		end else if (r_str.find("[") == 0) begin
			Array a;
			r_str = r_str.substr(1);
			a = Array::Create(r_str);
			o = a;
		end else begin
			return null;
		end

		n_start = r_str.find_first_of(",}]");
		if (n_start < 0 && r_str.len()) begin
			return null;
		end

		r_str = r_str.substr(n_start + 1);

		return o;
	endfunction

	function automatic Object Object::getByKey (
		input string key
	);
		if (m_Elements.exists(key)) begin
			return m_Elements[key];
		end
		return null;
	endfunction

	function automatic Object Object::getByIndex (
		input int unsigned index
	);
		return null;
	endfunction

	function automatic bit Object::isArray();
		return 0;
	endfunction

	function automatic bit Object::isTrue();
		return 0;
	endfunction

	function automatic bit Object::isNull();
		return 0;
	endfunction

	function automatic int unsigned Object::size();
		return 0;
	endfunction

	function automatic string Object::asString();
		return "";
	endfunction

	function automatic real Object::asReal();
		return 0.0;
	endfunction

	function automatic void Object::dumpS(
		ref util::String r_str
	);
		r_str.append("{\n");
		n_dump_depth++;

		if (m_Elements.size()) begin
			Object o;
			string i, l;
			m_Elements.first(i);
			m_Elements.last(l);
			do begin
				r_str.append("\t", n_dump_depth);
				r_str.append("\"");
				r_str.append(i);
				r_str.append("\": ");
				o = m_Elements[i];
				o.dumpS(r_str);
				m_Elements.next(i);

				if (i != l) begin
					r_str.append(",\n");
				end else begin
					r_str.append("\n");
				end
			end while (i != l);
		end

		n_dump_depth--;
		r_str.append("\t", n_dump_depth);
		r_str.append("}");
	endfunction

	function automatic void Object::dump (
		input string file_path
	);
		int fd;
		util::String s = new();

		/* Open the JSON output text file */
		fd = $fopen(file_path, "w");
		if (!fd) begin
			$error("Could not open file %s", file_path);
			return;
		end

		dumpS(s);
		
		$fwrite(fd, s.get());
		$fclose(fd);
	endfunction

	function Array::new ();
		super.new();
	endfunction

	function automatic Array Array::Create (
		ref util::String r_str
	);
		Array a = new();

		a.fromString(r_str);

		return a;
	endfunction

	function automatic void Array::append (
		input Object elem
	);
		m_Elements.push_back(elem);
	endfunction

	function automatic void Array::delete (
		input int unsigned index
	);
		if (index < m_Elements.size()) begin
			m_Elements.delete(index);
		end
	endfunction

	function automatic bit Array::parseElement (
		ref util::String r_str
	);
		Object o;

		o  = parseObject(r_str);
		if (o != null) begin
			m_Elements.push_back(o);
		end else begin
			return 0;
		end

		return 1;
	endfunction;

	function automatic Object Array::getByIndex (
		input int unsigned index
	);
		if (m_Elements.size()) begin
			return m_Elements[index];
		end
		return null;
	endfunction

	function automatic bit Array::isArray();
		return 1;
	endfunction

	function automatic int unsigned Array::size();
		return m_Elements.size();
	endfunction

	function automatic void Array::dumpS(
		ref util::String r_str
	);
		r_str.append("[\n");
		n_dump_depth++;

		for (int unsigned i = 0; i < m_Elements.size(); ++i) begin
			Object o;

			r_str.append("\t", n_dump_depth);
			o = m_Elements[i];
			o.dumpS(r_str);

			if (i < (m_Elements.size() - 1)) begin
				r_str.append(",\n");
			end else begin
				r_str.append("\n");
			end
		end

		n_dump_depth--;
		r_str.append("\t", n_dump_depth);
		r_str.append("]");
	endfunction

	function Boolean::new(
		input bit b
	);
		super.new();
		m_bool = b;
	endfunction

	function automatic bit Boolean::isTrue();
		return m_bool;
	endfunction

	function automatic void Boolean::dumpS(
		ref util::String r_str
	);
		if (m_bool) begin
			r_str.append("true");
		end else begin
			r_str.append("false");
		end
	endfunction

	function Null::new();
		super.new();
	endfunction

	function automatic bit Null::isNull();
		return 1;
	endfunction

	function automatic void Null::dumpS(
		ref util::String r_str
	);
		r_str.append("null");
	endfunction

	function Number::new (
		input real num
	);
		super.new();
		m_number = num;
	endfunction

	function automatic real Number::asReal();
		return m_number;
	endfunction

	function automatic void Number::dumpS(
		ref util::String r_str
	);
		string s;
		s.realtoa(m_number);
		r_str.append(s);
	endfunction

	function String::new (
		input string s
	);
		super.new();
		m_string = s;
	endfunction

	function automatic string String::asString();
		return m_string;
	endfunction

	function automatic void String::dumpS(
		ref util::String r_str
	);
		r_str.append("\"");
		r_str.append(m_string);
		r_str.append("\"");
	endfunction

endpackage
