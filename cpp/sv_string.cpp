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

#include "sv_string.h"

namespace json {

int string::find (const char c, const unsigned n_start){
	char str[2];
	str[0] = c;
	string s(str);
	return find(s, n_start);
}

int string::find (const string& s, const unsigned n_start){
	size_t n_len = s.size();

	for (unsigned i = n_start; i < (size() - n_len + 1); ++i) {
		if (substr(i, n_len) == s) {
			return i;
		}
	}

	return -1;
}

int string::find_first_of(const char * p_str){
	string str_c(p_str);

	for (unsigned i = 0; i < size(); ++i) {
		for (unsigned j = 0; j < str_c.size(); ++j) {
				if ((*this)[i] == str_c[j]) {
				return i;
			}
		}
	}

	return -1;
}

int string::find_first_not_of(const char * p_str){
	string str_c(p_str);

	for (unsigned i = 0; i < size(); ++i) {
		bool bMatch = false;

		for (unsigned j = 0; j < str_c.size(); ++j) {
			if ((*this)[i] == str_c[j]) {
				bMatch = true;
				break;
			}
		}

		if (!bMatch) {
			return i;
		}
	}

	return -1;
}

}
