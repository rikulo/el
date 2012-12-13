//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:05:13 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class EvaluationContext implements ELContext {
  final ELContext _elContext;

  final FunctionMapper _fnMapper;

  final VariableMapper _varMapper;

  EvaluationContext(ELContext elContext, FunctionMapper fnMapper,
      VariableMapper varMapper)
      : this._elContext = elContext,
        this._fnMapper = fnMapper,
        this._varMapper = varMapper;

  ELContext getELContext()
    => this._elContext;

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  getAttribute(var key)
    => this._elContext.getAttribute(key);

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  setAttribute(var key, Object val)
    => this._elContext.setAttribute(key, val);

  //@Override
  FunctionMapper getFunctionMapper()
    => this._fnMapper;

  //@Override
  VariableMapper getVariableMapper()
    => this._varMapper;

  //@Override
  Object getContext(ClassMirror key)
    => this._elContext.getContext(key);

  //@Override
  ELResolver getELResolver()
    => this._elContext.getELResolver();

  //@Override
  bool isPropertyResolved()
    => this._elContext.isPropertyResolved();

  //@Override
  void putContext(ClassMirror key, Object contextObject) {
    this._elContext.putContext(key, contextObject);
  }

  //@Override
  void setPropertyResolved(bool resolved) {
    this._elContext.setPropertyResolved(resolved);
  }

  //@Override
  String getLocale()
    => this._elContext.getLocale();

  //@Override
  void setLocale(String locale) {
    this._elContext.setLocale(locale);
  }
}
