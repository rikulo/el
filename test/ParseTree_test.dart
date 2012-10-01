//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 26, 2012  09:44:11 AM
// Author: hernichen

#import("dart:mirrors");

#import("package:unittest/unittest.dart");
#import("package:rikulo_el/api.dart");
#import("package:rikulo_el/impl.dart");

class ShowVisitor implements NodeVisitor {
  StringBuffer sb = new StringBuffer();
  void visit(Node node, int index, int level) {
    StringBuffer space = new StringBuffer();
    while(level-- > 0) {
      space.add("  ");
    }

    sb.add(space).add(node).add("\n");
    //sb.add("(").add(node).add(")");
  }
  void after(Node node, int index, int level) {
    //do nothing
  }
  String result() => sb.toString();
  void clear() {sb = new StringBuffer();}
}

String show(String script) {
  Node node = ELParser.parse(script);
  ShowVisitor visitor = new ShowVisitor();
  node.accept(visitor, 0, 0);
  print("\"$script\" --->");
  print(visitor.result());
}

void main() {
  show("a + b - c * d / e");
  show("xyz #{a + b - c * d / e} #{i0} j k");
  show("ijk  \${a + b - c * d / e} x + y - z 123");
  show("#{empty x0 ? a + b : c * d / e}");
  show("你好, 謝謝! #{empty x0 ? a + b : c * d / e mod f}");
  show("#{x0 and y0 or z0 <= 1 ? a + b : c * d / e mod f}");
  show("#{x0 ? a.b(p1, p2, p3) : x(v1, 2, v3)}");

  //ARRAY
  show("#{[]}");
  show("#{[a]}");
  show("#{f([a,b,c])}");
  show("#{[a,[b,c]]}");
  show("#{[[a,b],c]}");
  show("#{[[a,b,c]]}");
  show("#{a.b.c([x,y])}");

  //MAP
  show("#{{}}");
  show("#{{k1:v1}}");
  show("#{f({k1:v1,k2:v2,k3:v3})}");
  show("#{{k1:v1,x:{k2:v2,k3:v3}}}");
  show("#{{x:{k1:v1,k2:v2},k3:v3}}");
  show("#{a.b.c(x, y, {k1:v1,k2:v2})}");
  show("#{{'key1':o1,'key2':o2}.key1}");

  show('Hello, #{aaa().person.name}!');
}