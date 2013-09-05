//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:36:10 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

/**
 * An `Expression` that can be evaluated and refer to an object.
 *
 * The [ExpressionFactory.createValueExpression] method
 * can be used to parse an expression string and return a concrete instance
 * of `ValueExpression` that encapsulates the parsed expression.
 *
 * Similarly, [ExpressionFactory.createVariable] can be used to
 * create a value expression returing the given object.
 */
abstract class ValueExpression extends Expression {

  ClassMirror get expectedType;

  ClassMirror getType(ELContext context);

  bool isReadOnly(ELContext context);

  void setValue(ELContext context, value);

  getValue(ELContext context);

  ValueReference getValueReference(ELContext context);
}
