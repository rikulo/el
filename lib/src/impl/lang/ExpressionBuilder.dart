//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 15, 2012  04:05:37 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ExpressionBuilder implements NodeVisitor {
    static final Map<String, Node> _cache = new Map();

    FunctionMapper _fnMapper;

    VariableMapper _varMapper;

    String _expression;

    /**
     *
     */
    ExpressionBuilder(String expression, ELContext ctx)
        : this._expression = expression {
      FunctionMapper ctxFn = ctx.functionMapper;
      VariableMapper ctxVar = ctx.variableMapper;

      if (ctxFn != null) {
          this._fnMapper = new FunctionMapperFactory(ctxFn);
      }
      if (ctxVar != null) {
          this._varMapper = new VariableMapperFactory(ctxVar);
      }
    }

    static Node createNode(String expr) {
        Node n = _createNodeInternal(expr);
        return n;
    }

    static Node _createNodeInternal(String expr) {
        if (expr == null) {
            throw new ELException(MessageFactory.getString("error.null"));
        }

        Node n = _cache[expr];
        if (n == null) {
            try {
                n = (new ELParser(new StringReader(expr)))
                        .CompositeExpression();

                // validate composite expression
                int numChildren = n.jjtGetNumChildren();
                if (numChildren == 1) {
                    n = n.jjtGetChild(0);
                } else {
                    ClassMirror type = null;
                    Node child = null;
                    for (int i = 0; i < numChildren; i++) {
                        child = n.jjtGetChild(i);
                        if (child is AstLiteralExpression)
                            continue;
                        if (type == null)
                            type = reflect(child).type;
                        else {
                            if (type != reflect(child).type) {
                                throw new ELException(MessageFactory.getString(
                                        "error.mixed", [expr]));
                            }
                        }
                    }
                }

                if (n is AstDeferredExpression
                        || n is AstDynamicExpression) {
                    n = n.jjtGetChild(0);
                }
                _cache[expr] = n;
            } on Exception catch (e) {
                throw new ELException(
                        MessageFactory.getString("error.parseFail", [expr]), e);
            }
        }
        return n;
    }

    void _prepare(Node node) {
        try {
            node.accept(this, 0, 0);
        } on Exception catch (e) {
            if (e is ELException) {
                throw e;
            } else {
                throw (new ELException(e.toString(), e));
            }
        }
        if (this._fnMapper is FunctionMapperFactory) {
            this._fnMapper = (this._fnMapper as FunctionMapperFactory).create();
        }
        if (this._varMapper is VariableMapperFactory) {
            this._varMapper = (this._varMapper as VariableMapperFactory).create();
        }
    }

    Node _build() {
        Node n = _createNodeInternal(this._expression);
        this._prepare(n);
        if (n is AstDeferredExpression
                || n is AstDynamicExpression) {
            n = n.jjtGetChild(0);
        }
        return n;
    }

    /*
     * (non-Javadoc)
     *
     * @see com.sun.el.parser.NodeVisitor#visit(com.sun.el.parser.Node)
     */
    //@Override
    void visit(Node node, int index, int level) {
        if (node is AstFunction) {

            AstFunction funcNode = node;

            if (this._fnMapper == null) {
                throw new ELException(MessageFactory.getString("error.fnMapper.null"));
            }
            Function fn = _fnMapper.resolveFunction(funcNode.getFunctionName());
            if (fn == null) {
                throw new ELException(MessageFactory.getString(
                        "error.fnMapper.method", [funcNode.getFunctionName()]));
            }
            ClosureMirror fnclosure = reflect(fn);
            MethodMirror m = fnclosure.function;
            if (m == null) {
                throw new ELException(MessageFactory.getString(
                        "error.fnMapper.method", [funcNode.getFunctionName()]));
            }
            ParameterInfo pinfo = new ParameterInfo(m.parameters);
            int pCount = pinfo.positionals.length; //positinal count
            int oCount = pinfo.optionals.length; //optional count
            int aCount = node.jjtGetNumChildren(); //given arguments
            if (aCount < pCount || aCount > (pCount + oCount)) {
                throw new ELException(MessageFactory.getString(
                        "error.fnMapper.paramcount", [funcNode.getFunctionName(),
                        "$pCount", "$oCount", "$aCount"]));
            }
        } else if (node is AstIdentifier && this._varMapper != null) {
            String variable = node.getImage();

            // simply capture it
            this._varMapper.resolveVariable(variable);
        }
    }

    //After all child nodes are visited
    //@Override
    void after(Node node, int index, int level) {
      //do nothing
    }

    ValueExpression createValueExpression(ClassMirror expectedType) {
        Node n = this._build();
        return new ValueExpressionImpl(this._expression, n, this._fnMapper,
                this._varMapper, expectedType);
    }

    MethodExpression createMethodExpression(ClassMirror expectedReturnType) {
        Node n = this._build();
        if (n is AstValue || n is AstIdentifier) {
            return new MethodExpressionImpl(_expression, n, this._fnMapper,
                    this._varMapper, expectedReturnType);
        } else if (n is AstLiteralExpression) {
            return new MethodExpressionLiteral(_expression, expectedReturnType);
        } else {
            throw new ELException("Not a Valid Method Expression: $_expression");
        }
    }
}
