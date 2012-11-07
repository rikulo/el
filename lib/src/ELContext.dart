//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * Context used in EL expression parsing and evaluation.
 */
abstract class ELContext {
  String _locale;
  Map<ClassMirror, Object> _map;
  bool _resolved;

  /**
   * Returns an associated object of the class.
   *
   * + [key] - the ClassMirror as a key.
   */
  Object getContext(ClassMirror key) {
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
  void putContext(ClassMirror key, Object contextObject) {
      if (key == null || contextObject == null) {
          throw const NullPointerException();
      }

      if (this._map == null) {
          this._map = new Map();
      }

      this._map[key] = contextObject;
  }

  /**
   * Set flags to indicate whether the EL expression has been resolveed.
   *
   * + [resolved] - true to indicate the EL expression has been resolved.
   */
  void setPropertyResolved(bool resolved) {
      this._resolved = resolved;
  }

  /**
   * Returns whether the EL expression has been resolveed.
   */
  bool isPropertyResolved() {
      return this._resolved;
  }

  /**
   * Returns the ELResolver for evaluating the EL expression.
   */
  ELResolver getELResolver();

  /**
   * Returns the FunctionMapper that help resolving a function when evaluating
   * the EL expression.
   */
  FunctionMapper getFunctionMapper();

  /**
   * Returns the [VariableMapper] that help resolving a varaible when
   * evaluating the EL expression.
   */
  VariableMapper getVariableMapper();

  /**
   * Return the associate locale string of the ISO
   * format (lang_COUNTRY_variant).
   */
  String getLocale() {
      return this._locale;
  }

  /**
   * Sets the locale string of the ISO format (lang_COUNTRY_variant).
   *
   * + [locale] - the associated locale string when evaluating the EL
   *              expression.
   */
  void setLocale(String locale) {
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
  setAttribute(var key, Object val);

  /**
   * Create a new [ELContext].
   *
   * By default, an instance of [ELContextImpl] will be returned.
   * Note you can configure the static field ELContext.CREATOR
   * to make this constructor return your own ELContext implementation.
   *
   *     ELContext.CREATOR =
   *        () => new MyELContextImpl();
   *
   *     ...
   *
   *     ELContext myctx = new ELContext();
   *
   * ELContext.CREATOR is an [ELContextCreator] function that
   * should return an instance of ELContext.
   */
  factory ELContext()
      => CREATOR != null ? CREATOR() :
         ClassUtil.newInstance("rikulo_elimpl.ELContextImpl");

  /** Constructor to be called by subclass */
  ELContext.init()
      : this._resolved = false;

  /**
   * Function that return a new ELContext instance. You can configure
   * this static field to make `new ELContext()` return your own
   * ELContext implementation (System default will return an instance
   * of [ELContextImpl]).
   *
   *     ELContext.CREATOR =
   *        () => new MyELContextImpl();
   *
   *     ...
   *
   *     ELContext myctx = new ELContext();
   *
   */
  static ELContextCreator CREATOR;
}

/** A function that return an ELContext */
typedef ELContext ELContextCreator();