//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  03:25:13 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstTrue extends BooleanNode {
    AstTrue(int id)
    	: super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        return true;
    }
}
