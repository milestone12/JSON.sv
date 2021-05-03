/*
 * json.cpp
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#include "json.h"


namespace json {

Object * LoadS (string& r_str)
{
	int n_start = r_str.find_first_not_of(" \t\n");

	if (r_str[n_start] == '{') {
		r_str = r_str.substr(n_start + 1);
	} else {
		r_str = r_str.substr(n_start);
	}

	return new Object(r_str);
}

}

