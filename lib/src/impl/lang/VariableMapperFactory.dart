//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:56:13 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class VariableMapperFactory extends VariableMapper {

    VariableMapper _target;
    VariableMapper _momento;

    VariableMapperFactory(VariableMapper target) {
        if (target == null) {
            throw const NullPointerException("Target VariableMapper cannot be null");
        }
        this._target = target;
    }

    VariableMapper create() {
        return this._momento;
    }

    //@Override
    ValueExpression resolveVariable(String variable) {
        ValueExpression expr = this._target.resolveVariable(variable);
        if (expr != null) {
            if (this._momento == null) {
                this._momento = new VariableMapperImpl();
            }
            this._momento.setVariable(variable, expr);
        }
        return expr;
    }

    //@Override
    ValueExpression setVariable(String variable, ValueExpression expression) {
        throw new UnsupportedOperationException("Cannot Set Variables on Factory");
    }
}
