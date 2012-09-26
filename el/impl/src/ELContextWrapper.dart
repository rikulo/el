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
//History: Mon, Sep 24, 2012  01:03:10 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * Simple ELContextWrapper for runtime evaluation of EL w/ dynamic FunctionMappers
 *
 * @author jhook
 */
class ELContextWrapper extends ELContext {

    final ELContext _target;
    final FunctionMapper _fnMapper;

    ELContextWrapper(ELContext target, FunctionMapper fnMapper)
        : this._target = target,
          this._fnMapper = fnMapper;

    //@Override
    ELResolver getELResolver() {
        return this._target.getELResolver();
    }

    //@Override
    FunctionMapper getFunctionMapper() {
        if (this._fnMapper != null) return this._fnMapper;
        return this._target.getFunctionMapper();
    }

    //@Override
    VariableMapper getVariableMapper() {
        return this._target.getVariableMapper();
    }

    //@Override
    Object getContext(ClassMirror key) {
        return this._target.getContext(key);
    }

    //@Override
    String getLocale() {
        return this._target.getLocale();
    }

    //@Override
    bool isPropertyResolved() {
        return this._target.isPropertyResolved();
    }

    //@Override
    void putContext(ClassMirror key, Object contextObject) {
        this._target.putContext(key, contextObject);
    }

    //@Override
    void setLocale(String locale) {
        this._target.setLocale(locale);
    }

    //@Override
    void setPropertyResolved(bool resolved) {
        this._target.setPropertyResolved(resolved);
    }

}
