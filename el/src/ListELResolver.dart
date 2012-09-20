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
//History: Wed, Sep 12, 2012  11:17:17 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ListELResolver extends ELResolver {

    final bool _readOnly;

    ListELResolver([bool readOnly = false])
        : this._readOnly = readOnly;

    //@Override
    Object getValue(ELContext context, Object base, Object property) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is List) {
            context.setPropertyResolved(true);
            List list = base;
            int idx = _coerce(property);
            if (idx < 0 || idx >= list.length) {
                return null;
            }
            return list[idx];
        }

        return null;
    }

    //@Override
    ClassMirror getType(ELContext context, Object base, Object property) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is List) {
            context.setPropertyResolved(true);
            List list = base;
            int idx = _coerce(property);
            if (idx < 0 || idx >= list.length) {
                throw new PropertyNotFoundException(
                        new IndexOutOfRangeException(idx).toString());
            }
            return ClassUtil.OBJECT_MIRROR;
        }

        return null;
    }

    //@Override
    void setValue(ELContext context, Object base, Object property,
            Object value) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is List) {
            context.setPropertyResolved(true);
            List list = base;

            if (this._readOnly) {
                throw new PropertyNotWritableException(message(context,
                        "resolverNotWriteable", [reflect(base).type.qualifiedName]));
            }

            int idx = _coerce(property);
            try {
                list[idx] = value;
            } on UnsupportedOperationException catch(e) {
                throw new PropertyNotWritableException(property, e);
            } on IndexOutOfRangeException catch(e) {
                throw new PropertyNotFoundException(property, e);
            }
        }
    }

    //@Override
    bool isReadOnly(ELContext context, Object base, Object property) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is List) {
            context.setPropertyResolved(true);
            List list = base;
            int idx = _coerce(property);
            if (idx < 0 || idx >= list.length) {
                throw new PropertyNotFoundException(
                        new IndexOutOfRangeException(idx).toString());
            }
            return this._readOnly;
        }

        return this._readOnly;
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, Object base) {
        if (base is List) { // implies base != null
            return ClassUtil.INT_MIRROR;
        }
        return null;
    }

    static int _coerce(Object property) {
        if (property is num) {
            return property.toInt();
        }
        if (property is bool) {
            return property ? 1 : 0;
        }
        if (property is String) {
            return int.parse(property);
        }
        throw new IllegalArgumentException(property != null ? property.toString() : "null");
    }
}
