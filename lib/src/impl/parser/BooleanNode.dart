//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  06:53:21 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class BooleanNode extends SimpleNode {
    /**
     * @param i
     */
    BooleanNode(int i)
        : super(i);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return ClassUtil.BOOL_MIRROR;
    }
}
