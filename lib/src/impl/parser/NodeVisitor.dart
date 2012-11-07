//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  04:00:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

abstract class NodeVisitor {
    void visit(Node node, int index, int level);
    //henrichen@rikulo.org
    void after(Node node, int index, int level);
}
