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

#include <cmath>
#include "array.h"
#include "boolean.h"
#include "object.h"
#include "null.h"
#include "number.h"
#include "string.h"


namespace json {

unsigned Object::n_dump_depth = 0;

Object::Object (){};

Object::Object (string& r_str)
{
	while (parseElement(r_str)){};
}

Object::~Object(){}

bool Object::parseElement(string& r_str){
	Object *p_obj;
	string key = parseKey(r_str);

	if (key.size() == 0) {
		return false;
	}

	p_obj = parseObject(r_str);

	if (p_obj != nullptr) {
		m_Elements[key] = p_obj;
	} else {
		return false;
	}

	return true;
}

string Object::parseKey(string& r_str){
	int n_start;
	int n_stop;

	n_start = r_str.find('"');
	if (n_start < 0) {
		return string("");
	}

	n_stop = r_str.find('"', (n_start + 1));
	if (n_stop < 0) {
		return string("");
	}

	n_start++;
	string key(r_str.substr(n_start, (n_stop - n_start)));

	n_start = r_str.find(':');
	n_start++;
	r_str = r_str.substr(n_start);

	return key;
}

Object * Object::parseObject(string& r_str){
	int n_start = r_str.find_first_not_of(" \t\n");
	int n_stop;
	Object *p_obj = nullptr;

	r_str = r_str.substr(n_start);

	if (r_str.find("true") == 0) {
		p_obj = new Boolean(true);
	} else if (r_str.find("false") == 0) {
		p_obj = new Boolean(false);
	} else if (r_str.find("null") == 0) {
		p_obj = new Null();
	} else if (r_str.find('"') == 0) {
		n_stop = r_str.find('"', 1);
		p_obj = new String(r_str.substr(1, n_stop - 1));
	} else if (r_str.find_first_of("+-0123456789.e") == 0) {
		n_stop = r_str.find_first_not_of("+-0123456789.e");
		string str_num;
		if (n_stop < 0) {
			str_num = r_str.substr(0);
		} else {
			str_num = r_str.substr(0, n_stop);
		}
		p_obj = new Number(r_str);
	} else if (r_str.find('{') == 0) {
		r_str = r_str.substr(1);
		p_obj = new Object(r_str);
	} else if (r_str.find('[') == 0) {
		r_str = r_str.substr(1);
		p_obj = new Array(r_str);
	} else {
		return nullptr;
	}

	n_start = r_str.find_first_of(",}]");
	if (n_start < 0 && r_str.size()) {
		return nullptr;
	}

	r_str = r_str.substr(n_start + 1);

	return p_obj;
}

Object * Object::get(const char * key){
	if (m_Elements.find(key) != m_Elements.end()) {
		return m_Elements.at(key);
	}

	return nullptr;
}

Object * Object::get(const unsigned index)
{
	return nullptr;
}

Object * Object::operator[](const char * key){
	return get(key);
}

Object * Object::operator[](const unsigned index)
{
	return get(index);
}

bool Object::isArray(){
	return false;
}

bool Object::isTrue(){
	return false;
}

bool Object::isNull(){
	return false;
}

size_t Object::size(){
	return 0;
}

string Object::asString(){
	return "";
}

void Object::asString(string& s){
	return;
}

double Object::asReal(){
	return NAN;
}

void Object::dumpS(string& s){
	s.append("{\n");
	n_dump_depth++;

	for (Element_Map_t::iterator it = m_Elements.begin(); it != m_Elements.end(); ){
		string key;
		Object *p_obj;

		key = std::get<0>(*it);
		p_obj = std::get<1>(*it);

		s.append(n_dump_depth, '\t').append("\"").append(key).append("\": ");
		p_obj->dumpS(s);

		if (++it != m_Elements.end()) {
			s.append(",\n");
		} else {
			s.append("\n");
		}
	}

	n_dump_depth--;
	s.append(n_dump_depth, '\t').append("}");
}

}
