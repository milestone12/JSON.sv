/*
 * object.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
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
