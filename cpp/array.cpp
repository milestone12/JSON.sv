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

#include <iostream>
#include "array.h"

using namespace std;

namespace json {

Array::Array (string& r_str)
{
	while (parseElement(r_str)){};
}

Array::~Array(){}

bool Array::parseElement(string& r_str){
	Object *p_obj;

	p_obj = parseObject(r_str);

	if (p_obj != nullptr) {
		m_Elements.push_back(p_obj);
	} else {
		return false;
	}

	return true;
}

Object * Array::get(const char * key){
	return nullptr;
}

Object * Array::get(const unsigned index)
{
	if (index < m_Elements.size()) {
		return m_Elements.at(index);
	}

	return nullptr;
}

bool Array::isArray(){
	return true;
}

size_t Array::size(){
	return m_Elements.size();
}

void Array::dumpS(string& s){
	s.append("[\n");
	n_dump_depth++;

	for (Element_List_t::iterator it = m_Elements.begin(); it != m_Elements.end(); ++it){
		s.append(n_dump_depth, '\t');
		(*it)->dumpS(s);
		if (it != m_Elements.end() - 1) {
			s.append(",\n");
		} else {
			s.append("\n");
		}
	}

	n_dump_depth--;
	s.append(n_dump_depth, '\t').append("]");
}

}
