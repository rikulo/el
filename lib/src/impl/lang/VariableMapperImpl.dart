//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:59:17 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class VariableMapperImpl extends VariableMapper {

    Map<String, ValueExpression> _vars = new Map();

    //@Override
    ValueExpression resolveVariable(String variable) {
        return this._vars[variable];
    }

    //@Override
    ValueExpression setVariable(String variable,
            ValueExpression expression) {
        return this._vars[variable] = expression;
    }
}
