//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  06:14:41 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

abstract class Node {

  /** This method is called after the node has been made the current
    node.  It indicates that child nodes can now be added to it. */
  void jjtOpen();

  /** This method is called after all the child nodes have been
    added. */
  void jjtClose();

  /** This pair of methods are used to inform the node of its
    parent. */
  void jjtSetParent(Node n);
  Node jjtGetParent();

  /** This method tells the node to add its argument to the node's
    list of children.  */
  void jjtAddChild(Node n, int i);

  /** This method returns a child node.  The children are numbered
     from zero, left to right. */
  Node jjtGetChild(int i);

  /** Return the number of children the node has. */
  int jjtGetNumChildren();

  String getImage();

  Object getValue(EvaluationContext ctx);
  void setValue(EvaluationContext ctx, Object value);
  ClassMirror getType(EvaluationContext ctx);
  bool isReadOnly(EvaluationContext ctx);
  void accept(NodeVisitor visitor, int index, int level);
  MethodInfo getMethodInfo(EvaluationContext ctx);
  Object invoke(EvaluationContext ctx,
          List<Object> paramValues, [Map<String, Object> namedArgs]);

  /**
   * @since EL 2.2
   */
  ValueReference getValueReference(EvaluationContext ctx);

  /**
   * @since EL 2.2
   */
  bool isParametersProvided();
}
