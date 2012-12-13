//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:04:10 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

/**
 * An event which indicates that an ELContext has been created.
 * The source object is the ELContext that was created.
 */
class ELContextEvent {
  final ELContext _elctx;

  ELContextEvent(ELContext elctx)
      : this._elctx = elctx;

  ELContext getELContext() => _elctx;
}
