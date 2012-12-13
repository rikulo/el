//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_el;

class BeanELResolver extends ELResolver {
    final bool _readOnly;

    final Map<String, BeanProperties> _cache = new Map();

    BeanELResolver([bool readOnly = false]) : this._readOnly = readOnly;

    //@Override
    Object getValue(ELContext context, Object base, Object property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return null;
        }

        context.setPropertyResolved(true);
        Future<InstanceMirror> result = reflect(base).getField(property);

        //TODO(henri) : handle exception
        while(!result.isComplete)
            ; //wait another Isolate to complete
        return result.value.reflectee;
    }

    //@Override
    ClassMirror getType(ELContext context, Object base, Object property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return null;
        }

        context.setPropertyResolved(true);
        return this._property(context, base, property).getPropertyType();
    }

    //@Override
    void setValue(ELContext context, Object base, Object property, Object value) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return;
        }

        context.setPropertyResolved(true);

        if (this._readOnly) {
            throw new PropertyNotWritableException(message(context,
                    "resolverNotWriteable", [reflect(base).type.qualifiedName]));
        }

        Future<InstanceMirror> result = reflect(base).setField(property, value);

        //TODO(henri) : handle exception
        while(!result.isComplete)
            ; //wait another Isolate to complete
    }

    //@Override
    bool isReadOnly(ELContext context, Object base, Object property) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || property == null) {
            return false;
        }

        context.setPropertyResolved(true);
        return this._readOnly
                || _property(context, base, property).isReadOnly();
    }

    //@Override
    ClassMirror getCommonPropertyType(ELContext context, Object base) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }

        if (base != null) {
            return ClassUtil.OBJECT_MIRROR;
        }

        return null;
    }

    BeanProperty _property(ELContext ctx, Object base, Object property) {
        ClassMirror type = reflect(base).type;
        String prop = property.toString();

        BeanProperties props = this._cache[type.qualifiedName];
        if (props == null || type != props.getType()) {
            props = new BeanProperties(type);
            this._cache[type.qualifiedName] = props;
        }

        return props._get(ctx, prop);
    }

    /**
     * @since EL 2.2
     */
    //@Override
    Object invoke(ELContext context, Object base, Object method,
            List<Object> params, [Map<String, Object> namedArgs]) {
        if (context == null) {
            throw new ArgumentError("context: null");
        }
        if (base == null || method == null) {
            return null;
        }

        String methodName = method.toString();

        context.setPropertyResolved(true);

        Future<InstanceMirror> result = reflect(base).invoke(methodName, params, namedArgs);

        //TODO(henri) : handle exception
        while(!result.isComplete)
            ; //wait another Isolate to complete
        return result.value.reflectee;
    }

}

class BeanProperties {
    final ClassMirror _type;

    Map<String, BeanProperty> _properties;

    BeanProperties(ClassMirror type)
        : this._type = type {
        this._properties = new Map();
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

    ClassMirror getType() => _type;
}

class BeanProperty {
    final ClassMirror _owner;
    final String _propertyName;
    ClassMirror _type;

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
        _type = ClassUtil.getCorrespondingClassMirror(_read.returnType);
        _write = _getWriteMethod();
    }

    ClassMirror getPropertyType() {
        return this._type;
    }

    bool isReadOnly() {
        return _write == null;
    }

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
        MethodMirror m = clz.setters[propertyName];
        while(!ClassUtil.isTopClass(clz) && (m == null || m.isPrivate)) {
            clz = owner.superclass;
            m = clz.setters[propertyName];
        }
        return m == null || m.isPrivate ? null : m;
    }

    MethodMirror _getReadMethod0(ClassMirror owner, String propertyName) {
        ClassMirror clz = owner;
        MethodMirror m = clz.getters[propertyName];
        while(!ClassUtil.isTopClass(clz) && (m == null || m.isPrivate)) {
            clz = owner.superclass;
            m = clz.getters[propertyName];
        }
        return m == null || m.isPrivate ? null : m;
    }
}
