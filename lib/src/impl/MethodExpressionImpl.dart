//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:44:11 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/**
 * An `Expression` that refers to a method on an object.
 *
 * <p>
 * The [ExpressionFactory.createMethodExpression] method
 * can be used to parse an expression string and return a concrete instance
 * of `MethodExpression` that encapsulates the parsed expression.
 * The [FunctionMapper] is used at parse time, not evaluation time,
 * so one is not needed to evaluate an expression using this class.
 * However, the [ELContext] is needed at evaluation time.</p>
 *
 * <p>The [getMethodInfo] and [invoke] methods will evaluate the
 * expression each time they are called. The [ELResolver] in the
 * [ELContext] is used to resolve the top-level variables and to
 * determine the behavior of the `.` and `[]`
 * operators. For any of the two methods, the
 * [ELResolver.getValue] method is used to resolve all properties
 * up to but excluding the last one. This provides the `base` object
 * on which the method appears. If the `base` object is null, a
 * [NullPointerException] must be thrown. At the last resolution,
 * the final `property` is then coerced to a `String`,
 * which provides the name of the method to be found. A method matching the
 * name provided at parse time is found and it is
 * either queried or invoked (depending on the method called on this
 * [MethodExpression].</p>
 *
 * <p>See [Expression] for further notes about comparison and immutability.
 *
 * + see [ELResolver]
 * + see [Expression]
 * + see [ExpressionFactory]
 * + see [MethodExpression]
 */
class MethodExpressionImpl implements MethodExpression {
  ClassMirror _expectedType;

  String _expr;

  FunctionMapper _fnMapper;

  VariableMapper _varMapper;

  Node _node;

  MethodExpressionImpl([String expr, Node node,
          FunctionMapper fnMapper, VariableMapper varMapper,
          ClassMirror expectedType])
      : this._expr = expr,
        this._node = node,
        this._fnMapper = fnMapper,
        this._varMapper = varMapper,
        this._expectedType = expectedType;

  /**
   * Returns the original String used to create this [Expression],
   * unmodified.
   *
   * <p>
   * This is used for debugging purposes but also for the purposes of
   * comparison (e.g. to ensure the expression in a configuration file has not
   * changed).
   * </p>
   *
   * <p>
   * This method does not provide sufficient information to re-create an
   * expression. Two different expressions can have exactly the same
   * expression string but different function mappings.
   * </p>
   *
   * + see [Expression.getExpressionString()]
   */
  //@Override
  String getExpressionString()
    => this._expr;

  /**
   * Returns an instance of [MethodInfo] containing information about the
   * method the expression evaluated to.
   *
   * Evaluates the expression relative to the provided context, and returns
   * information about the actual referenced method.
   *
   * + [context] - The context of this evaluation
   * + see [MethodExpression.getMethodInfo]
   */
  //@Override
  MethodInfo getMethodInfo(ELContext context) {
    Node n = this._getNode();
    EvaluationContext ctx =
        new EvaluationContext(context, this._fnMapper, this._varMapper);
    return n.getMethodInfo(ctx);
  }

  Node _getNode() {
    if (this._node == null)
      this._node = ExpressionBuilder.createNode(this._expr);
    return this._node;
  }

  //@Override
  int get hashCode
    => this._expr.hashCode;

  //@Override
  bool operator ==(MethodExpression other)
    => other is MethodExpressionImpl
        && this._expr == (other as MethodExpressionImpl)._expr;

  /**
   * Return the result of the method invocation (`null` if the
   * method has a `void` return type).
   *
   * Evaluates the expression relative to the provided context, invokes the
   * method that was found using the supplied parameters, and returns the
   * result of the method invocation.
   *
   * + [context] - The context of this evaluation.
   * + [params] - The positional arguments to be pass into the method, or
   *             `null` if no arguments.
   * + [namedArgs] - optional named arguments to be passed into the method.
   *
   * + see [MethodExpression.invoke]
   */
  //@Override
  Object invoke(ELContext context, List<Object> params, [Map<String, Object> namedArgs]) {
    EvaluationContext ctx =
        new EvaluationContext(context, this._fnMapper, this._varMapper);
    return this._getNode().invoke(ctx, params, namedArgs);
  }

  //@Override
  bool isLiteralText()
      => false;

  //@Override
  bool isParametersProvided()
    => this._getNode().isParametersProvided();
}
