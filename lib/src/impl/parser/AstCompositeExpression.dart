//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:32:45 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstCompositeExpression extends SimpleNode {

    AstCompositeExpression(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return ClassUtil.STRING_MIRROR;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        StringBuffer sb = new StringBuffer();
        Object obj = null;
        if (this.children_ != null) {
            for (int i = 0; i < this.children_.length; i++) {
                obj = this.children_[i].getValue(ctx);
                if (obj != null) {
                    sb.add(ELSupport.coerceToString(obj));
                }
            }
        }
        return sb.toString();
    }
}
