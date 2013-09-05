//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:48:21 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstPlus extends ArithmeticNode {
    AstPlus(int id)
        : super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        Object obj1 = this.children_[1].getValue(ctx);
        return ELArithmetic.add(obj0, obj1);
    }
}
