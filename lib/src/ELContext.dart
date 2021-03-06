//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

/**
 * Context used in EL expression parsing and evaluation.
 */
abstract class ELContext {
  String _locale;
  Map<ClassMirror, dynamic> _map;
  bool _resolved;

  /**
   * Returns an associated object of the class.
   *
   * + [key] - the ClassMirror as a key.
   */
  getContext(ClassMirror key) {
      if (this._map == null) {
          return null;
      }
      return this._map[key];
  }

  /**
   * Put an object of the specified class.
   *
   * + [key] - the ClassMirror as a key.
   * + [contextObject] - the associated object of the class.
   */
  void putContext(ClassMirror key, contextObject) {
      if (key == null) {
        throw new ArgumentError("key cannot be null");
      }
      if (contextObject == null)
        throw new ArgumentError("contextObject cannot be null");

      if (this._map == null) {
        this._map = new HashMap();
      }

      this._map[key] = contextObject;
  }

  /**
   * Set flags to indicate whether the EL expression has been resolveed.
   *
   * + [resolved] - true to indicate the EL expression has been resolved.
   */
  void set isPropertyResolved(bool resolved) {
      this._resolved = resolved;
  }

  /**
   * Returns whether the EL expression has been resolveed.
   */
  bool get isPropertyResolved => this._resolved;

  /**
   * Returns the ELResolver for evaluating the EL expression.
   */
  ELResolver get resolver;

  /**
   * Returns the FunctionMapper that help resolving a function when evaluating
   * the EL expression.
   */
  FunctionMapper get functionMapper;

  /**
   * Returns the [VariableMapper] that help resolving a varaible when
   * evaluating the EL expression.
   */
  VariableMapper get variableMapper;

  /**
   * Return the associate locale string of the ISO
   * format (lang_COUNTRY_variant).
   */
  String get locale => this._locale;

  /**
   * Sets the locale string of the ISO format (lang_COUNTRY_variant).
   *
   * + [locale] - the associated locale string when evaluating the EL
   * expression.
   */
  void set locale(String locale) {
      this._locale = locale;
  }

  //20120928, henrichen: provide a general attribute carrier
  /**
   * Returns a general attribute of the associated key in this context.
   *
   * + [key] - the key
   */
  getAttribute(var key);

  //20120928, henrichen: provide a general attribute carrier
  /**
   * Set a general attribute of the associated key in this context and return
   * the original one that was associated with the specified key.
   *
   * + [key] - the key
   * + [val] - the value
   */
  setAttribute(var key, val);

  /**
   * Create a new [ELContext] from the optional [FunctionMapper]
   * and [VariableMapper].
   *
   * By default, an instance of [ELContextImpl] will be returned.
   * Note you can configure the static field [ELContext.CREATOR]
   * to make this constructor return your own [ELContext] implementation.
   *
   *     ELContext.CREATOR = ({VariableMapper variableMapper,
   *       FunctionMapper functionMapper})
   *       => new MyELContextImpl(variableMapper, functionMapper);
   *     ...
   *     ELContext myctx = new ELContext.mapper(functionMapper: new MyFuncMapper());
   *
   * ELContext.CREATOR is an [ELContextCreator] function that
   * should return an instance of ELContext.
   */
  factory ELContext.mapper({VariableMapper variableMapper, FunctionMapper functionMapper})
  => CREATOR != null ?
    CREATOR(variableMapper: variableMapper, functionMapper: functionMapper) :
    new ELContextImpl(variableMapper: variableMapper, functionMapper: functionMapper);
  /** Create a new [ELContext] with the optional function and variable mapper.
   *
   * If the value returned by [resolveVariable] is an expression ([ValueExpression]),
   * it will be evaluated at run time to get the value.
   *
   * Notice the value returned by [resolveVariable] will be cached in the EL context.
   * If the value might change among different retrieval, use an expression that will
   * return a value dynamically. Alternatively, you can use [ELContext.mapper] or
   * implement your own [ELContext] instead.
   *
   * By default, an instance of [ELContextImpl] will be returned.
   * Note you can configure the static field [ELContext.CREATOR]
   * to make this constructor return your own [ELContext] implementation.
   *
   *     ELContext.CREATOR = ({VariableMapper variableMapper,
   *       FunctionMapper functionMapper})
   *       => new MyELContextImpl(variableMapper, functionMapper);
   *     ...
   *     ELContext myctx = new ELContext();
   *
   * ELContext.CREATOR is an [ELContextCreator] function that
   * should return an instance of ELContext.
   */
  factory ELContext({resolveVariable(String name),
      Function resolveFunction(String name)})
  => new ELContext.mapper(variableMapper: _toVMapper(resolveVariable),
      functionMapper: _toFMapper(resolveFunction));

  /** Constructor to be called by subclass */
  ELContext.init(): this._resolved = false;

  /**
   * Function that return a new ELContext instance. You can configure
   * this static field to make `new ELContext()` return your own
   * ELContext implementation (System default will return an instance
   * of [ELContextImpl]).
   *
   *     ELContext.CREATOR = ({VariableMapper variableMapper,
   *       FunctionMapper functionMapper})
   *       => new MyELContextImpl(variableMapper, functionMapper);
   *     ...
   *     ELContext myctx = new ELContext();
   *
   */
  static ELContextCreator CREATOR;
}

/** A function that return an ELContext */
typedef ELContext ELContextCreator(
  {VariableMapper variableMapper, FunctionMapper functionMapper});

class _VMapper implements VariableMapper {
  Function _resolve;
  Map<String, ValueExpression> _vars = new HashMap();

  _VMapper(resolve(String name)): _resolve = resolve;

  ValueExpression resolveVariable(String name) {
    var val = _vars[name];
    if (val == null) {
      val = _resolve(name);
      if (val != null) {
        if (val is! ValueExpression)
          val = _factory.createVariable(val);
        _vars[name] = val;
      }
    }
    return val;
  }
  ValueExpression setVariable(String name, ValueExpression expression) {
    throw new UnsupportedError("Cannot set variables");
  }
}
final ExpressionFactory _factory = new ExpressionFactory();
VariableMapper _toVMapper(variableMapper(String name))
=> variableMapper != null ? new _VMapper(variableMapper): null;

class _FMapper implements FunctionMapper {
  Function _resolve;
  _FMapper(Function resolve(String name)): _resolve = resolve;
  Function resolveFunction(String name) => _resolve(name);
}
FunctionMapper _toFMapper(Function functionMapper(String name))
=> functionMapper != null ? new _FMapper(functionMapper): null;
