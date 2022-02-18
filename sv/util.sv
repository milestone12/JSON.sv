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
package util;

	class String;
		/* Attributes */
		local string m_string;

		/* Methods */
		extern function new (
			input string s = ""
		);

		extern function automatic int unsigned len ();

		extern function automatic string at (
			int unsigned n
		);

		extern function automatic string get ();

		extern function automatic String substr (
			int unsigned n_first,
			int unsigned n_len = 0
		);

		extern function automatic void append (
			input string       s,
			input int unsigned n = 1
		);

		extern function automatic int find (
			input string       s,
			input int unsigned n_start = 0,
            input int unsigned n_end   = 0
		);

		extern function automatic int find_first_of (
			input string s
		);

		extern function automatic int find_first_not_of (
			input string s
		);
	endclass


	function String::new(
		input string s
	);
		m_string = s;
	endfunction

	function automatic int unsigned String::len ();
		return m_string.len();
	endfunction

	function automatic string String::at (
		int unsigned n
	);
		return m_string.substr(n, n);
	endfunction

	function automatic string String::get ();
		return m_string;
	endfunction

	function automatic String String::substr(
		int unsigned n_first,
		int unsigned n_len = 0
	);
		string s;
		String s_o;
		if (n_len == 0) begin
			s = m_string.substr(n_first, m_string.len() - 1);
		end else begin
			s = m_string.substr(n_first, n_first + n_len - 1);
		end
		s_o = new(s);
		return s_o;
	endfunction

	function automatic void String::append (
		input string       s,
		input int unsigned n
	);
		for (int unsigned i = 0; i < n; ++i) begin
			m_string = {m_string, s};
		end
	endfunction

	function automatic int String::find (
		input string       s,
		input int unsigned n_start,
        input int unsigned n_end
	);
        int n_top;

        n_top = m_string.len() - s.len();
        if (n_end > 0 && int'(n_end) < n_top) begin
            n_top = int'(n_end);
        end

		for (int i = n_start; i < n_top; ++i) begin
			if (m_string.substr(i, i + s.len() - 1) == s) begin
				return i;
			end
		end

		return -1;
	endfunction

	function automatic int String::find_first_of(
		input string s
	);
		for (int unsigned i = 0; i < m_string.len(); ++i) begin
			for (int unsigned j = 0; j < s.len(); ++j) begin
				if (m_string[i] == s[j]) begin
					return i;
				end
			end
		end

		return -1;
	endfunction

	function automatic int String::find_first_not_of(
		input string s
	);
		for (int unsigned i = 0; i < m_string.len(); ++i) begin
			bit bMatch = 0;

			for (int unsigned j = 0; j < s.len(); ++j) begin
				if (m_string[i] == s[j]) begin
					bMatch = 1;
					break;
				end
			end

			if (!bMatch) begin
				return i;
			end
		end

		return -1;
	endfunction;

endpackage
