//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 03, 2012  02:51:12 PM
// Author: hernichen
#import("dart:mirrors");

#import("package:unittest/unittest.dart");
#import("package:rikulo_el/api.dart");
#import("package:rikulo_el/impl.dart");

#source("TesterBeans.dart");

//@Test
void testGetValueReference() {
    ExpressionFactory elfactory = new ExpressionFactory();

    ELContext context = new ELContext();

    TesterBeanB beanB = new TesterBeanB();
    beanB.name = "Tomcat";
    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanB, reflect(beanB).type);
    context.getVariableMapper().setVariable("beanB", var0);

    ValueExpression ve = elfactory.createValueExpression(
            context, "\${beanB.name}", ClassUtil.STRING_MIRROR);

    // First check the basics work
    String result = ve.getValue(context);
    expect(result, equals("Tomcat"));

    // Now check the value reference
    ValueReference vr = ve.getValueReference(context);
    expect(vr, isNotNull);

    expect(vr.getBase(), equals(beanB));
    expect(vr.getProperty(), equals("name"));
}

//@Test
void testGetValueReferenceVariable() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    TesterBeanB beanB = new TesterBeanB();
    beanB.name = "Tomcat";
    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanB, reflect(beanB).type);
    context.getVariableMapper().setVariable("beanB", var0);

    ValueExpression var2 = elfactory.createValueExpression(
            context, "\${beanB.name}", ClassUtil.STRING_MIRROR);

    context.getVariableMapper().setVariable("foo", var2);

    ValueExpression ve = elfactory.createValueExpression(
            context, "\${foo}", reflect(var2).type);


    // Now check the value reference
    ValueReference vr = ve.getValueReference(context);
    expect(vr, isNotNull);

    expect(vr.getBase(), equals(beanB));
    expect(vr.getProperty(), equals("name"));
}

//@Test
void testBug49345() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    TesterBeanA beanA = new TesterBeanA();
    TesterBeanB beanB = new TesterBeanB();
    beanB.name = "Tomcat";
    beanA.bean = beanB;

    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type);
    context.getVariableMapper().setVariable("beanA", var0);

    ValueExpression ve = elfactory.createValueExpression(
            context, "\${beanA.bean.name}", ClassUtil.STRING_MIRROR);

    // First check the basics work
    String result = ve.getValue(context);
    expect(result, equals("Tomcat"));

    // Now check the value reference
    ValueReference vr = ve.getValueReference(context);
    expect(vr, isNotNull);

    expect(vr.getBase(), equals(beanB));
    expect(vr.getProperty(), equals("name"));
}

//@Test
//Enum is not supported yet
//void testBug50105() {
//    ExpressionFactory elfactory = new ExpressionFactory();
//    ELContext context = new ELContext();
//
//    TesterEnum testEnum = TesterEnum.APPLE;
//
//    ValueExpression var0 =
//        elfactory.createValueExpression(testEnum, TesterEnum.class);
//    context.getVariableMapper().setVariable("testEnum", var0);
//
//    // When coercing an Enum to a String, name() should always be used.
//    ValueExpression ve1 = elfactory.createValueExpression(
//            context, "${testEnum}", String.class);
//    String result1 = (String) ve1.getValue(context);
//    assertEquals("APPLE", result1);
//
//    ValueExpression ve2 = elfactory.createValueExpression(
//            context, "foo${testEnum}bar", String.class);
//    String result2 = (String) ve2.getValue(context);
//    assertEquals("fooAPPLEbar", result2);
//}

//@Test
void testBug51177ObjectMap() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    Object o1 = "String value";
    Object o2 = 32;

    Map<Object,Object> map = new Map();
    map["key1"] = o1;
    map["key2"] = o2;

    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(map, ClassUtil.MAP_MIRROR);
    context.getVariableMapper().setVariable("map", var0);

    ValueExpression ve1 = elfactory.createValueExpression(
            context, "\${map.key1}", ClassUtil.OBJECT_MIRROR);
    ve1.setValue(context, o2);
    expect(ve1.getValue(context), equals(o2));

    ValueExpression ve2 = elfactory.createValueExpression(
            context, "\${map.key2}", ClassUtil.OBJECT_MIRROR);
    ve2.setValue(context, o1);
    expect(ve2.getValue(context), equals(o1));
}

//@Test
void testBug51177ObjectList() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    Object o1 = "String value";
    Object o2 = 32;

//    List<Object> list = new List(2);
//    list[0] = o1;
//    list[1] = o2;

    List<Object> list = new List();
    list.add(o1);
    list.add(o2);

    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(list, ClassUtil.LIST_MIRROR);
    context.getVariableMapper().setVariable("list", var0);

    ValueExpression ve1 = elfactory.createValueExpression(
            context, "\${list[0]}", ClassUtil.OBJECT_MIRROR);
    ve1.setValue(context, o2);
    expect(ve1.getValue(context), equals(o2));

    ValueExpression ve2 = elfactory.createValueExpression(
            context, "\${list[1]}", ClassUtil.OBJECT_MIRROR);
    ve2.setValue(context, o1);
    expect(ve2.getValue(context), equals(o1));
}


/**
 * Test returning an empty list as a bean property.
 */
//@Test
void testBug51544Bean() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    TesterBeanA beanA = new TesterBeanA();
    beanA.valList = new List();

    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type);
    context.getVariableMapper().setVariable("beanA", var0);

    ValueExpression ve = elfactory.createValueExpression(
            context, "\${beanA.valList.length}", ClassUtil.INT_MIRROR);

    int result = ve.getValue(context);
    expect(result, equals(0));
}


/**
 * Test using list directly as variable.
 */
//@Test
void testBug51544Direct() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    List list = new List();

    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(list, ClassUtil.LIST_MIRROR);
    context.getVariableMapper().setVariable("list", var0);

    ValueExpression ve = elfactory.createValueExpression(
            context, "\${list.length}", ClassUtil.INT_MIRROR);

    int result = ve.getValue(context);
    expect(result, 0);
}

//issue2
//@Test
void testMapExpression() {
  ExpressionFactory elfactory = new ExpressionFactory();
  ELContext context = new ELContext();

  Object o1 = "String value";
  Object o2 = 32;

  ValueExpression o1ve =
      elfactory.createValueExpressionByInstance(o1, ClassUtil.STRING_MIRROR);
  context.getVariableMapper().setVariable("o1", o1ve);

  ValueExpression o2ve =
      elfactory.createValueExpressionByInstance(o2, ClassUtil.INT_MIRROR);
  context.getVariableMapper().setVariable("o2", o2ve);

  ValueExpression ve1 = elfactory.createValueExpression(
      context, "#{{'key1':o1,'key2':o2}.key1}", ClassUtil.OBJECT_MIRROR);
  expect(ve1.getValue(context), equals(o1));

  ValueExpression ve2 = elfactory.createValueExpression(
      context, "#{{'key1':o1,'key2':o2}.key2}", ClassUtil.OBJECT_MIRROR);
  expect(ve2.getValue(context), equals(o2));

  ve1.setValue(context, o2);
  expect(ve1.getValue(context), equals(o2));

  ve2.setValue(context, o1);
  expect(ve2.getValue(context), equals(o1));

}

//issue1
//@Test
void testListExpression() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    Object o1 = "String value";
    Object o2 = 32;

    ValueExpression o1ve  =
        elfactory.createValueExpressionByInstance(o1, ClassUtil.STRING_MIRROR);
    context.getVariableMapper().setVariable("o1", o1ve);

    ValueExpression o2ve  =
        elfactory.createValueExpressionByInstance(o2, ClassUtil.INT_MIRROR);
    context.getVariableMapper().setVariable("o2", o2ve);

    ValueExpression ve1 = elfactory.createValueExpression(
            context, "#{[o1, o2][0]}", ClassUtil.OBJECT_MIRROR);
    expect(ve1.getValue(context), equals(o1));

    ValueExpression ve2 = elfactory.createValueExpression(
        context, "\${[o1, o2][1]}", ClassUtil.OBJECT_MIRROR);
    expect(ve2.getValue(context), equals(o2));

    ve1.setValue(context, o2);
    expect(ve1.getValue(context), equals(o2));

    ve2.setValue(context, o1);
    expect(ve2.getValue(context), equals(o1));
}

//--------------------
void main() {
  test('testGetValueReference', testGetValueReference);
  test('testGetValueReferenceVariable', testGetValueReferenceVariable);
  test('testBug49345', testBug49345);
  //test('testBug50105', testBug50105); //enum test
  test('testBug51177ObjectMap', testBug51177ObjectMap);
  test('testBug51177ObjectList', testBug51177ObjectList);
  test('testBug51544Bean', testBug51544Bean);
  test('testBug51544Direct', testBug51544Direct);
  test('testListExpression', testListExpression);
  test('testMapExpression', testMapExpression);
}

