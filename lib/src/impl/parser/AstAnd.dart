//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:10:11 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstAnd extends BooleanNode {
    AstAnd(int id)
        : super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        Object obj = children_[0].getValue(ctx);
        bool b = ELSupport.coerceToBoolean(obj);
        if (!b) {
            return b;
        }
        obj = children_[1].getValue(ctx);
        b = ELSupport.coerceToBoolean(obj);
        return b;
    }
}
