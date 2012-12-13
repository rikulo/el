//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:00:25 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstNull extends SimpleNode {
    AstNull(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return null;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        return null;
    }
}
