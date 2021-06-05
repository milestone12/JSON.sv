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

#ifndef ARRAY_H_
#define ARRAY_H_


#include <iostream>
#include <vector>
#include "object.h"

using namespace std;


namespace json {

class Array : public Object
{
private:
	typedef vector<Object *> Element_List_t;
	Element_List_t m_Elements;

	bool parseElement(string& r_str);

public:
	Array(string& r_str);
	~Array();

	Object * get(const char * key);
	Object * get(const unsigned index);

	bool isArray();
	size_t size();

	void dumpS(string& s);
};

}


#endif /* ARRAY_H_ */
