//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:07:51 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstNot extends SimpleNode {
    AstNot(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return ClassUtil.BOOL_MIRROR;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object obj = this.children_[0].getValue(ctx);
        bool b = ELSupport.coerceToBoolean(obj);
        return !b;
    }
}
