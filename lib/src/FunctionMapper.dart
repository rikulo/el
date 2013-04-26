//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:16:50 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

abstract class FunctionMapper {
  ///Returns the function with the given name, or null if not found
  Function resolveFunction(String name);
}
