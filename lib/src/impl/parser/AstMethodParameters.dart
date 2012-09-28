//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:47:30 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstMethodParameters extends SimpleNode {
    AstMethodParameters(int id)
        : super(id);

    List<Object> getParameters(EvaluationContext ctx) {
        List<Object> params = new List();
        for (int i = 0; i < this.jjtGetNumChildren(); i++) {
            params.add(this.jjtGetChild(i).getValue(ctx));
        }
        return params;
    }

    List<ClassMirror> getParameterTypes(EvaluationContext ctx) {
        List<ClassMirror> paramTypes = new List();
        for (int i = 0; i < this.jjtGetNumChildren(); i++) {
            paramTypes.add(this.jjtGetChild(i).getType(ctx));
        }
        return paramTypes;
    }
}
