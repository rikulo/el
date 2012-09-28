//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:40:24 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

abstract class VariableMapper {

    ValueExpression resolveVariable(String variable);

    ValueExpression setVariable(String variable, ValueExpression expression);
}
