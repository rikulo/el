//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:27:41 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstChoice extends SimpleNode {
    AstChoice(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        Object val = this.getValue(ctx);
        return (val != null) ? reflect(val).type : null;
    }

    //@Override
    getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        bool b0 = ELSupport.coerceToBoolean(obj0);
        return this.children_[b0 ? 1 : 2].getValue(ctx);
    }
}
