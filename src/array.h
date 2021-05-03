/*
 * object.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
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
