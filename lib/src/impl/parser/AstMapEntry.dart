//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Thu, Sep 27, 2012  09:49:27 AM
// Author: hernichen

part of rikulo_elimpl;

//#issue1: support Dart's map exprssion
class AstMapEntry extends SimpleNode {
    AstMapEntry(int id)
        : super(id);

    Object getKey(EvaluationContext ctx)
      => _getValue(ctx, 0);

    getValue(EvaluationContext ctx)
      => _getValue(ctx, 1);

    ClassMirror getKeyType(EvaluationContext ctx)
      => _getType(ctx, 0);

    ClassMirror getValueType(EvaluationContext ctx)
      => _getType(ctx, 1);

    Object _getValue(EvaluationContext ctx, int idx)
      => this.jjtGetChild(idx).getValue(ctx);

    ClassMirror _getType(EvaluationContext ctx, int idx)
      => this.jjtGetChild(idx).getType(ctx);
}
