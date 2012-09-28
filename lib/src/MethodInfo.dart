//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:26:21 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 *
 */
class MethodInfo {

    final String _name;

    final ClassMirror _returnType;

    MethodInfo(String name, ClassMirror returnType)
        : this._name = name,
          this._returnType = returnType;

    String getName() => _name;

    ClassMirror getReturnType() => _returnType;
}
