//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:44:11 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class MethodExpressionLiteral implements MethodExpression {

  ClassMirror _expectedType;

  String _expr;

  MethodExpressionLiteral(String expr, ClassMirror expectedType)
      : this._expr = expr,
        this._expectedType = expectedType;

  //@Override
  MethodInfo getMethodInfo(ELContext context)
    => new MethodInfo(new Symbol(this._expr), this._expectedType);

  //@Override
  invoke(ELContext context, List params,
                [Map<String, dynamic> namedArgs])
    => this._expectedType != null ?
       ELSupport.coerceToType(this._expr, this._expectedType) : this._expr;

  //@Override
  String get expressionString => this._expr;

  //@Override
  bool operator ==(MethodExpression other)
    => other is MethodExpressionLiteral
       && this.hashCode == (other as MethodExpressionLiteral).hashCode;

  //@Override
  int get hashCode
    => this._expr.hashCode;

  //@Override
  bool get isLiteralText => true;

  //@Override
  ValueReference getValueReference(ELContext context)
    => null;

  //@Override
  bool get isParametersProvided => false;
}
