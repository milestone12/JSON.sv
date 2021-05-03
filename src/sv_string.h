/*
 * sv_string.h
 *
 *  Created on: 02.05.2021
 *      Author: alexander
 */

#ifndef SV_STRING_H_
#define SV_STRING_H_

#include <iostream>


namespace json {

class string : public std::string
{
public:
	string() : std::string(){};
	string(const string& s) : std::string(s){};
	string(const std::string& s) : std::string(s){};
	string(const char * p_str) : std::string(p_str){};

	int find(const char c, const unsigned n_start = 0);
	int find(const string& s, const unsigned n_start = 0);

	int find_first_of(const char * p_str);
	int find_first_not_of(const char * p_str);
};

}


#endif /* SV_STRING_H_ */
