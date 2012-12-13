//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:13:35 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstGreaterThan extends BooleanNode {
    AstGreaterThan(int id)
        : super(id);

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        if (obj0 == null) {
            return false;
        }
        Object obj1 = this.children_[1].getValue(ctx);
        if (obj1 == null) {
            return false;
        }
        return ELSupport.compare(obj0, obj1) > 0;
    }
}
