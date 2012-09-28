//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  01:26:17 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstFalse extends BooleanNode {
    AstFalse(int id)
    	: super(id);

    //@Override
    Object getValue(EvaluationContext ctx) {
        return false;
    }
}
