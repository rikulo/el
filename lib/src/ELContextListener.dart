//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:05:57 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

/**
 * An event listener called back when an ELContext has been created.
 */
abstract class ELContextListener {
  void contextCreated(ELContextEvent event);
}
