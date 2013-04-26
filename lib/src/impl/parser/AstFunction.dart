//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:00:01 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstFunction extends SimpleNode {

    String localName_ = "";

    String prefix_ = "";

    AstFunction(int id)
        : super(id);

    String getLocalName() {
        return localName_;
    }

    String getOutputName() {
        if (this.prefix_ == null) {
            return this.localName_;
        } else {
            return "${this.prefix_}:${this.localName_}";
        }
    }

    String getPrefix() {
        return prefix_;
    }

    //@Override
    TypeMirror getType(EvaluationContext ctx) {

        FunctionMapper fnMapper = ctx.getFunctionMapper();

        // quickly validate again for this request
        if (fnMapper == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.null"));
        }
        Function fn = fnMapper.resolveFunction(this.prefix_, this.localName_);
        if (fn == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [this.getOutputName()]));
        }
        ClosureMirror fnclosure = reflect(fn);
        MethodMirror m = fnclosure.function;
        if (m == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [this.getOutputName()]));
        }
        //20120930, henrichen: #issue4 support top level function
        _TopLevelFn tfn = _TopLevelFn._getTopLevelFn(fn, m);
        if (tfn != null)
          m = tfn._method;

        return m.returnType;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {

        FunctionMapper fnMapper = ctx.getFunctionMapper();

        // quickly validate again for this request
        if (fnMapper == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.null"));
        }
        Function fn = fnMapper.resolveFunction(this.prefix_, this.localName_);
        if (fn == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [this.getOutputName()]));
        }
        ClosureMirror fnclosure = reflect(fn);
        MethodMirror m = fnclosure.function;
        if (m == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [this.getOutputName()]));
        }

        List values = null;
        int numParams = this.jjtGetNumChildren(); //TODO(henri): namedArgs not supported yet
        if (numParams > 0) {
            values = new List(numParams);
            try {
                for (int i = 0; i < numParams; i++) {
                    values[i] = this.children_[i].getValue(ctx);
                }
            } on ELException catch (ele) {
                throw new ELException(MessageFactory.getString("error.function", [this
                        .getOutputName()]), ele);
            }
        } else {
          values = new List(0);
        }
        //20120930, henrichen: #issue4 support top level function
        _TopLevelFn tfn = _TopLevelFn._getTopLevelFn(fn, m);
        if (tfn != null)
          m = tfn._method;

        List params = ELSupport.convertArgs(values, m, this);

        Object result = tfn == null ?
            ClassUtil.apply(fn, params) :
            ClassUtil.invokeByMirror(tfn._lib, m, params);
//        try {
//            result = m.invoke(null, params);
//        } on IllegalAccessException catch (iae) {
//            throw new ELException(MessageFactory.getString("error.function", [this
//                    .getOutputName()]), iae);
//        } on InvocationTargetException catch (ite) {
//            Throwable cause = ite.getCause();
//            throw new ELException(MessageFactory.getString("error.function", [this
//                    .getOutputName()]), cause);
//        }
        return result;
    }

    void setLocalName(String localName) {
        this.localName_ = localName;
    }

    void setPrefix(String prefix) {
        this.prefix_ = prefix;
    }


    //@Override
    String toString()
    {
        return "${ELParserTreeConstants.jjtNodeName[id_]}[${this.getOutputName()}]";
    }
}
