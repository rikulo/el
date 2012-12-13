//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:36:31 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstIdentifier extends SimpleNode {
    AstIdentifier(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        VariableMapper varMapper = ctx.getVariableMapper();
        if (varMapper != null) {
            ValueExpression expr = varMapper.resolveVariable(this.image_);
            if (expr != null) {
                return expr.getType(ctx.getELContext());
            }
        }
        ctx.setPropertyResolved(false);
        ClassMirror result = ctx.getELResolver().getType(ctx, null, this.image_);
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled.null", [this.image_]));
        }
        return result;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        VariableMapper varMapper = ctx.getVariableMapper();
        if (varMapper != null) {
            ValueExpression expr = varMapper.resolveVariable(this.image_);
            if (expr != null) {
                return expr.getValue(ctx.getELContext());
            }
        }
        ctx.setPropertyResolved(false);
        Object result = ctx.getELResolver().getValue(ctx, null, this.image_);
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled.null", [this.image_]));
        }
        return result;
    }

    //@Override
    bool isReadOnly(EvaluationContext ctx) {
        VariableMapper varMapper = ctx.getVariableMapper();
        if (varMapper != null) {
            ValueExpression expr = varMapper.resolveVariable(this.image_);
            if (expr != null) {
                return expr.isReadOnly(ctx.getELContext());
            }
        }
        ctx.setPropertyResolved(false);
        bool result = ctx.getELResolver().isReadOnly(ctx, null, this.image_);
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled.null", [this.image_]));
        }
        return result;
    }

    //@Override
    void setValue(EvaluationContext ctx, Object value) {
        VariableMapper varMapper = ctx.getVariableMapper();
        if (varMapper != null) {
            ValueExpression expr = varMapper.resolveVariable(this.image_);
            if (expr != null) {
                expr.setValue(ctx.getELContext(), value);
                return;
            }
        }
        ctx.setPropertyResolved(false);
        ctx.getELResolver().setValue(ctx, null, this.image_, value);
        if (!ctx.isPropertyResolved()) {
            throw new PropertyNotFoundException(MessageFactory.getString(
                    "error.resolver.unhandled.null", [this.image_]));
        }
    }

    //@Override
    Object invoke(EvaluationContext ctx,
            List<Object> paramValues, [Map<String, Object> namedArgs]) {
        return this._getMethodExpression(ctx).invoke(ctx.getELContext(), paramValues);
    }


    //@Override
    MethodInfo getMethodInfo(EvaluationContext ctx) {
        return this._getMethodExpression(ctx).getMethodInfo(ctx.getELContext());
    }

    //@Override
    void setImage(String image) {
        if (!Validation.isIdentifier(image)) {
            throw new ELException(MessageFactory.getString("error.identifier.notdart",
                    [image]));
        }
        this.image_ = image;
    }


    //@Override
    ValueReference getValueReference(EvaluationContext ctx) {
        VariableMapper varMapper = ctx.getVariableMapper();

        if (varMapper == null) {
            return null;
        }

        ValueExpression expr = varMapper.resolveVariable(this.image_);

        if (expr == null) {
            return null;
        }

        return expr.getValueReference(ctx);
    }


    MethodExpression _getMethodExpression(EvaluationContext ctx) {
        Object obj = null;

        // case A: ValueExpression exists, getValue which must
        // be a MethodExpression
        VariableMapper varMapper = ctx.getVariableMapper();
        ValueExpression ve = null;
        if (varMapper != null) {
            ve = varMapper.resolveVariable(this.image_);
            if (ve != null) {
                obj = ve.getValue(ctx);
            }
        }

        // case B: evaluate the identity against the ELResolver, again, must be
        // a MethodExpression to be able to invoke
        if (ve == null) {
            ctx.setPropertyResolved(false);
            obj = ctx.getELResolver().getValue(ctx, null, this.image_);
        }

        // finally provide helpful hints
        if (obj is MethodExpression) {
            return obj;
        } else if (obj == null) {
            throw new MethodNotFoundException("Identity '${this.image_}"
                    "' was null and was unable to invoke");
        } else {
            throw new ELException(
                    "Identity '"
                            "${this.image_}"
                            "' does not reference a MethodExpression instance, returned type: "
                            "${reflect(obj).type.qualifiedName}");
        }
    }
}
