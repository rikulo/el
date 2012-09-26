//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 25, 2012  11:50:01 AM
// Author: hernichen
//-----------------------------------
class TesterBeanA {
    TesterBeanB bean;
    String name;
    int valLong;
    List valList;

    String getName() => name;
    void setName(String name) {
      this.name = name;
    }
    TesterBeanB getBean() => bean;
    void setBean(TesterBeanB bean) {
      this.bean = bean;
    }
    int getValLong() => valLong;
    void setValLong(int valLong) {
      this.valLong = valLong;
    }
    List getValList() => valList;
    void setValList(List valList) {
      this.valList = valList;
    }
}

class TesterBeanAA extends TesterBeanA {}

class TesterBeanAAA extends TesterBeanAA {}

class TesterBeanB {
    String name;

    String getName() => name;
    void setName(String name) {
      this.name = name;
    }
    String sayHello([String to]) {
        return to == null ? "Hello from $name" : "Hello $to from $name";
    }
}

class TesterBeanBB extends TesterBeanB {

    String extra;
}

class TesterBeanBBB extends TesterBeanBB {}

class TesterBeanC {
    String sayHelloA2B(TesterBeanA a, TesterBeanB b) {
        return "AB: Hello ${a.name} from ${b.name}";
    }
    String sayHelloAA2B(TesterBeanAA a, TesterBeanB b) {
        return "AAB: Hello ${a.name} from ${b.name}";
    }
    String sayHelloA2BB(TesterBeanA a, TesterBeanBB b) {
        return "ABB: Hello ${a.name} from ${b.name}";
    }
    String sayHelloA2BBs(TesterBeanA a, List<TesterBeanBB> b) {
        StringBuffer result =
            new StringBuffer("ABB[]: Hello ${a.name} from ");
        for (int i = 0; i < b.length; i++) {
            if (i > 0) {
                result.add(", ");
            }
            result.add(b[i].name);
        }
        return result.toString();
    }
}
