//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:34:09 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstDeferredExpression extends SimpleNode {
    AstDeferredExpression(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return this.children_[0].getType(ctx);
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        return this.children_[0].getValue(ctx);
    }

    //@Override
    bool isReadOnly(EvaluationContext ctx) {
        return this.children_[0].isReadOnly(ctx);
    }

    //@Override
    void setValue(EvaluationContext ctx, Object value) {
        this.children_[0].setValue(ctx, value);
    }
}
