//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:24:18 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

/**
 * An `Expression` that refers to a method on an object.
 *
 * The [ExpressionFactory.createMethodExpression] method
 * can be used to parse an expression string and return a concrete instance
 * of `MethodExpression` that encapsulates the parsed expression.
 * The [FunctionMapper] is used at parse time, not evaluation time,
 * so one is not needed to evaluate an expression using this class.
 * However, the [ELContext] is needed at evaluation time.
 *
 * The [getMethodInfo] and [invoke] methods will evaluate the
 * expression each time they are called. The [ELResolver] in the
 * [ELContext] is used to resolve the top-level variables and to
 * determine the behavior of the `.` and `[]`
 * operators. For any of the two methods, the
 * [ELResolver.getValue] method is used to resolve all properties
 * up to but excluding the last one. This provides the `base` object
 * on which the method appears. If the `base` object is null, an
 * exception must be thrown. At the last resolution,
 * the final `property` is then coerced to a `String`,
 * which provides the name of the method to be found. A method matching the
 * name provided at parse time is found and it is
 * either queried or invoked (depending on the method called on this
 * [MethodExpression].
 *
 * See [Expression] for further notes about comparison and immutability.
 *
 * + see [ELResolver]
 * + see [Expression]
 * + see [ExpressionFactory]
 */
abstract class MethodExpression extends Expression {

    MethodInfo getMethodInfo(ELContext context);

  /**
   * Return the result of the method invocation (`null` if the
   * method has a `void` return type).
   *
   * Evaluates the expression relative to the provided context, invokes the
   * method that was found using the supplied parameters, and returns the
   * result of the method invocation.
   *
   * + [context] - The context of this evaluation.
   * + [positionalArgs] - The positional arguments to be pass into the method, or
   *             `null` if no arguments.
   * + [namedArgs] - optional named arguments to be passed into the method.
   */
    Object invoke(ELContext context, List<Object> positionalArgs, [Map<String, Object> namedArgs]);

    bool get isParametersProvided;
}
