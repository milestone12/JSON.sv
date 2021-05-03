/*
 * number.cpp
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#include <iostream>
#include "number.h"

using namespace std;


namespace json {

Number::Number (const string& r_str){
	m_num = stod(r_str);
}

Number::~Number (){}

double Number::asReal(){
	return m_num;
}

void Number::dumpS(string& s){
	s.append(std::to_string(m_num));
}

}
