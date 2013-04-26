//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:40:24 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

///A variable mapper.
abstract class VariableMapper {

  ///Returns the value expression of the given variable, or null if not found.
  ValueExpression resolveVariable(String variable);

  ///Assigns a value expression to the given variable
	///To create a value expression, please refer to [ExpressionFactory].
  ValueExpression setVariable(String variable, ValueExpression expression);
}
