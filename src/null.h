/*
 * number.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#ifndef NULL_H_
#define NULL_H_

#include "object.h"


namespace json {

class Null : public Object
{
protected:

public:
	Null();
	~Null();

	bool isNull();

	void dumpS(string& s);
};

}


#endif /* NULL_H_ */
