//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:50:51 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstString extends SimpleNode {
    AstString(int id)
        : super(id);

    String _str;

    String getString() {
        if (this._str == null) {
            this._str = this.image_.substring(1, this.image_.length - 1);
        }
        return this._str;
    }

    //@Override
    ClassMirror getType(EvaluationContext ctx) {
        return ClassUtil.STRING_MIRROR;
    }

    //@Override
    Object getValue(EvaluationContext ctx) {
        return this.getString();
    }

    //@Override
    void setImage(String image) {
        if (image.indexOf('\\') == -1) {
            this.image_ = image;
            return;
        }
        int size = image.length;
        StringBuffer buf = new StringBuffer();
        for (int i = 0; i < size; i++) {
            String c = image.substring(i, i+1);
            if (c == '\\' && i + 1 < size) {
                String c1 = image.substring(i+1, i+2);
                if (c1 == '\\' || c1 == '"' || c1 == '\'') {
                    c = c1;
                    i++;
                }
            }
            buf.add(c);
        }
        this.image_ = buf.toString();
    }
}
