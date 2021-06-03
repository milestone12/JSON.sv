package json;

	class Object;
		/* Attributes */
		local Object m_Elements[string];

		/* Methods */
		extern function new ();

		extern static function automatic Object Create (
			ref util::String r_str
		);

		extern function automatic void append (
			input string key,
			input Object elem
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

		extern virtual function automatic bit isTrue();
	endclass

	class Array extends Object;
		/* Attributes */
		local Object m_Elements[$];
		
		/* Methods */
		extern function new ();

		extern static function automatic Array Create (
			ref util::String r_str
		);

		extern virtual protected function automatic bit parseElement (
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
	endclass

	class Null extends Object;
		/* Methods */
		extern function new();
	endclass

	class Number extends Object;
		/* Attributes */
		local real m_number;

		/* Methods */
		extern function new (
			input real num = 0.0
		);
	endclass

	class String extends Object;
		/* Attributes */
		local string m_string;

		/* Methods */
		extern function new (
			input string s = ""
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

	function automatic void Object::fromString (
		ref util::String r_str
	);
		if (r_str != null) begin
			while (parseElement(r_str)) begin
			end
		end
	endfunction

	function automatic bit Object::isTrue();
		return 0;
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

	function Boolean::new(
		input bit b
	);
		super.new();
		m_bool = b;
	endfunction

	function automatic bit Boolean::isTrue();
		return m_bool;
	endfunction

	function Null::new();
		super.new();
	endfunction

	function Number::new (
		input real num
	);
		super.new();
		m_number = num;
	endfunction

	function String::new (
		input string s
	);
		super.new();
		m_string = s;
	endfunction

endpackage
