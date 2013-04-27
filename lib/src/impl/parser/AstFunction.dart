//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:00:01 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstFunction extends SimpleNode {

    String _localName = "";

    String _prefix = "";

    AstFunction(int id)
        : super(id);

    String getLocalName() {
        return _localName;
    }

    String getPrefix() {
        return _prefix;
    }
    String getFunctionName() {
        if (_prefix == null || _prefix.isEmpty) {
            return _localName;
        } else {
            return "$_prefix:$_localName";
        }
    }

    //@Override
    TypeMirror getType(EvaluationContext ctx) {

        FunctionMapper fnMapper = ctx.functionMapper;

        // quickly validate again for this request
        if (fnMapper == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.null"));
        }
        Function fn = fnMapper.resolveFunction(getFunctionName());
        if (fn == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [getFunctionName()]));
        }
        ClosureMirror fnclosure = reflect(fn);
        MethodMirror m = fnclosure.function;
        if (m == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [getFunctionName()]));
        }
        return m.returnType;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {

        FunctionMapper fnMapper = ctx.functionMapper;

        // quickly validate again for this request
        if (fnMapper == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.null"));
        }
        Function fn = fnMapper.resolveFunction(getFunctionName());
        if (fn == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [getFunctionName()]));
        }
        ClosureMirror fnclosure = reflect(fn);
        MethodMirror m = fnclosure.function;
        if (m == null) {
            throw new ELException(MessageFactory.getString("error.fnMapper.method",
                    [getFunctionName()]));
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
                        .getFunctionName()]), ele);
            }
        } else {
          values = new List(0);
        }

        List params = ELSupport.convertArgs(values, m, this);

        Object result = ClassUtil.apply(fn, params);
//        try {
//            result = m.invoke(null, params);
//        } on IllegalAccessException catch (iae) {
//            throw new ELException(MessageFactory.getString("error.function", [this
//                    .getFunctionName()]), iae);
//        } on InvocationTargetException catch (ite) {
//            Throwable cause = ite.getCause();
//            throw new ELException(MessageFactory.getString("error.function", [this
//                    .getFunctionName()]), cause);
//        }
        return result;
    }

    void setLocalName(String localName) {
        _localName = localName;
    }

    void setPrefix(String prefix) {
        _prefix = prefix;
    }


    //@Override
    String toString()
    {
        return "${ELParserTreeConstants.jjtNodeName[id_]}[${getFunctionName()}]";
    }
}
