//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  03:16:30 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ValueExpressionImpl implements ValueExpression {

  ClassMirror _expectedType;

  String _expr;

  FunctionMapper _fnMapper;

  VariableMapper _varMapper;

  Node _node;

  ValueExpressionImpl(String expr, Node node, FunctionMapper fnMapper,
          VariableMapper varMapper, ClassMirror expectedType)
      : this._expr = expr,
        this._node = node,
        this._fnMapper = fnMapper,
        this._varMapper = varMapper,
        this._expectedType = expectedType;

  //@Override
  bool operator ==(ValueExpression other)
    => other is ValueExpressionImpl
       && (other as ValueExpressionImpl).hashCode == this.hashCode;

  //@Override
  ClassMirror get expectedType  => this._expectedType;

  //@Override
  String get expressionString => this._expr;

  Node _getNode() {
    if (this._node == null)
      this._node = ExpressionBuilder.createNode(this._expr);
    return this._node;
  }

  //@Override
  ClassMirror getType(ELContext context) {
    EvaluationContext ctx =
        new EvaluationContext(context, this._fnMapper, this._varMapper);
    return this._getNode().getType(ctx);
  }

  //@Override
  Object getValue(ELContext context) {
    EvaluationContext ctx =
      new EvaluationContext(context, this._fnMapper, this._varMapper);
    Object value = this._getNode().getValue(ctx);
    return this._expectedType != null ?
      ELSupport.coerceToType(value, this._expectedType) : value;
  }

  //@Override
  int get hashCode
    => this._getNode().hashCode;

  //@Override
  bool get isLiteralText {
    try {
        return this._getNode() is AstLiteralExpression;
    } on ELException catch (ele) {
        return false;
    }
  }

  //@Override
  bool isReadOnly(ELContext context) {
    EvaluationContext ctx =
        new EvaluationContext(context, this._fnMapper, this._varMapper);
    return this._getNode().isReadOnly(ctx);
  }

  //@Override
  void setValue(ELContext context, Object value) {
    EvaluationContext ctx =
        new EvaluationContext(context, this._fnMapper, this._varMapper);
    this._getNode().setValue(ctx, value);
  }

  //@Override
  String toString()
    => "ValueExpression[${this._expr}]";

  //@Override
  ValueReference getValueReference(ELContext context) {
    EvaluationContext ctx =
        new EvaluationContext(context, this._fnMapper, this._varMapper);
    return this._getNode().getValueReference(ctx);
  }
}
