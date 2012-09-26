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
//History: Fri, Sep 14, 2012  03:26:16 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ValueExpressionLiteral implements ValueExpression {

    var _value;

    ClassMirror _expectedType;

    ValueExpressionLiteral(Object value, ClassMirror expectedType)
        : this._value = value,
          this._expectedType = expectedType;

    //@Override
    Object getValue(ELContext context) {
        if (this._expectedType != null) {
            return ELSupport.coerceToType(this._value, this._expectedType);
        }
        return this._value;
    }

    //@Override
    void setValue(ELContext context, Object value) {
        throw new PropertyNotWritableException(MessageFactory.getString(
                "error.value.literal.write", [this._value]));
    }

    //@Override
    bool isReadOnly(ELContext context) {
        return true;
    }

    //@Override
    ClassMirror getType(ELContext context) {
        return (this._value != null) ? reflect(this._value).type : null;
    }

    //@Override
    ClassMirror getExpectedType() {
        return this._expectedType;
    }

    //@Override
    String getExpressionString() {
        return (this._value != null) ? this._value.toString() : null;
    }

    //@Override
    bool operator ==(Object other) {
      if (other is ValueExpressionLiteral) {
        ValueExpressionLiteral ve = other;
        return this._value != null && ve._value != null && this._value == ve._value;
      }
      return false;
    }

    //@Override
    int hashCode() {
        return (this._value != null) ? this._value.hashCode() : 0;
    }

    //@Override
    bool isLiteralText() {
        return true;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    ValueReference getValueReference(ELContext context) => null;

}
