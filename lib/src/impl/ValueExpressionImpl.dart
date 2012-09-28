//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  03:16:30 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ValueExpressionImpl implements ValueExpression {

    ClassMirror _expectedType;

    String _expr;

    FunctionMapper _fnMapper;

    VariableMapper _varMapper;

    Node _node;

    /**
     *
     */
    ValueExpressionImpl(String expr, Node node, FunctionMapper fnMapper,
            VariableMapper varMapper, ClassMirror expectedType)
            : this._expr = expr,
              this._node = node,
              this._fnMapper = fnMapper,
              this._varMapper = varMapper,
              this._expectedType = expectedType;

    //@Override
    bool operator ==(ValueExpression other) =>
        other is ValueExpressionImpl && (other as ValueExpressionImpl).hashCode() == this.hashCode();

    /*
     * (non-Javadoc)
     *
     * @see javax.el.ValueExpression#getExpectedType()
     */
    //@Override
    ClassMirror getExpectedType() {
        return this._expectedType;
    }

    /**
     * Returns the type the result of the expression will be coerced to after
     * evaluation.
     *
     * @return the <code>expectedType</code> passed to the
     *         <code>ExpressionFactory.createValueExpression</code> method
     *         that created this <code>ValueExpression</code>.
     *
     * @see javax.el.Expression#getExpressionString()
     */
    //@Override
    String getExpressionString() {
        return this._expr;
    }

    /**
     * @return
     * @throws ELException
     */
    Node _getNode() {
        if (this._node == null) {
            this._node = ExpressionBuilder.createNode(this._expr);
        }
        return this._node;
    }

    /*
     * (non-Javadoc)
     *
     * @see javax.el.ValueExpression#getType(javax.el.ELContext)
     */
    //@Override
    ClassMirror getType(ELContext context) {
        EvaluationContext ctx = new EvaluationContext(context, this._fnMapper,
                this._varMapper);
        return this._getNode().getType(ctx);
    }

    /*
     * (non-Javadoc)
     *
     * @see javax.el.ValueExpression#getValue(javax.el.ELContext)
     */
    //@Override
    Object getValue(ELContext context) {
        EvaluationContext ctx = new EvaluationContext(context, this._fnMapper,
                this._varMapper);
        Object value = this._getNode().getValue(ctx);
        if (this._expectedType != null) {
            return ELSupport.coerceToType(value, this._expectedType);
        }
        return value;
    }

    //@Override
    int hashCode() {
        return this._getNode().hashCode();
    }

    /*
     * (non-Javadoc)
     *
     * @see javax.el.ValueExpression#isLiteralText()
     */
    //@Override
    bool isLiteralText() {
        try {
            return this._getNode() is AstLiteralExpression;
        } on ELException catch (ele) {
            return false;
        }
    }

    /*
     * (non-Javadoc)
     *
     * @see javax.el.ValueExpression#isReadOnly(javax.el.ELContext)
     */
    //@Override
    bool isReadOnly(ELContext context) {
        EvaluationContext ctx = new EvaluationContext(context, this._fnMapper,
                this._varMapper);
        return this._getNode().isReadOnly(ctx);
    }

    //@Override
    void setValue(ELContext context, Object value) {
        EvaluationContext ctx = new EvaluationContext(context, this._fnMapper,
                this._varMapper);
        this._getNode().setValue(ctx, value);
    }

    //@Override
    String toString() {
        return "ValueExpression[${this._expr}]";
    }

    /**
     * @since EL 2.2
     */
    //@Override
    ValueReference getValueReference(ELContext context) {
        EvaluationContext ctx = new EvaluationContext(context, this._fnMapper,
                this._varMapper);
        return this._getNode().getValueReference(ctx);
    }

}
