//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Oct 2, 2012  04:30:08 PM
// Author: hernichen

part of rikulo_el;

/**
 * Utility class for Rikulo EL.
 */
class ELUtil {
  ///The expression factory
  static ExpressionFactory factory = new ExpressionFactory();

  ///Evaluates the given expression
  static eval(ELContext ctx, String expression, [ClassMirror expectedType])
  => factory.createValueExpression(ctx, expression, expectedType).getValue(ctx);

  ///Assign an object to the given variable. It returns the previous assignment
  ///(which is an expression since a variable can be an expression).
  static ValueExpression
  setVariable(VariableMapper variableMapper, String variable, Object instance) {
    variableMapper.setVariable(variable, factory.createVariable(instance));
  }
}
