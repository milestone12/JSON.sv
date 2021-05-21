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

	class Boolean extends Object;
		local bit m_bool;

		/* Methods */
		extern function new(
			input bit b = 0
		);

		extern function automatic bit isTrue();
	endclass


	function Object::new (
		input string r_str
	);
	endfunction

	function automatic bit Object::isTrue();
		return 0;
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

endpackage
