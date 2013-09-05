//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:21:42 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class MapELResolver extends ELResolver {

    final bool _readOnly;

    MapELResolver([bool readOnly = false])
        : this._readOnly = readOnly;

    //@Override
    getValue(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base is Map) {
            context.isPropertyResolved = true;
            //henrichen@rikulo.org: handle special suffix "length"
            return "length" == property ? base.length : base[property];
        }

        return null;
    }

    //@Override
    ClassMirror getType(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base is Map) {
            context.isPropertyResolved = true;
            return OBJECT_MIRROR;
        }

        return null;
    }

    //@Override
    void setValue(ELContext context, base, property,
            value) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base is Map) {
            context.isPropertyResolved = true;

            if (this._readOnly) {
                throw new PropertyNotWritableException(ELResolver.message(context,
                        "resolverNotWriteable", [reflect(base).type.qualifiedName]));
            }

            try {
                Map<Object, Object> map = base;
                base[property] = value;
            } on UnsupportedError catch(e) {
                throw new PropertyNotWritableException(property, e);
            }
        }
    }

    //@Override
    bool isReadOnly(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base is Map) {
            context.isPropertyResolved = true;
            return this._readOnly;
        }

        return this._readOnly;
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, base) {
        if (base is Map) {
            return OBJECT_MIRROR;
        }
        return null;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    invoke(ELContext context, base, method,
                  List params, [Map<String, dynamic> namedArgs]) => null;

}
