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
//History: Fri, Sep 14, 2012  02:44:11 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class MethodExpressionLiteral implements MethodExpression {

    ClassMirror _expectedType;

    String _expr;

    MethodExpressionLiteral(String expr, ClassMirror expectedType)
        : this._expr = expr,
          this._expectedType = expectedType;

    //@Override
    MethodInfo getMethodInfo(ELContext context) {
        return new MethodInfo(this._expr, this._expectedType);
    }

    //@Override
    Object invoke(ELContext context, List<Object> params, [Map<String, Object> namedArgs]) {
        if (this._expectedType != null) {
            return ELSupport.coerceToType(this._expr, this._expectedType);
        } else {
            return this._expr;
        }
    }

    //@Override
    String getExpressionString() {
        return this._expr;
    }

    //@Override
    bool operator ==(MethodExpression other) =>
        other is MethodExpressionLiteral && this.hashCode() == (other as MethodExpressionLiteral).hashCode();

    //@Override
    int hashCode() {
        return this._expr.hashCode();
    }

    //@Override
    bool isLiteralText() {
        return true;
    }

    //@Override
    ValueReference getValueReference(ELContext context) => null;

    //@Override
    bool isParametersProvided() => false;
}
