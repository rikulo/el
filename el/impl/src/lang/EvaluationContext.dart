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
//History: Sat, Sep 15, 2012  05:05:13 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class EvaluationContext extends ELContext {

    final ELContext _elContext;

    final FunctionMapper _fnMapper;

    final VariableMapper _varMapper;

    EvaluationContext(ELContext elContext, FunctionMapper fnMapper,
            VariableMapper varMapper)
        : this._elContext = elContext,
          this._fnMapper = fnMapper,
          this._varMapper = varMapper;

    ELContext getELContext() {
        return this._elContext;
    }

    //@Override
    FunctionMapper getFunctionMapper() {
        return this._fnMapper;
    }

    //@Override
    VariableMapper getVariableMapper() {
        return this._varMapper;
    }

    //@Override
    // Can't use ClassMirror<?> because API needs to match specification in superclass
    Object getContext(ClassMirror key) {
        return this._elContext.getContext(key);
    }

    //@Override
    ELResolver getELResolver() {
        return this._elContext.getELResolver();
    }

    //@Override
    bool isPropertyResolved() {
        return this._elContext.isPropertyResolved();
    }

    //@Override
    // Can't use ClassMirror<?> because API needs to match specification in superclass
    void putContext(ClassMirror key,
            Object contextObject) {
        this._elContext.putContext(key, contextObject);
    }

    //@Override
    void setPropertyResolved(bool resolved) {
        this._elContext.setPropertyResolved(resolved);
    }

    //@Override
    String getLocale() {
        return this._elContext.getLocale();
    }

    //@Override
    void setLocale(String locale) {
        this._elContext.setLocale(locale);
    }
}
