/*
 * number.cpp
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#include <iostream>
#include "boolean.h"

using namespace std;


namespace json {

Boolean::Boolean (const bool b) :
	m_bool(b)
{}

Boolean::~Boolean(){}

bool Boolean::isTrue(){
	return m_bool;
}

void Boolean::dumpS(string& s){
	if (m_bool) {
		s.append("true");
	} else {
		s.append("false");
	}
}

}
