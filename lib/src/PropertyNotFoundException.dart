//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:29:01 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class PropertyNotFoundException extends ELException {
  PropertyNotFoundException([String message, Exception cause])
      : super(message, cause);
}
