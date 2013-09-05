//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 18, 2012  09:57:18 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class AstDotSuffix extends SimpleNode {
    AstDotSuffix(int id)
        : super(id);

    //@Override
    getValue(EvaluationContext ctx) {
        return this.image_;
    }

    //@Override
    void setImage(String image) {
        if (!Validation.isIdentifier(image)) {
            throw new ELException(MessageFactory.getString("error.identifier.notdart",
                    [image]));
        }
        this.image_ = image;
    }
}
