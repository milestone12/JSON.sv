//============================================================================
// Name        : JsonSV.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <fstream>
#include "json.h"
#include "object.h"

using namespace std;
using namespace json;

int main() {
	ifstream f("./src/json.json", ifstream::binary);
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
