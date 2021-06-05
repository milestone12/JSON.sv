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
#include <fstream>
#include "json.h"
#include "object.h"

using namespace std;
using namespace json;

int main() {
	ifstream f("./json.json", ifstream::binary);
	json::string s;
	s.assign(istreambuf_iterator<char>(f), istreambuf_iterator<char>());

	Object *root = LoadS(s);
	Object *p_obj;

	p_obj = (*root)["Deckung"];
	cout << p_obj->asReal() << endl;
	p_obj = root->get("whatever");
	p_obj = root->get("Waehrung");
	cout << p_obj->asString() << endl;
	p_obj = root->get("Inhaber")->get("Name");
	p_obj = root->get("Inhaber")->get("maennlich");
	cout << p_obj->isTrue() << endl;
	p_obj = root->get("Inhaber")->get("Hobbys");
	cout << p_obj->size() << endl;
	p_obj = root->get("Inhaber")->get("Hobbys")->get(1);
	p_obj = root->get("Inhaber")->get("Hobbys")->get(5);
	p_obj = root->get("Inhaber")->get("Partner");
	cout << p_obj->isNull() << endl;

	s.clear();
	root->dumpS(s);
	cout << s << endl;

	return 0;
}
