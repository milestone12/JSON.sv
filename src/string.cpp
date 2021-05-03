/*
 * string.cpp
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#include "string.h"

namespace json {


String::String (const string& r_str)
:
		m_str(r_str)
{

}

String::~String (){}

string String::asString(){
	return m_str;
}

void String::asString(string& s){
	s = asString();
}

void String::dumpS(string& s){
	s.append("\"").append(m_str).append("\"");
}

}


