//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:35:07 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class FunctionMapperFactory implements FunctionMapper {

    FunctionMapperImpl memento_ = null;
    FunctionMapper target_;

    FunctionMapperFactory(FunctionMapper mapper) {
        if (mapper == null) {
            throw new ArgumentError("FunctionMapper target cannot be null");
        }
        this.target_ = mapper;
    }


    //@Override
    Function resolveFunction(String prefix, String localName) {
        if (this.memento_ == null) {
            this.memento_ = new FunctionMapperImpl();
        }
        Function m = this.target_.resolveFunction(prefix, localName);
        if (m != null) {
            this.memento_.addFunction(prefix, localName, m);
        }
        return m;
    }

    FunctionMapper create() {
        return this.memento_;
    }

}
