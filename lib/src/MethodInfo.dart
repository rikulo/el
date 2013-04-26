//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:26:21 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

/**
 *
 */
class MethodInfo {

    final Symbol _name;

    final ClassMirror _returnType;

    MethodInfo(Symbol name, ClassMirror returnType)
        : this._name = name,
          this._returnType = returnType;

    Symbol getName() => _name;

    ClassMirror getReturnType() => _returnType;
}
