//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:24:18 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

abstract class MethodExpression extends Expression {

    MethodInfo getMethodInfo(ELContext context);

    Object invoke(ELContext context, List<Object> positionalArgs, [Map<String, Object> namedArgs]);

    bool isParametersProvided();
}
