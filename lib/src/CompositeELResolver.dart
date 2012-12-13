//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  10:57:08 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class CompositeELResolver extends ELResolver {
    int _size;

    List<ELResolver> _resolvers;

    CompositeELResolver() {
        this._size = 0;
        this._resolvers = new List(8);
    }

    void add(ELResolver elResolver) {
        if (elResolver == null) {
            throw new ArgumentError("elResolver: null");
        }
        if (this._size >= this._resolvers.length) {
            List<ELResolver> nr = new List(this._size * 2);
            Arrays.copy(this._resolvers, 0, nr, 0, this._size);
            this._resolvers = nr;
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
    Object invoke(ELContext context, Object base, Object method,
        List params, [Map<String, Object> namedArgs]) {
        context.setPropertyResolved(false);
        int sz = this._size;
        Object obj;
        for (int i = 0; i < sz; i++) {
            obj = this._resolvers[i].invoke(context, base, method, params, namedArgs);
            if (context.isPropertyResolved()) {
                return obj;
            }
        }
        return null;
    }
}
