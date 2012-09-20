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
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 *
 */
abstract class ELContext {

    String _locale;

    Map<ClassMirror, Object> _map;

    bool _resolved;

    /**
     *
     */
    ELContext() : this._resolved = false;

    // Can't use ClassMirror because API needs to match specification
    Object getContext(ClassMirror key) {
        if (this._map == null) {
            return null;
        }
        return this._map[key];
    }

    // Can't use ClassMirror because API needs to match specification
    void putContext(ClassMirror key, Object contextObject) {
        if (key == null || contextObject == null) {
            throw const NullPointerException();
        }

        if (this._map == null) {
            this._map = new Map();
        }

        this._map[key] = contextObject;
    }

    void setPropertyResolved(bool resolved) {
        this._resolved = resolved;
    }

    bool isPropertyResolved() {
        return this._resolved;
    }

    abstract ELResolver getELResolver();

    abstract FunctionMapper getFunctionMapper();

    abstract VariableMapper getVariableMapper();

    String getLocale() {
        return this._locale;
    }

    /** The ISO format for lang_COUNTRY_variant */
    void setLocale(String locale) {
        this._locale = locale;
    }
}
