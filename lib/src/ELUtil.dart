//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Oct 2, 2012  04:30:08 PM
// Author: hernichen

part of rikulo_el;

/**
 * Utility class for Rikulo EL.
 */
class ELUtil {
  static ExpressionFactory _elfactory = new ExpressionFactory();

  static eval(ELContext ctx, String expr,
      [TypeMirror expectedType]) {
    ValueExpression valexpr =
        _elfactory.createValueExpression(ctx, expr,
            expectedType == null ? OBJECT_MIRROR : expectedType);
    return valexpr.getValue(ctx);
  }

  static ValueExpression createSetterExpression(ELContext ctx,
      String value, MethodMirror setter) {

    ClassMirror expectedType = setter.parameters[0].type;
    return _elfactory.createValueExpression(ctx, value, expectedType);
  }
}
