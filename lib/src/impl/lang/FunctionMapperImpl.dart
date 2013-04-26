//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:39:40 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class FunctionMapperImpl extends FunctionMapper {

    Map<String, ELFunction> _functions;

    //@Override
    Function resolveFunction(String name) {
        if (_functions != null) {
            ELFunction f = _functions[name];
            return f.getMethod();
        }
        return null;
    }

    void addFunction(String name, Function m) {
        if (_functions == null) {
            _functions = new HashMap();
        }
        ELFunction f = new ELFunction(name, m);
        _functions[name] = f;
    }
}

class ELFunction {

    Function _m;
    String _name;

    /**
     *
     */
    ELFunction(this._name, this._m) {
        if (_name == null) {
            throw new ArgumentError("Name cannot be null");
        }
        if (_m == null) {
            throw new ArgumentError("Function cannot be null");
        }
    }

    Function getMethod() {
        return _m;
    }

    //@Override
    bool equals(Object obj) {
        if (obj is ELFunction) {
            return this.hashCode == obj.hashCode;
        }
        return false;
    }
}
