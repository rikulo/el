//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:19:20 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstNotEqual extends BooleanNode {
    AstNotEqual(int id)
        : super(id);

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        Object obj1 = this.children_[1].getValue(ctx);
        return !ELSupport.areEqual(obj0, obj1);
    }
}
