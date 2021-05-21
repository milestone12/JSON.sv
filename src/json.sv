package json;

	virtual class Object;
		/* Attributes */
		local Object m_Elements[string];

		/* Methods */
		extern function new (
			input string r_str = ""
		);

		extern virtual function automatic bit isTrue();
	endclass

	class Array extends Object;
		/* Attributes */
		local Object m_Elements[$];
		
		/* Methods */
		extern function new (
			input string r_str = ""
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


	function Object::new (
		input string r_str
	);
	endfunction

	function automatic bit Object::isTrue();
		return 0;
	endfunction

	function Array::new (
		input string r_str = ""
	);
		super.new();
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

endpackage
