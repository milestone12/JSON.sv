/*
 * json.h
 *
 *  Created on: 30.04.2021
 *      Author: alexander
 */

#ifndef JSON_H_
#define JSON_H_

#include "sv_string.h"
#include "object.h"


namespace json {

Object * LoadS (string& r_str);

}


#endif /* JSON_H_ */
