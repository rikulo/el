//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:50:07 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class AstValue extends SimpleNode {

    static final bool COERCE_TO_ZERO = true; //TODO(henri) : make it configurable?

    AstValue(int id)
      : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        Target_ t = _getTarget(ctx);
        ctx.setPropertyResolved(false);
        ClassMirror result = ctx.getELResolver().getType(ctx, t.base_, t.property_);
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled", [t.base_, t.property_]));
        }
        return result;
    }

    Target_ _getTarget(EvaluationContext ctx) {
        // evaluate expr-a to value-a
        Object base = this.children_[0].getValue(ctx);

        // if our base is null (we know there are more properties to evaluate)
        if (base == null) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.unreachable.base", [this.children_[0].getImage()]));
        }

        // set up our start/end
        Object property = null;
        int propCount = this.jjtGetNumChildren();

        int i = 1;
        // evaluate any properties or methods before our target
        ELResolver resolver = ctx.getELResolver();
        while (i < propCount) {
            if (i + 2 < propCount &&
                    this.children_[i + 1] is AstMethodParameters) {
                // Method call not at end of expression
              //TODO(henri): namedArgs is not supported yet
                Map<String, Object> namedArgs = null;
                base = resolver.invoke(ctx, base,
                        this.children_[i].getValue(ctx),
                        (this.children_[i + 1] as AstMethodParameters).getParameters(ctx), namedArgs);
                i += 2;
            } else if (i + 2 == propCount &&
                    this.children_[i + 1] is AstMethodParameters) {
                // Method call at end of expression
                ctx.setPropertyResolved(false);
                property = this.children_[i].getValue(ctx);
                i += 2;

                if (property == null) {
                    throw new PropertyNotFoundException(MessageFactory.getString(
                            "error.unreachable.property", [property]));
                }
            } else if (i + 1 < propCount) {
                // Object with property not at end of expression
                property = this.children_[i].getValue(ctx);
                ctx.setPropertyResolved(false);
                base = resolver.getValue(ctx, base, property);
                i++;

            } else {
                // Object with property at end of expression
                ctx.setPropertyResolved(false);
                property = this.children_[i].getValue(ctx);
                i++;

                if (property == null) {
                    throw new PropertyNotFoundException(MessageFactory.getString(
                            "error.unreachable.property", [property]));
                }
            }
            if (base == null) {
                throw new PropertyNotFoundException(MessageFactory.getString(
                        "error.unreachable.property", [property]));
            }
        }

        Target_ t = new Target_();
        t.base_ = base;
        t.property_ = property;
        return t;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object base = this.children_[0].getValue(ctx);
        int propCount = this.jjtGetNumChildren();
        int i = 1;
        Object suffix = null;
        ELResolver resolver = ctx.getELResolver();
        while (base != null && i < propCount) {
            suffix = this.children_[i].getValue(ctx);
            if (i + 1 < propCount &&
                    (this.children_[i+1] is AstMethodParameters)) {
                AstMethodParameters mps =
                    this.children_[i+1];
                // This is a method
                base = resolver.invoke(ctx, base, suffix,
                        mps.getParameters(ctx));
                i+=2;
            } else {
                // This is a property
                if (suffix == null) {
                    return null;
                }

                ctx.setPropertyResolved(false);
                base = resolver.getValue(ctx, base, suffix);
                i++;
            }
        }
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled", [base, suffix]));
        }
        return base;
    }

    //@Override
    bool isReadOnly(EvaluationContext ctx) {
        Target_ t = _getTarget(ctx);
        ctx.setPropertyResolved(false);
        bool result =
            ctx.getELResolver().isReadOnly(ctx, t.base_, t.property_);
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled", [t.base_, t.property_]));
        }
        return result;
    }

    //@Override
    void setValue(EvaluationContext ctx, Object value)
            {
        Target_ t = _getTarget(ctx);
        ctx.setPropertyResolved(false);
        ELResolver resolver = ctx.getELResolver();

        // coerce to the expected type
        ClassMirror targetClass = resolver.getType(ctx, t.base_, t.property_);
        if (COERCE_TO_ZERO == true
                || !_isAssignable(value, targetClass)) {
            resolver.setValue(ctx, t.base_, t.property_,
                ELSupport.coerceToType(value, targetClass));
        } else {
            resolver.setValue(ctx, t.base_, t.property_, value);
        }
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled", [t.base_, t.property_]));
        }
    }

    bool _isAssignable(Object value, ClassMirror targetClass) {
        if (targetClass == null) {
            return false;
        // } else if (value != null && targetClass.isPrimitive()) {
        //     return false;
        } else if (value != null && !ClassUtil.isInstance(targetClass, value)) {
            return false;
        }
        return true;
    }


    //@Override
    // Interface el.parser.Node uses raw types (and is auto-generated)
    MethodInfo getMethodInfo(EvaluationContext ctx)
            {
        Target_ t = _getTarget(ctx);
        MethodMirror m = ReflectionUtil.getMethod(
                t.base_, t.property_);
        return new MethodInfo(m.simpleName, ClassUtil.getCorrespondingClassMirror(m.returnType));
    }

    //@Override
    // Interface el.parser.Node uses a raw type (and is auto-generated)
    Object invoke(EvaluationContext ctx,
            List<Object> paramValues, [Map<String, Object> namedArgs]) {

        Target_ t = _getTarget(ctx);
        MethodMirror m = null;
        List<Object> values = null;
        //List<ClassMirror> types = null;
        if (isParametersProvided()) {
            values = (this.jjtGetChild(this.jjtGetNumChildren() - 1) as AstMethodParameters)
                .getParameters(ctx);
            //types = _getTypesFromValues(values);
        } else {
            values = paramValues;
            //types = paramTypes;
        }
        m = ReflectionUtil.getMethod(t.base_, t.property_);
        // Handle varArgs and any co-ercion required
        values = ELSupport.convertArgs(values, m, this);
        Object result = null;
        result = ClassUtil.invoke(t.base_, m, values, namedArgs);
//        try {
//            result = ClassUtil.invoke(t.base_, m, values, namedArgs);
//        } on IllegalAccessException catch (iae) {
//            throw new ELException(iae);
//        } on IllegalArgumentException catch (iae) {
//            throw new ELException(iae);
//        } on InvocationTargetException catch (ite) {
//            Throwable cause = ite.getCause();
//            throw new ELException(cause);
//        }
        return result;
    }

//    List<ClassMirror> _getTypesFromValues(List<Object> values) {
//        if (values == null) {
//            return null;
//        }
//
//        List<ClassMirror> result = new List(values.length);
//        for (int i = 0; i < values.length; i++) {
//            if (values[i] == null) {
//                result[i] = null;
//            } else {
//                result[i] = values[i].getClass();
//            }
//        }
//        return result;
//    }


    /**
     * @since EL 2.2
     */
    //@Override
    ValueReference getValueReference(EvaluationContext ctx) {
        // Check this is a reference to a base and a property
        if (this.children_.length > 2 &&
                this.jjtGetChild(2) is AstMethodParameters) {
            // This is a method call
            return null;
        }
        Target_ t = _getTarget(ctx);
        return new ValueReference(t.base_, t.property_);
    }


    /**
     * @since EL 2.2
     */
    //@Override
    bool isParametersProvided() {
        // Assumption is that method parameters, if present, will be the last
        // child
        int len = children_.length;
        if (len > 2) {
            if (this.jjtGetChild(len - 1) is AstMethodParameters) {
                return true;
            }
        }
        return false;
    }
}

class Target_ {
    Object base_;

    Object property_;
}

