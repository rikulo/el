//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  02:16:37 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstEqual extends BooleanNode {
    AstEqual(int id)
        : super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        Object obj0 = this.children_[0].getValue(ctx);
        Object obj1 = this.children_[1].getValue(ctx);
        return ELSupport.areEqual(obj0, obj1);
    }
}
