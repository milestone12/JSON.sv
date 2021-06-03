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

		extern virtual function automatic bit isTrue();

		extern local function automatic bit parseElement (
			ref util::String r_str
		);

		extern local function automatic string parseKey (
			ref util::String r_str
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

		r_str = new("");
		return 0;
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

	function Array::new ();
		super.new();
	endfunction

	function automatic Array Array::Create (
		ref util::String r_str
	);
		Array a;

		a = new();

		return a;
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
