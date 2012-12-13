//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  10:00:01 AM
// Author: hernichen

part of rikulo_elimpl;

//#issue1: support Dart's array expression
class AstArray extends SimpleNode {

  AstArray(int id)
      : super(id);

  //@Override
  ClassMirror getType(EvaluationContext ctx)
    => ClassUtil.LIST_MIRROR;

  //@Override
  Object getValue(EvaluationContext ctx) {
    List values = null;
    int numItems = this.jjtGetNumChildren();
    if (numItems > 0) {
      values = new List(numItems);
      for (int i = 0; i < numItems; i++)
        values[i] = this.children_[i].getValue(ctx);
    } else
      values = new List(0);
    return values;
  }
}
