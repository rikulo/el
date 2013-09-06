//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  03:28:41 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

abstract class SimpleNode implements Node {
    Node parent_;

    List<Node> children_;

    int id_ = 0;

    String image_;

    SimpleNode(int i) {
        id_ = i;
    }

    //@Override
    void jjtOpen() {
        // NOOP by default
    }

    //@Override
    void jjtClose() {
        // NOOP by default
    }

    //@Override
    void jjtSetParent(Node n) {
        parent_ = n;
    }

    //@Override
    Node jjtGetParent() {
        return parent_;
    }

    //@Override
    void jjtAddChild(Node n, int i) {
        if (children_ == null) {
            children_ = new List(i + 1);
        } else if (i >= children_.length) {
            List<Node> c = new List(i + 1);
            ListUtil.copy(children_, 0, c, 0, children_.length);
            children_ = c;
        }
        children_[i] = n;
    }

    //@Override
    Node jjtGetChild(int i) {
        return children_[i];
    }

    //@Override
    int jjtGetNumChildren() {
        return (children_ == null) ? 0 : children_.length;
    }

    /*
     * You can override these two methods in subclasses of SimpleNode to
     * customize the way the node appears when the tree is dumped. If your
     * output uses more than one line you should override toString(String),
     * otherwise overriding toString() is probably all you need to do.
     */

    //@Override
    String toString() {
        if (this.image_ != null) {
            return "${ELParserTreeConstants.jjtNodeName[id_]}[${this.image_}]";
        }
        return ELParserTreeConstants.jjtNodeName[id_];
    }

    String toStringWithPrefix(String prefix) {
        return "$prefix$toString()";
    }

    //@Override
    String getImage() {
        return image_;
    }

    void setImage(String image) {
        this.image_ = image;
    }

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        throw new UnsupportedError("getType");
    }

    //@Override
    getValue(EvaluationContext ctx) {
        throw new UnsupportedError("getValue");
    }

    //@Override
    bool isReadOnly(EvaluationContext ctx) {
        return true;
    }

    //@Override
    void setValue(EvaluationContext ctx, value) {
        throw new PropertyNotWritableException(MessageFactory.getString("error.syntax.set"));
    }

    //@Override
    void accept(NodeVisitor visitor, int index, int level) {
        visitor.visit(this, index, level);
        if (this.children_ != null && this.children_.length > 0) {
            for (int i = 0; i < this.children_.length; i++) {
                this.children_[i].accept(visitor, i, level+1);
            }
        }
        visitor.after(this, index, level);
    }

    //@Override
    invoke(EvaluationContext ctx, List paramValues, [Map<String, dynamic> namedArgs]) {
        throw new UnsupportedError("invoke");
    }

    //@Override
    MethodInfo getMethodInfo(EvaluationContext ctx) {
        throw new UnsupportedError("getMethodInfo");
    }

    int _arrayHashCode(List ls) {
      if (!ls.isEmpty) {
        final int prime = 31;
        int result = 1;
        ls.forEach((item) {
          result = prime * result + item.hashCode();
        });
        return result;
      }
      return 0;
    }

    //@Override
    int get hashCode {
        final int prime = 31;
        int result = 1;
        result = prime * result + ListUtil.getHashCode(children_);
        result = prime * result + id_;
        result = prime * result + ((image_ == null) ? 0 : image_.hashCode);
        return result;
    }

    //@Override
    bool operator ==(Object obj) {
        if (identical(this, obj)) {
            return true;
        }
        if (!(obj is SimpleNode)) {
            return false;
        }
        SimpleNode other = obj;
        if (!ListUtil.areEqual(children_, other.children_)) {
            return false;
        }
        if (id_ != other.id_) {
            return false;
        }
        if (image_ == null) {
            if (other.image_ != null) {
                return false;
            }
        } else if (image_ != other.image_) {
            return false;
        }
        return true;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    ValueReference getValueReference(EvaluationContext ctx) {
        return null;
    }

    /**
     * @since EL 2.2
     */
    //@Override
    bool isParametersProvided() {
        return false;
    }
}
