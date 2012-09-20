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
//History: Wed, Sep 12, 2012  10:57:08 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class CompositeELResolver extends ELResolver {
    int _size;

    List<ELResolver> _resolvers;

    CompositeELResolver() {
        this._size = 0;
        this._resolvers = new List();
    }

    void add(ELResolver elResolver) {
        if (elResolver == null) {
            throw const NullPointerException();
        }
        this._resolvers[this._size++] = elResolver;
    }

    //@Override
    Object getValue(ELContext context, Object base, Object property) {
        context.setPropertyResolved(false);
        int sz = this._size;
        Object result = null;
        for (int i = 0; i < sz; i++) {
            result = this._resolvers[i].getValue(context, base, property);
            if (context.isPropertyResolved()) {
                return result;
            }
        }
        return null;
    }

    //@Override
    void setValue(ELContext context, Object base, Object property, Object value) {
        context.setPropertyResolved(false);
        int sz = this._size;
        for (int i = 0; i < sz; i++) {
            this._resolvers[i].setValue(context, base, property, value);
            if (context.isPropertyResolved()) {
                return;
            }
        }
    }

    //@Override
    bool isReadOnly(ELContext context, Object base, Object property) {
        context.setPropertyResolved(false);
        int sz = this._size;
        bool readOnly = false;
        for (int i = 0; i < sz; i++) {
            readOnly = this._resolvers[i].isReadOnly(context, base, property);
            if (context.isPropertyResolved()) {
                return readOnly;
            }
        }
        return false;
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, Object base) {
        int sz = this._size;
        ClassMirror commonType = null, type = null;
        for (int i = 0; i < sz; i++) {
            type = this._resolvers[i].getCommonPropertyType(context, base);
            if (type != null
                    && (commonType == null || ClassUtil.isAssignableFrom(commonType, type))) {
                commonType = type;
            }
        }
        return commonType;
    }

    //@Override
    ClassMirror getType(ELContext context, Object base, Object property) {
        context.setPropertyResolved(false);
        int sz = this._size;
        ClassMirror type;
        for (int i = 0; i < sz; i++) {
            type = this._resolvers[i].getType(context, base, property);
            if (context.isPropertyResolved()) {
                return type;
            }
        }
        return null;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    Object invoke(ELContext context, Object base, Object method, List params) {
        context.setPropertyResolved(false);
        int sz = this._size;
        Object obj;
        for (int i = 0; i < sz; i++) {
            obj = this._resolvers[i].invoke(context, base, method, params);
            if (context.isPropertyResolved()) {
                return obj;
            }
        }
        return null;
    }
}
