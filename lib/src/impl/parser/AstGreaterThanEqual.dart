//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:15:07 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstGreaterThanEqual extends BooleanNode {
    AstGreaterThanEqual(int id)
        : super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        Object obj1 = this.children_[1].getValue(ctx);
        if (obj0 == obj1) {
            return true;
        }
        if (obj0 == null || obj1 == null) {
            return false;
        }
        return (ELSupport.compare(obj0, obj1) >= 0);
    }
}
