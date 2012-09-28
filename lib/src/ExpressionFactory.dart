//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:10:10 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * ExpressionFactory to create proper [ValueExpression] and [MethodExpression].
 */
abstract class ExpressionFactory {
  /**
   * Used to coerce a specified object to the specified expected type.
   *
   * + [obj] - the object
   * + [expectedType] - ClassMirror of a specified class
   */
  Object coerceToType(Object obj, ClassMirror expectedType);

  /**
   * Create a [ValueExpression] of the specified EL script.
   *
   * + [context] - the ELContext used when create and parse the
   *               [ValueExpression].
   * + [expression] - the EL expression script to be parsed.
   * + [expectedType] - the expected type when eval the created
   *                    [ValueExpression].
   */
  ValueExpression createValueExpression(ELContext context,
          String expression, ClassMirror expectedType);

  /**
   * Create a [ValueExpression] of the specified object instance.
   *
   * + [instance] - the instance object to be wrapped as a [ValueExpression].
   * + [expectedType] - the expected type when eval the created
   *                    [ValueExpression].
   */
  ValueExpression createValueExpressionByInstance(Object instance,
          ClassMirror expectedType);

  /**
   * Create a [MethodExpression] of the specified EL script.
   *
   * + [context] - the ELContext used when create and parse the
   *               [MethodExpression].
   * + [expression] - the EL expression script to be parsed.
   * + [expectedType] - the expected return type when eval the created
   *                    [MethodExpression].
   */
  MethodExpression createMethodExpression(ELContext context,
          String expression, ClassMirror expectedReturnType);

  /**
   * Create a new [ExpressionFactory].
   *
   * By default an instance of [ExpressionFactoryImpl] will be returned.
   * Note you can configure the static field ExpressionFactory.CREATOR
   * to make this constructor return your own ExpressionFactory implementation.
   *
   *     ExpressionFactory.CREATOR =
   *        () => new MyExpressionFactoryImpl();
   *
   *     ...
   *
   *     ExpressionFactory myef = new ExpressionFactory();
   *
   * ExpressionFactory.CREATOR is an [ExpressionFactoryCreator] function that
   * should return an instance of ExpressionFactory.
   */
  factory ExpressionFactory()
      => CREATOR != null ? CREATOR() :
         ClassUtil.newInstance("rikulo:el/impl.ExpressionFactoryImpl");

  /**
   * Function that return a new ExpressionFactory instance. You can configure
   * this static field to make `new ExpressionFactory()` return your own
   * ExpressionFactory implementation (System default will return an instance
   * of [ExpressionFactoryImpl]).
   *
   *     ExpressionFactory.CREATOR =
   *        () => new MyExpressionFactoryImpl();
   *
   *     ...
   *
   *     ExpressionFactory myef = new ExpressionFactory();
   *
   */
  static ExpressionFactoryCreator CREATOR;
}

/** A function that return an ExprssionFactory */
typedef ExpressionFactory ExpressionFactoryCreator();