//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class BeanELResolver extends ELResolver {
    final bool _readOnly;

    final Map<Symbol, BeanProperties> _cache = new HashMap();

    BeanELResolver([bool readOnly = false]) : this._readOnly = readOnly;

    //@Override
    getValue(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return null;
        }

        context.isPropertyResolved = true;
        return reflect(base).getField(new Symbol(property)).reflectee;
    }

    //@Override
    ClassMirror getType(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return null;
        }

        context.isPropertyResolved = true;
        return this._property(context, base, property).propertyType;
    }

    //@Override
    void setValue(ELContext context, base, property, value) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return;
        }

        context.isPropertyResolved = true;

        if (this._readOnly) {
            throw new PropertyNotWritableException(ELResolver.message(context,
                    "resolverNotWriteable", [reflect(base).type.qualifiedName]));
        }

        return reflect(base).setField(new Symbol(property), value).reflectee;
    }

    //@Override
    bool isReadOnly(ELContext context, base, property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return false;
        }

        context.isPropertyResolved = true;
        return this._readOnly
                || _property(context, base, property).isReadOnly;
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, base) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base != null) {
            return OBJECT_MIRROR;
        }

        return null;
    }

    BeanProperty _property(ELContext ctx, base, property) {
        ClassMirror type = reflect(base).type;
        String prop = property.toString();

        BeanProperties props = this._cache[type.qualifiedName];
        if (props == null || type != props.type) {
            props = new BeanProperties(type);
            this._cache[type.qualifiedName] = props;
        }

        return props._get(ctx, prop);
    }

    /**
     * @since EL 2.2
     */
    //@Override
    invoke(ELContext context, base, method,
            List params, [Map<String, dynamic> namedArgs]) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || method == null) {
            return null;
        }

        String methodName = method.toString();

        context.isPropertyResolved = true;

        return reflect(base).invoke(new Symbol(methodName), params, _toNamedParams(namedArgs)).reflectee;
    }

}

class BeanProperties {
    final ClassMirror _type;

    Map<String, BeanProperty> _properties;

    BeanProperties(ClassMirror type)
        : this._type = type {
        this._properties = new HashMap();
    }

    BeanProperty getBeanProperty(String name) {
        return _get(null, name);
    }

    BeanProperty _get(ELContext ctx, String name) {
        BeanProperty property = this._properties[name];
        if (property == null) {
            property = new BeanProperty(_type, name);
            _properties[name] = property;
        }
        return property;
    }

    ClassMirror get type => _type;
}

class BeanProperty {
    final ClassMirror _owner;
    final String _propertyName;
    TypeMirror _type;

    MethodMirror _read;
    MethodMirror _write;

    BeanProperty(ClassMirror owner, String propertyName)
        : this._owner = owner,
          this._propertyName = propertyName {
        this._read = _getReadMethod();
        if (_read == null) {
            throw new PropertyNotFoundException(ELResolver.message(null,
                    "propertyNotFound", [owner, propertyName]));
        }
        _type = _read.returnType;
        _write = _getWriteMethod();
    }

    ClassMirror get propertyType => this._type;

    bool get isReadOnly => _write == null;

    MethodMirror _getWriteMethod() {
        if (this._write == null) {
            this._write = _getWriteMethod0(this._owner, _propertyName);
        }
        return this._write;
    }

    MethodMirror _getReadMethod() {
        if (this._read == null) {
            this._read = _getReadMethod0(this._owner, _propertyName);
        }
        return this._read;
    }

    MethodMirror _getWriteMethod0(ClassMirror owner, String propertyName) {
        ClassMirror clz = owner;
        MethodMirror m = clz.setters[new Symbol(propertyName)];
        while(!ClassUtil.isTopClass(clz) && (m == null || m.isPrivate)) {
            clz = owner.superclass;
            m = clz.setters[new Symbol(propertyName)];
        }
        return m == null || m.isPrivate ? null : m;
    }

    MethodMirror _getReadMethod0(ClassMirror owner, String propertyName) {
        ClassMirror clz = owner;
        MethodMirror m = clz.getters[new Symbol(propertyName)];
        while(!ClassUtil.isTopClass(clz) && (m == null || m.isPrivate)) {
            clz = owner.superclass;
            m = clz.getters[new Symbol(propertyName)];
        }
        return m == null || m.isPrivate ? null : m;
    }
}
