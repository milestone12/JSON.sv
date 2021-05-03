//============================================================================
// Name        : Jansson.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <fstream>
#include <iostream>

#include <jansson.h>
#include <jsoncpp/json/json.h>

using namespace std;

int main() {
	cout << "!!!Hello World!!!" << endl; // prints !!!Hello World!!!

	json_t *root;
	json_error_t err;
	json_t *commit;
	json_t *commit_sha;
	string str_sha;

	root = json_load_file("./src/ghdl.json", 0, &err);

	cout << "# Commits: " << json_array_size(root) << endl;

	commit = json_array_get(root, 0);
	commit_sha = json_object_get(commit, "sha");
	str_sha = json_string_value(commit_sha);

	cout << "Commit SHA: " << str_sha << endl;

	Json::Value r;
	std::ifstream json_doc("./src/ghdl.json", std::ifstream::binary);
	json_doc >> r;

	cout << "# Commits: " << r.size() << endl;

	Json::Value c;
	c = r[0];

	Json::Value sha;
	sha = c["sha"];

	cout << "Commit SHA: " << sha.asString() << endl;

	return 0;
}
