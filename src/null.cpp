/*
 * number.cpp
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#include <iostream>
#include "null.h"

using namespace std;


namespace json {

Null::Null (){}

Null::~Null (){}

bool Null::isNull(){
	return true;
}

void Null::dumpS(string& s){
	s.append("null");
}

}
