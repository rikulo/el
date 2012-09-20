/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:11:03 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * @see javax.el.ExpressionFactory
 *
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Id: ExpressionFactoryImpl.java 959568 2010-07-01 09:35:23Z markt $
 */
class ExpressionFactoryImpl implements ExpressionFactory {

    //@Override
    Object coerceToType(Object obj, ClassMirror type) {
        return ELSupport.coerceToType(obj, type);
    }

    //@Override
    MethodExpression createMethodExpression(ELContext context,
            String expression, ClassMirror expectedReturnType) {
        ExpressionBuilder builder = new ExpressionBuilder(expression, context);
        return builder.createMethodExpression(expectedReturnType);
    }

    //@Override
    ValueExpression createValueExpression(ELContext context,
            String expression, ClassMirror expectedType) {
        if (expectedType == null) {
            throw new NullPointerException(MessageFactory
                    .getString("error.value.expectedType"));
        }

        ExpressionBuilder builder = new ExpressionBuilder(expression, context);
        return builder.createValueExpression(expectedType);
    }

    //@Override
    ValueExpression createValueExpressionByInstance(Object instance,
            ClassMirror expectedType) {
        if (expectedType == null) {
            throw new NullPointerException(MessageFactory
                    .getString("error.value.expectedType"));
        }
        return new ValueExpressionLiteral(instance, expectedType);
    }
}
