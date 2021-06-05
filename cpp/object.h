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

#ifndef OBJECT_H_
#define OBJECT_H_


#include <map>
#include "sv_string.h"

using namespace std;


namespace json {

class Object
{
private:
	typedef map<string, Object *> Element_Map_t;
	Element_Map_t m_Elements;

	bool parseElement(string& r_str);
	string parseKey(string& r_str);

protected:
	static unsigned n_dump_depth;
	Object * parseObject(string& r_str);

public:
	Object();
	Object(string& r_str);
	virtual ~Object();

	virtual Object * get(const char * key);
	virtual Object * get(const unsigned index);

	virtual Object * operator[](const char * key);
	virtual Object * operator[](const unsigned index);

	virtual bool isArray();
	virtual bool isTrue();
	virtual bool isNull();
	virtual size_t size();
	virtual string asString();
	virtual void asString(string& s);
	virtual double asReal();

	virtual void dumpS(string& s);
};

}


#endif /* OBJECT_H_ */
