/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  03:16:30 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * An <code>Expression</code> that can get or set a value.
 *
 * <p>
 * In previous incarnations of this API, expressions could only be read.
 * <code>ValueExpression</code> objects can now be used both to retrieve a
 * value and to set a value. Expressions that can have a value set on them are
 * referred to as l-value expressions. Those that cannot are referred to as
 * r-value expressions. Not all r-value expressions can be used as l-value
 * expressions (e.g. <code>"${1+1}"</code> or
 * <code>"${firstName} ${lastName}"</code>). See the EL Specification for
 * details. Expressions that cannot be used as l-values must always return
 * <code>true</code> from <code>isReadOnly()</code>.
 * </p>
 *
 * <p>
 * <code>The {@link javax.el.ExpressionFactory#createValueExpression} method
 * can be used to parse an expression string and return a concrete instance
 * of <code>ValueExpression</code> that encapsulates the parsed expression.
 * The {@link FunctionMapper} is used at parse time, not evaluation time,
 * so one is not needed to evaluate an expression using this class.
 * However, the {@link ELContext} is needed at evaluation time.</p>
 *
 * <p>The {@link #getValue}, {@link #setValue}, {@link #isReadOnly} and
 * {@link #getType} methods will evaluate the expression each time they are
 * called. The {@link javax.el.ELResolver} in the <code>ELContext</code> is used
 * to resolve the top-level variables and to determine the behavior of the
 * <code>.</code> and <code>[]</code> operators. For any of the four methods,
 * the {@link javax.el.ELResolver#getValue} method is used to resolve all
 * properties up to but excluding the last one. This provides the
 * <code>base</code> object. At the last resolution, the
 * <code>ValueExpression</code> will call the corresponding
 * {@link javax.el.ELResolver#getValue}, {@link javax.el.ELResolver#setValue},
 * {@link javax.el.ELResolver#isReadOnly} or {@link javax.el.ELResolver#getType}
 * method, depending on which was called on the <code>ValueExpression</code>.
 * </p>
 *
 * <p>See the notes about comparison, serialization and immutability in
 * the {@link javax.el.Expression} javadocs.
 *
 * @see javax.el.ELResolver
 * @see javax.el.Expression
 * @see javax.el.ExpressionFactory
 * @see javax.el.ValueExpression
 *
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Id: ValueExpressionImpl.java 1026769 2010-10-24 11:55:10Z markt $
 */
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

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#equals(java.lang.Object)
     */
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

    /*
     * (non-Javadoc)
     *
     * @see java.lang.Object#hashCode()
     */
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

    /*
     * (non-Javadoc)
     *
     * @see javax.el.ValueExpression#setValue(javax.el.ELContext,
     *      java.lang.Object)
     */
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
