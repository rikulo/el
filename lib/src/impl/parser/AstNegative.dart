//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:40:59 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstNegative extends SimpleNode {
    AstNegative(int id)
        : super(id);

    //@Override
    ClassMirror getType(EvaluationContext ctx) => NUM_MIRROR;

    //@Override
    Object getValue(EvaluationContext ctx) {
        Object obj = this.children_[0].getValue(ctx);

        if (obj == null) {
            return 0;
        }
//TODO(henri) : BigDecimal not supported yet
//        if (obj is BigDecimal) {
//            return obj.negate();
//        }
        if (obj is String) {
            if (ELSupport.isStringFloat(obj)) {
                return -double.parse(obj);
            }
            return -int.parse(obj);
        }
        if (obj is double) {
            return -obj.toDouble();
        }
        if (obj is int) {
            return -obj.toInt();
        }
        int num0 = ELSupport.coerceToNumber(obj, INT_MIRROR);
        return -num0.toInt();
    }
}
