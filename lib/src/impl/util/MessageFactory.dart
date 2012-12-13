//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:11:03 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class MessageFactory {
  static PropertiesBundle _bundle = new Messages("en_US"); //TODO(henri) : use current Locale

  static getString(String name, [List props]) {
    String template = _bundle.getString(name);
    if (props != null) {
      template = MessageFormat.format(template, props);
    }
    return template;
  }
}
