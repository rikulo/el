//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class ArrayELResolver extends ELResolver {

    final bool _readOnly;

    ArrayELResolver([bool readOnly = false])
        : this._readOnly = readOnly;

    //@Override
    getValue(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base != null && base is List) {
            context.isPropertyResolved = true;
            if ("length" == property) //henerichen@rikulo.org: special suffix
              return base.length;
            int idx = _coerce(property);
            if (idx < 0 || idx >= base.length) {
                return null;
            }
            return base[idx];
        }

        return null;
    }

    //@Override
    ClassMirror getType(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base != null && base is List) {
            context.isPropertyResolved = true;
            int idx = _coerce(property);
            _checkBounds(base, idx);
            return ClassUtil.getElementClassMirror(reflect(base).type);
        }

        return null;
    }

    //@Override
    void setValue(ELContext context, base, property,
            value) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base != null && base is List) {
            context.isPropertyResolved = true;

            if (this._readOnly) {
                throw new PropertyNotWritableException(ELResolver.message(context,
                        "resolverNotWriteable", [reflect(base).type.qualifiedName]));
            }

            int idx = _coerce(property);
            _checkBounds(base, idx);
            if (value != null && !ClassUtil.isInstance(ClassUtil.getElementClassMirror(reflect(base).type), value)) {
                throw new CastError();
//              throw new ClassCastException(message(context, "objectNotAssignable",
//                        [reflect(value).type.qualifiedName, ClassUtil.getElementClassMirror(reflect(base).type).qualifiedName]));
            }
            base[idx] = value;
        }
    }

    //@Override
    bool isReadOnly(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base != null && base is List) {
            context.isPropertyResolved = true;
            int idx = _coerce(property);
            _checkBounds(base, idx);
        }

        return this._readOnly;
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, base) {
        if (base != null && base is List) {
            return INT_MIRROR;
        }
        return null;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    invoke(ELContext context, base, method,
                  List params, [Map<String, dynamic> namedArgs]) => null;

    static void _checkBounds(base, int idx) {
        if (idx < 0 || idx >= (base as List).length) {
            throw new PropertyNotFoundException(new RangeError(idx).toString());
        }
    }

    static int _coerce(property) {
        if (property is num) {
            return property.toInt();
        }
        if (property is bool) {
            return property ? 1 : 0;
        }
        if (property is String) {
            return int.parse(property);
        }
        throw new ArgumentError(property != null ?
                property.toString() : "null");
    }
}
