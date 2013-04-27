//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:38:16 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class ValueReference {

  final Object base;
  final Object property;

  ValueReference(this.base, this.property);
}
