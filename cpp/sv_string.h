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

#ifndef SV_STRING_H_
#define SV_STRING_H_

#include <iostream>


namespace json {

class string : public std::string
{
public:
	string() : std::string(){};
	string(const string& s) : std::string(s){};
	string(const std::string& s) : std::string(s){};
	string(const char * p_str) : std::string(p_str){};

	int find(const char c, const unsigned n_start = 0);
	int find(const string& s, const unsigned n_start = 0);

	int find_first_of(const char * p_str);
	int find_first_not_of(const char * p_str);
};

}


#endif /* SV_STRING_H_ */
