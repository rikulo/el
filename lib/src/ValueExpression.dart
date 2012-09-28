//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:36:10 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

abstract class ValueExpression extends Expression {

    ClassMirror getExpectedType();

    ClassMirror getType(ELContext context);

    bool isReadOnly(ELContext context);

    void setValue(ELContext context, Object value);

    Object getValue(ELContext context);

    ValueReference getValueReference(ELContext context);
}
