//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  03:26:16 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ValueExpressionLiteral implements ValueExpression {

  var _value;

  ClassMirror _expectedType;

  ValueExpressionLiteral(Object value, ClassMirror expectedType)
      : this._value = value,
        this._expectedType = expectedType;

  //@Override
  Object getValue(ELContext context)
    => this._expectedType != null ?
         ELSupport.coerceToType(this._value, this._expectedType) : this._value;

  //@Override
  void setValue(ELContext context, Object value) {
    throw new PropertyNotWritableException(MessageFactory.getString(
              "error.value.literal.write", [this._value]));
  }

  //@Override
  bool isReadOnly(ELContext context)
    => true;

  //@Override
  ClassMirror getType(ELContext context)
    => this._value != null ? reflect(this._value).type : null;

  //@Override
  ClassMirror getExpectedType()
    => this._expectedType;

  //@Override
  String getExpressionString()
    => this._value != null ? this._value.toString() : null;

  //@Override
  bool operator ==(Object other) {
    if (other is ValueExpressionLiteral) {
      ValueExpressionLiteral ve = other;
      return this._value != null
             && ve._value != null && this._value == ve._value;
    }
    return false;
  }

  //@Override
  int get hashCode
    => this._value != null ? this._value.hashCode : 0;

  //@Override
  bool isLiteralText()
    => true;

  //@Override
  ValueReference getValueReference(ELContext context)
    => null;
}
