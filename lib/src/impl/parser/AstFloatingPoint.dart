//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:33:01 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstFloatingPoint extends SimpleNode {
    AstFloatingPoint(int id)
        : super(id);

    num _number;

    num getFloatingPoint() {
        if (this._number == null) {
//TODO(henri): We do not support BigDecimal yet.
          this._number = double.parse(this.image_);
//            try {
//                this._number = parseDouble(this.image_);
//            } on ArithmeticException catch (e0) {
//                this._number = new BigDecimal(this.image_);
//            }
        }
        return this._number;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        return this.getFloatingPoint();
    }

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return reflect(this.getFloatingPoint()).type;
    }
}
