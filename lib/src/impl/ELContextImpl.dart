//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 24, 2012  12:31:05 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ELContextImpl extends ELContext {
  static final FunctionMapper _NULL_FUNCTION_MAPPER = const _NullFunctionMapper();
  static final ELResolver _DefaultResolver =
      new CompositeELResolver()
        ..add(new MapELResolver())
//        ..add(new ResourceBundleELResolver())
//        ..add(new ListELResolver())
        ..add(new ArrayELResolver())
        ..add(new BeanELResolver());

    final ELResolver _resolver;

    FunctionMapper _functionMapper = _NULL_FUNCTION_MAPPER;

    VariableMapper _variableMapper;

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
        if (this._variableMapper == null) {
            this._variableMapper = new VariableMapperImpl();
        }
        return this._variableMapper;
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

class _NullFunctionMapper implements FunctionMapper {
  const _NullFunctionMapper();

  //@Override
  Function resolveFunction(String prefix, String localName) {
    return null;
  }
}

class _VariableMapperImpl extends VariableMapper {

  Map<String, ValueExpression> _vars;

  //@Override
  ValueExpression resolveVariable(String variable) {
    if (_vars == null) {
      return null;
    }
    return _vars[variable];
  }

  //@Override
  ValueExpression setVariable(String variable,
                                     ValueExpression expression) {
    if (_vars == null)
      _vars = new Map();
    return _vars[variable] = expression;
  }
}
