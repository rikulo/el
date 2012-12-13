//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:22:57 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstEmpty extends SimpleNode {
    AstEmpty(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return ClassUtil.BOOL_MIRROR;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object obj = this.children_[0].getValue(ctx);
        if (obj == null) {
            return true;
        } else if (obj is String) {
            return obj.length == 0;
        } else if (obj is Collection) {
            return obj.isEmpty;
        } else if (obj is Map) {
            return obj.isEmpty;
        }
        return false;
    }
}
