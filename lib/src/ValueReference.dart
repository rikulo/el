//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:38:16 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ValueReference {

    final Object _base;
    final Object _property;

    ValueReference(Object base, Object property)
        : this._base = base,
          this._property = property;

    Object getBase() => _base;

    Object getProperty() => _property;
}
