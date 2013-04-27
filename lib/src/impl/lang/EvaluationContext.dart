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

  ELContext get elContext => this._elContext;

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  getAttribute(var key)
    => this._elContext.getAttribute(key);

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  setAttribute(var key, Object val)
    => this._elContext.setAttribute(key, val);

  //@Override
  FunctionMapper get functionMapper => this._fnMapper;

  //@Override
  VariableMapper get variableMapper => this._varMapper;

  //@Override
  Object getContext(ClassMirror key)
    => this._elContext.getContext(key);

  //@Override
  ELResolver get resolver => this._elContext.resolver;

  //@Override
  bool get isPropertyResolved => this._elContext.isPropertyResolved;

  //@Override
  void putContext(ClassMirror key, Object contextObject) {
    this._elContext.putContext(key, contextObject);
  }

  //@Override
  void set isPropertyResolved(bool resolved) {
    this._elContext.isPropertyResolved = resolved;
  }

  //@Override
  String get locale => this._elContext.locale;

  //@Override
  void set locale(String locale) {
    this._elContext.locale = locale;
  }
}
