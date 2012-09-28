//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  05:39:40 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class FunctionMapperImpl extends FunctionMapper {

    Map<String, ELFunction> functions_ = null;

    /*
     * (non-Javadoc)
     *
     * @see javax.el.FunctionMapper#resolveFunction(java.lang.String,
     *      java.lang.String)
     */
    //@Override
    Function resolveFunction(String prefix, String localName) {
        if (this.functions_ != null) {
            ELFunction f = this.functions_["$prefix:$localName"];
            return f.getMethod();
        }
        return null;
    }

    void addFunction(String prefix, String localName, Function m) {
        if (this.functions_ == null) {
            this.functions_ = new Map();
        }
        ELFunction f = new ELFunction(prefix, localName, m);
        this.functions_["$prefix:$localName"] = f;
    }
}

class ELFunction {

    Function m_;
//    String owner_;
//    String name_;
    String prefix_;
    String localName_;

    /**
     *
     */
    ELFunction(String prefix, String localName, Function m) {
        if (localName == null) {
            throw const NullPointerException("LocalName cannot be null");
        }
        if (m == null) {
            throw const NullPointerException("MethodMirror cannot be null");
        }
        this.prefix_ = prefix;
        this.localName_ = localName;
        this.m_ = m;
    }

    Function getMethod() {
        return this.m_;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#equals(java.lang.Object)
     */
    //@Override
    bool equals(Object obj) {
        if (obj is ELFunction) {
            return this.hashCode() == obj.hashCode();
        }
        return false;
    }

    /* (non-Javadoc)
     * @see java.lang.Object#hashCode()
     */
    //@Override
    int hashCode() {
        return "${this.prefix_}${this.localName_}".hashCode();
    }
}
