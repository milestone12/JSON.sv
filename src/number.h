/*
 * number.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#ifndef NUMBER_H_
#define NUMBER_H_

#include "object.h"


namespace json {

class Number : public Object
{
protected:
	double m_num;

public:
	Number(const string& r_str);
	~Number();

	double asReal();

	void dumpS(string& s);
};

}


#endif /* NUMBER_H_ */
