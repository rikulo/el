//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:38:41 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstMod extends ArithmeticNode {
    AstMod(int id)
        : super(id);

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        Object obj1 = this.children_[1].getValue(ctx);
        return ELArithmetic.mod(obj0, obj1);
    }
}
