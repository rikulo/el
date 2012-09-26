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
//History: Wed, Sep 12, 2012  11:21:42 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class MapELResolver extends ELResolver {

    final bool _readOnly;

    MapELResolver([bool readOnly = false])
        : this._readOnly = readOnly;

    //@Override
    Object getValue(ELContext context, Object base, Object property) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is Map) {
            context.setPropertyResolved(true);
            //henrichen@rikulo.org: handle special suffix "length"
            return "length" == property ? base.length : base[property];
        }

        return null;
    }

    //@Override
    ClassMirror getType(ELContext context, Object base, Object property) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is Map) {
            context.setPropertyResolved(true);
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

        if (base is Map) {
            context.setPropertyResolved(true);

            if (this._readOnly) {
                throw new PropertyNotWritableException(message(context,
                        "resolverNotWriteable", [reflect(base).type.qualifiedName]));
            }

            try {
                Map<Object, Object> map = base;
                base[property] = value;
            } on UnsupportedOperationException catch(e) {
                throw new PropertyNotWritableException(property, e);
            }
        }
    }

    //@Override
    bool isReadOnly(ELContext context, Object base, Object property) {
        if (context == null) {
            throw const NullPointerException();
        }

        if (base is Map) {
            context.setPropertyResolved(true);
            return this._readOnly;
        }

        return this._readOnly;
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, Object base) {
        if (base is Map) {
            return ClassUtil.OBJECT_MIRROR;
        }
        return null;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    Object invoke(ELContext context, Object base, Object method,
                  List params, [Map<String, Object> namedArgs]) => null;

}
