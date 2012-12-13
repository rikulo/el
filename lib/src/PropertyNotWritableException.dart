//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:30:31 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class PropertyNotWritableException extends ELException {
  PropertyNotWritableException([String message, var cause])
      : super(message, cause);
}
