/*
 * number.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#ifndef BOOLEAN_H_
#define BOOLEAN_H_

#include "object.h"


namespace json {

class Boolean : public Object
{
protected:
	bool m_bool;

public:
	Boolean(const bool b);
	~Boolean();

	bool isTrue();

	void dumpS(string& s);
};

}


#endif /* BOOLEAN_H_ */
