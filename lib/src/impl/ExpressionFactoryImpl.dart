//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:11:03 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ExpressionFactoryImpl implements ExpressionFactory {

    //@Override
    Object coerceToType(Object obj, ClassMirror type) {
        return ELSupport.coerceToType(obj, type);
    }

    //@Override
    MethodExpression createMethodExpression(ELContext context,
            String expression, [ClassMirror expectedReturnType]) {
        ExpressionBuilder builder = new ExpressionBuilder(expression, context);
        return builder.createMethodExpression(expectedReturnType);
    }

    //@Override
    ValueExpression createValueExpression(ELContext context,
            String expression, [ClassMirror expectedType]) {
        if (expectedType == null) {
            expectedType = OBJECT_MIRROR;
        }

        ExpressionBuilder builder = new ExpressionBuilder(expression, context);
        return builder.createValueExpression(expectedType);
    }

    //@Override
    ValueExpression createVariable(Object instance, [ClassMirror expectedType]) {
        if (expectedType == null) {
            expectedType = instance != null ? reflect(instance).type: OBJECT_MIRROR;
        }
        return new ValueExpressionLiteral(instance, expectedType);
    }
}
