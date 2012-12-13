//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 24, 2012  01:03:10 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ELContextWrapper extends ELContextImpl implements ELContext {

    final ELContext _target;
    final FunctionMapper _fnMapper;

    ELContextWrapper(ELContext target, FunctionMapper fnMapper)
        : this._target = target,
          this._fnMapper = fnMapper;

    //@Override
    ELResolver getELResolver() {
        return this._target.getELResolver();
    }

    //@Override
    FunctionMapper getFunctionMapper() {
        if (this._fnMapper != null) return this._fnMapper;
        return this._target.getFunctionMapper();
    }

    //@Override
    VariableMapper getVariableMapper() {
        return this._target.getVariableMapper();
    }

    //@Override
    Object getContext(ClassMirror key) {
        return this._target.getContext(key);
    }

    //@Override
    String getLocale() {
        return this._target.getLocale();
    }

    //@Override
    bool isPropertyResolved() {
        return this._target.isPropertyResolved();
    }

    //@Override
    void putContext(ClassMirror key, Object contextObject) {
        this._target.putContext(key, contextObject);
    }

    //@Override
    void setLocale(String locale) {
        this._target.setLocale(locale);
    }

    //@Override
    void setPropertyResolved(bool resolved) {
        this._target.setPropertyResolved(resolved);
    }

}
