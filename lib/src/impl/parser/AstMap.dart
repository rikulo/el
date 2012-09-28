//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, Sep 27, 2012  09:27:10 AM
// Author: hernichen

//#issue1: support Dart's map expression
class AstMap extends SimpleNode {

  AstMap(int id)
      : super(id);

  //@Override
  ClassMirror getType(EvaluationContext ctx)
    => ClassUtil.MAP_MIRROR;

  //@Override
  Object getValue(EvaluationContext ctx) {
    Map values = ctx.getAttribute(this);
    if (values == null) {
      values = new Map();
      int numItems = this.jjtGetNumChildren();
      if (numItems > 0) {
        for (int i = 0; i < numItems; i++) {
          AstMapEntry e = this.children_[i];
          values[e.getKey(ctx)] = e.getValue(ctx);
        }
      }
      ctx.setAttribute(this, values);
    }
    return values;
  }
}
