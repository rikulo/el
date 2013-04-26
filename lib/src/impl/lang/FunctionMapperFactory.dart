//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:35:07 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class FunctionMapperFactory implements FunctionMapper {

    FunctionMapperImpl _memento;
    FunctionMapper _target;

    FunctionMapperFactory(FunctionMapper mapper) {
        if (mapper == null) {
            throw new ArgumentError("FunctionMapper target cannot be null");
        }
        _target = mapper;
    }


    //@Override
    Function resolveFunction(String name) {
        if (_memento == null) {
            _memento = new FunctionMapperImpl();
        }
        Function m = _target.resolveFunction(name);
        if (m != null) {
            _memento.addFunction(name, m);
        }
        return m;
    }

    FunctionMapper create() {
        return _memento;
    }

}
