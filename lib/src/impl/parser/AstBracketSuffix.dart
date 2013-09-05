//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:55:01 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstBracketSuffix extends SimpleNode {
    AstBracketSuffix(int id)
        : super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        return this.children_[0].getValue(ctx);
    }
}
