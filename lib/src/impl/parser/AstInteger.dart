//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:29:05 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstInteger extends SimpleNode {
    AstInteger(int id)
        : super(id);

    num _number;

    num getInteger_() {
        if (this._number == null) {
            this._number = int.parse(this.image_);
        }
        return _number;
    }

    //@Override
    ClassMirror getType(EvaluationContext ctx) => INT_MIRROR;

    //@Override
    Object getValue(EvaluationContext ctx) {
        return this.getInteger_();
    }
}
