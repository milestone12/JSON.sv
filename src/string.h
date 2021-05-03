/*
 * string.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#ifndef STRING_H_
#define STRING_H_

#include <string.h>
#include "sv_string.h"
#include "object.h"


namespace json {


class String : public Object
{
protected:
	string m_str;

public:
	String(const string& r_str);
	~String();

	string asString();
	void asString(string& s);

	void dumpS(string& s);
};

}


#endif /* STRING_H_ */
