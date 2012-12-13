//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:31:21 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ArithmeticNode extends SimpleNode {

    ArithmeticNode(int i)
        : super(i);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return ClassUtil.NUM_MIRROR;
    }
}
