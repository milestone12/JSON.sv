package json;

	virtual class Object;
		extern function new;
	endclass

	class Boolean extends Object;
		extern function new;
	endclass


	function Object::new;
	endfunction

	function Boolean::new;
		super.new();
	endfunction

endpackage
