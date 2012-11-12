//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 24, 2012  12:31:05 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ELContextImpl extends ELContext {
  static final ELResolver _DefaultResolver =
      new CompositeELResolver()
        ..add(new VarELResolver()) //issue3: resolve top level variable
        ..add(new MapELResolver())
        ..add(new ArrayELResolver())
        ..add(new BeanELResolver());

  static final FunctionMapper _DefaultFunctionMapper = new _FunctionMapperImpl();

  final ELResolver _resolver;

  FunctionMapper _functionMapper = _DefaultFunctionMapper;

  VariableMapper _variableMapper;

  Map _attrs;

  ELContextImpl([ELResolver resolver])
      : this._resolver = resolver == null ? getDefaultResolver() : resolver,
        super.init();

  //@Override
  ELResolver getELResolver() {
    return this._resolver;
  }

  //@Override
  FunctionMapper getFunctionMapper() {
    return this._functionMapper;
  }

  //@Override
  VariableMapper getVariableMapper() {
    if (this._variableMapper == null)
      this._variableMapper = new VariableMapperImpl();
    return this._variableMapper;
  }

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  getAttribute(var key)
    => _attrs == null ? null : _attrs[key];

  //20120928, henrichen: provide a general attribute carrier
  //@Override
  setAttribute(var key, Object val) {
    if (_attrs == null)
      _attrs = new Map();
    var old = _attrs[key];
    _attrs[key] = val;

    return old;
  }

  void setFunctionMapper(FunctionMapper functionMapper) {
      this._functionMapper = functionMapper;
  }

  void setVariableMapper(VariableMapper variableMapper) {
      this._variableMapper = variableMapper;
  }

  static ELResolver getDefaultResolver() {
     return _DefaultResolver;
  }
}

//issue4: support Dart top level function
//default FunctionMapper
class _FunctionMapperImpl implements FunctionMapper {
  Function resolveFunction(String prefix, String localName) {
    if (prefix == null || prefix == '') {
      MethodMirror mm = _getFun(localName);
      if (mm != null)
        return new _TopLevelFn(_getLib(), mm)._topLevelFn;
    }
    return null;
  }

  LibraryMirror _getLib() {
    return currentMirrorSystem().isolate.rootLibrary;
  }

  MethodMirror _getFun(Object property) {
    LibraryMirror lm = currentMirrorSystem().isolate.rootLibrary;
    return lm != null ? lm.functions[property] : null;
  }
}

//issue4: support Dart top level function
//Used to hold a top level function
class _TopLevelFn {
  LibraryMirror _lib;
  MethodMirror _method;

  _TopLevelFn(this._lib, this._method);

  _TopLevelFn _topLevelFn()
    => this;

  static _TopLevelFn _getTopLevelFn(Function fn, MethodMirror m)
    => 'rikulo_elimpl._TopLevelFn' == m.returnType.qualifiedName ?
          ClassUtil.apply(fn, []) : null;
}

class _VariableMapperImpl implements VariableMapper {

  Map<String, ValueExpression> _vars;

  //@Override
  ValueExpression resolveVariable(String variable) {
    if (_vars == null)
      return null;

    return _vars[variable];
  }

  //@Override
  ValueExpression setVariable(String variable, ValueExpression expression) {
    if (_vars == null)
      _vars = new Map();

    return _vars[variable] = expression;
  }
}
