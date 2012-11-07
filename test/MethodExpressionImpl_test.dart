//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 25, 2012  11:53:01 AM
// Author: hernichen

import 'dart:mirrors';
import 'package:unittest/unittest.dart';
import 'package:rikulo_commons/mirrors.dart';
import 'package:rikulo_el/el.dart';
import 'package:rikulo_el/elimpl.dart';

part 'TesterBeans.dart';

final String _BUG53792 = "TEST_PASS";

ExpressionFactory _elfactory;
ELContext _context;
TesterBeanB _beanB;

//@Before
void setUp() {
    _elfactory = new ExpressionFactory();
    _context = new ELContext();

    TesterBeanA beanA = new TesterBeanA();
    beanA.setName("A");
    _context.getVariableMapper().setVariable("beanA",
            _elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type));

    TesterBeanAA beanAA = new TesterBeanAA();
    beanAA.setName("AA");
    _context.getVariableMapper().setVariable("beanAA",
            _elfactory.createValueExpressionByInstance(beanAA, reflect(beanAA).type));

    TesterBeanAAA beanAAA = new TesterBeanAAA();
    beanAAA.setName("AAA");
    _context.getVariableMapper().setVariable("beanAAA",
            _elfactory.createValueExpressionByInstance(beanAAA, reflect(beanAAA).type));

    _beanB = new TesterBeanB();
    _beanB.setName("B");
    _context.getVariableMapper().setVariable("_beanB",
            _elfactory.createValueExpressionByInstance(_beanB, reflect(_beanB).type));

    TesterBeanBB beanBB = new TesterBeanBB();
    beanBB.setName("BB");
    _context.getVariableMapper().setVariable("beanBB",
            _elfactory.createValueExpressionByInstance(beanBB, reflect(beanBB).type));

    TesterBeanBBB beanBBB = new TesterBeanBBB();
    beanBBB.setName("BBB");
    _context.getVariableMapper().setVariable("beanBBB",
            _elfactory.createValueExpressionByInstance(beanBBB, reflect(beanBBB).type));

    TesterBeanC beanC = new TesterBeanC();
    _context.getVariableMapper().setVariable("beanC",
            _elfactory.createValueExpressionByInstance(beanC, reflect(beanC).type));

//    TesterBeanEnum beanEnum = new TesterBeanEnum();
//    _context.getVariableMapper().setVariable("beanEnum",
//            _elfactory.createValueExpressionByInstance(beanEnum, reflect(beanEnum).type));
}

//@Test
void testIsParametersProvided() {
  setUp();

    TesterBeanB _beanB = new TesterBeanB();
    _beanB.setName("Tomcat");
    ValueExpression var0 =
        _elfactory.createValueExpressionByInstance(_beanB, reflect(_beanB).type);
    _context.getVariableMapper().setVariable("_beanB", var0);

    MethodExpression me1 = _elfactory.createMethodExpression(
            _context, "\${_beanB.getName}", ClassUtil.STRING_MIRROR);
    MethodExpression me2 = _elfactory.createMethodExpression(
            _context, "\${_beanB.sayHello('JUnit')}", ClassUtil.STRING_MIRROR);

    expect(me1.isParametersProvided(), isFalse);
    expect(me2.isParametersProvided(), isTrue);
}

//@Test
void testInvoke() {
  setUp();

    TesterBeanB _beanB = new TesterBeanB();
    _beanB.setName("B");
    _context.getVariableMapper().setVariable("_beanB",
            _elfactory.createValueExpressionByInstance(_beanB, reflect(_beanB).type));

    MethodExpression me1 = _elfactory.createMethodExpression(
            _context, "\${_beanB.getName}", ClassUtil.STRING_MIRROR);

    MethodExpression me2 = _elfactory.createMethodExpression(
            _context, "\${_beanB.sayHello('JUnit')}", ClassUtil.STRING_MIRROR);

    MethodExpression me3 = _elfactory.createMethodExpression(
            _context, "\${_beanB.sayHello}", ClassUtil.STRING_MIRROR);

    expect(me1.invoke(_context, null), equals("B"));
    expect(me2.invoke(_context, null), equals("Hello JUnit from B"));
    expect(me2.invoke(_context, ["JUnit2"]), equals("Hello JUnit from B"));
    expect(me3.invoke(_context, ["JUnit2"]), equals("Hello JUnit2 from B"));
    expect(me2.invoke(_context, [null]), equals("Hello JUnit from B"));
    expect(me3.invoke(_context, [null]), equals("Hello  from B"));
}

//@Test
void testInvokeWithSuper() {
  setUp();

    MethodExpression me = _elfactory.createMethodExpression(_context,
            "\${beanA.setBean(beanBB)}", null );

    me.invoke(_context, null);
    ValueExpression ve = _elfactory.createValueExpression(_context,
            "\${beanA.bean.name}", ClassUtil.STRING_MIRROR);
    Object r = ve.getValue(_context);
    expect(r, equals("BB"));
}

//@Test
void testInvokeWithSuperABNoReturnTypeNoParamTypes() {
  setUp();

    MethodExpression me2 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2B(beanA,_beanB)}", null);
    Object r2 = me2.invoke(_context, null);
    expect(r2.toString(), equals("AB: Hello A from B"));
}

//@Test
void testInvokeWithSuperABReturnTypeNoParamTypes() {
  setUp();

    MethodExpression me3 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2B(beanA,_beanB)}", ClassUtil.STRING_MIRROR);
    Object r3 = me3.invoke(_context, null);
    expect(r3.toString(), equals("AB: Hello A from B"));
}

//@Test
void testInvokeWithSuperABNoReturnTypeParamTypes() {
  setUp();

    MethodExpression me4 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2B(beanA,_beanB)}", null);
    Object r4 = me4.invoke(_context, null);
    expect(r4.toString(), equals("AB: Hello A from B"));
}

//@Test
void testInvokeWithSuperABReturnTypeParamTypes() {
  setUp();

    MethodExpression me5 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2B(beanA,_beanB)}", ClassUtil.STRING_MIRROR);
    Object r5 = me5.invoke(_context, null);
    expect(r5.toString(), equals("AB: Hello A from B"));
}

//@Test
void testInvokeWithSuperABB() {
  setUp();

    MethodExpression me6 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BB(beanA,beanBB)}", null);
    Object r6 = me6.invoke(_context, null);
    expect(r6.toString(), equals("ABB: Hello A from BB"));
}

//@Test
void testInvokeWithSuperABBB() {
  setUp();

    MethodExpression me7 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BB(beanA,beanBBB)}", null);
    Object r7 = me7.invoke(_context, null);
    expect(r7.toString(), equals("ABB: Hello A from BBB"));
}

//@Test
void testInvokeWithSuperAAB() {
  setUp();

    MethodExpression me8 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloAA2B(beanAA,_beanB)}", null);
    Object r8 = me8.invoke(_context, null);
    expect(r8.toString(), equals("AAB: Hello AA from B"));
}

//@Test
void testInvokeWithSuperAABB() {
  setUp();

    MethodExpression me9 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloAA2BB(beanAA,beanBB)}", null);
    Exception e = null;
    try {
        me9.invoke(_context, null);
    } on Exception catch (e1) {
        e = e1;
    }
    // Expected to fail
    expect(e, isNotNull);
}

//@Test
void testInvokeWithSuperAABBB() {
  setUp();

    // The Java compiler reports this as ambiguous. Using the parameter that
    // matches exactly seems reasonable to limit the scope of the method
    // search so the EL will find a match.
    MethodExpression me10 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloAA2B(beanAA,beanBBB)}", null);
    Object r10 = me10.invoke(_context, null);
    expect(r10.toString(), equals("AAB: Hello AA from BBB"));
}

//@Test
void testInvokeWithSuperAAAB() {
  setUp();

    MethodExpression me11 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloAA2B(beanAAA,_beanB)}", null);
    Object r11 = me11.invoke(_context, null);
    expect(r11.toString(), equals("AAB: Hello AAA from B"));
}

//@Test
void testInvokeWithSuperAAABB() {
  setUp();

    // The Java compiler reports this as ambiguous. Using the parameter that
    // matches exactly seems reasonable to limit the scope of the method
    // search so the EL will find a match.
    MethodExpression me12 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BB(beanAAA,beanBB)}", null);
    Object r12 = me12.invoke(_context, null);
    expect(r12.toString(), equals("ABB: Hello AAA from BB"));
}

//@Test
void testInvokeWithSuperAAABBB() {
  setUp();

    MethodExpression me13 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloAA2BB(beanAAA,beanBBB)}", null);
    Exception e = null;
    try {
        me13.invoke(_context, null);
    } on Exception catch (e1) {
        e = e1;
    }
    // Expected to fail
    expect(e, isNotNull);
}

//@Test
void testInvokeWithVarArgsAB() {
  setUp();

    MethodExpression me1 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanA,[_beanB,_beanB])}", null);
    Object r = me1.invoke(_context, null);
    expect(r.toString(), equals("ABB[]: Hello A from B, B"));
}

//@Test
void testInvokeWithVarArgsABB() {
  setUp();

    MethodExpression me2 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanA,[beanBB,beanBB])}", null);
    Object r2 = me2.invoke(_context, null);
    expect(r2.toString(), equals("ABB[]: Hello A from BB, BB"));
}

//@Test
void testInvokeWithVarArgsABBB() {
  setUp();

    MethodExpression me3 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanA,[beanBBB,beanBBB])}", null);
    Object r3 = me3.invoke(_context, null);
    expect(r3.toString(), equals("ABB[]: Hello A from BBB, BBB"));
}

//@Test
void testInvokeWithVarArgsAAB() {
  setUp();

    MethodExpression me4 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanAA,[_beanB,_beanB])}", null);
    Object r = me4.invoke(_context, null);
    expect(r.toString(), equals('ABB[]: Hello AA from B, B'));
}

//@Test
void testInvokeWithVarArgsAABB() {
  setUp();

    MethodExpression me5 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanAA,[beanBB,beanBB])}", null);
    Object r5 = me5.invoke(_context, null);
    expect(r5.toString(), equals("ABB[]: Hello AA from BB, BB"));
}

//@Test
void testInvokeWithVarArgsAABBB() {
  setUp();

    MethodExpression me6 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanAA,[beanBBB,beanBBB])}", null);
    Object r6 = me6.invoke(_context, null);
    expect(r6.toString(), equals("ABB[]: Hello AA from BBB, BBB"));
}

//@Test
void testInvokeWithVarArgsAAAB() {
  setUp();

    MethodExpression me7 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanAAA,[_beanB,_beanB])}", null);
    Object r = me7.invoke(_context, null);
    expect(r.toString(), equals('ABB[]: Hello AAA from B, B'));
}

//@Test
void testInvokeWithVarArgsAAABB() {
  setUp();

    MethodExpression me8 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanAAA,[beanBB,beanBB])}", null);
    Object r8 = me8.invoke(_context, null);
    expect(r8.toString(), equals("ABB[]: Hello AAA from BB, BB"));
}

//@Test
void testInvokeWithVarArgsAAABBB() {
  setUp();

    MethodExpression me9 = _elfactory.createMethodExpression(_context,
            "\${beanC.sayHelloA2BBs(beanAAA,[beanBBB,beanBBB])}", null);
    Object r9 = me9.invoke(_context, null);
    expect(r9.toString(), equals("ABB[]: Hello AAA from BBB, BBB"));
}

/*
 * This is also tested implicitly in numerous places elsewhere in this
 * class.
 */
//@Test
void testBug49655() {
  setUp();

    // This is the call the failed
    MethodExpression me = _elfactory.createMethodExpression(_context,
            "#{beanA.setName('New value')}", null);
    // The rest is to check it worked correctly
    me.invoke(_context, null);
    ValueExpression ve = _elfactory.createValueExpression(_context,
            "#{beanA.name}", ClassUtil.STRING_MIRROR);
    expect(ve.getValue(_context), equals("New value"));
}

//@Test
void testBugPrimitives() {
  setUp();

    MethodExpression me = _elfactory.createMethodExpression(_context,
            "\${beanA.setValLong(5)}", null);
    me.invoke(_context, null);
    ValueExpression ve = _elfactory.createValueExpression(_context,
            "#{beanA.valLong}", ClassUtil.STRING_MIRROR);
    expect(ve.getValue(_context), equals("5"));
}

//@Test
void testBug50449a() {
  setUp();

    MethodExpression me1 = _elfactory.createMethodExpression(_context,
            "\${_beanB.sayHello()}", null);
    String actual = me1.invoke(_context, null);
    expect(actual, equals("Hello from B"));
}

//@Test
void testBug50449b() {
  setUp();

    MethodExpression me1 = _elfactory.createMethodExpression(_context,
            "\${_beanB.sayHello('Tomcat')}", null);
    String actual = me1.invoke(_context, null);
    expect(actual, equals("Hello Tomcat from B"));
}

//@Test
void testBug50790a() {
  setUp();

    ValueExpression ve = _elfactory.createValueExpression(_context,
            "#{beanAA.name.contains(beanA.name)}", ClassUtil.BOOL_MIRROR);
    bool actual = ve.getValue(_context);
    expect(actual, equals(true));
}

//@Test
void testBug50790b() {
  setUp();

    ValueExpression ve = _elfactory.createValueExpression(_context,
            "#{beanA.name.contains(beanAA.name)}", ClassUtil.BOOL_MIRROR);
    bool actual = ve.getValue(_context);
    expect(actual, equals(false));
}

//@Test
void testBug52445a() {
  setUp();

    MethodExpression me = _elfactory.createMethodExpression(_context,
            "\${beanA.setBean(beanBB)}", null);
    me.invoke(_context, null);

    MethodExpression me1 = _elfactory.createMethodExpression(_context,
            "\${beanA.bean.sayHello()}", null);
    String actual = me1.invoke(_context, null);
    expect(actual, equals("Hello from BB"));
}

//TODO(henri): Enum is not supported yet
//@Test
//void testBug52970() {
//  setUp();
//
//    MethodExpression me = _elfactory.createMethodExpression(_context,
//            "\${beanEnum.submit('APPLE')}", null);
//    me.invoke(_context, null);
//
//    ValueExpression ve = _elfactory.createValueExpression(_context,
//            "#{beanEnum.lastSubmitted}", reflect(beanEnum).type);
//    TesterEnum actual = ve.getValue(_context);
//    expect(actual, equals(TesterEnum.APPLE));
//
//}

//@Test
void testBug53792a() {
  setUp();

    MethodExpression me = _elfactory.createMethodExpression(_context,
            "\${beanA.setBean(_beanB)}", null);
    me.invoke(_context, null);
    me = _elfactory.createMethodExpression(_context,
            "\${_beanB.setName('$_BUG53792')}", null);
    me.invoke(_context, null);

    ValueExpression ve = _elfactory.createValueExpression(_context,
            "#{beanA.getBean().name}", ClassUtil.STRING_MIRROR);
    String actual = ve.getValue(_context);
    expect(actual, equals(_BUG53792));
}

//@Test
void testBug53792b() {
  setUp();

    MethodExpression me = _elfactory.createMethodExpression(_context,
            "\${beanA.setBean(_beanB)}", null);
    me.invoke(_context, null);
    me = _elfactory.createMethodExpression(_context,
            "\${_beanB.setName('$_BUG53792')}", null);
    me.invoke(_context, null);

    ValueExpression ve = _elfactory.createValueExpression(_context,
            "#{beanA.getBean().name.length}", ClassUtil.INT_MIRROR);
    int actual = ve.getValue(_context);
    expect(actual, equals(_BUG53792.length));
}


//@Test
void testBug53792c() {
  setUp();

    MethodExpression me = _elfactory.createMethodExpression(_context,
            "#{_beanB.sayHello().length}", null);
    int result = me.invoke(_context, null);
    expect(result, equals(_beanB.sayHello().length));
}

//--------------------
void main() {
//  test('testIsParametersProvided', testIsParametersProvided);
//  test('testInvoke', testInvoke);
//  test('testInvokeWithSuper', testInvokeWithSuper);
//  test('testInvokeWithSuperABNoReturnTypeNoParamTypes', testInvokeWithSuperABNoReturnTypeNoParamTypes);
//  test('testInvokeWithSuperABReturnTypeNoParamTypes', testInvokeWithSuperABReturnTypeNoParamTypes);
//  test('testInvokeWithSuperABNoReturnTypeParamTypes', testInvokeWithSuperABNoReturnTypeParamTypes);
//  test('testInvokeWithSuperABReturnTypeParamTypes', testInvokeWithSuperABReturnTypeParamTypes);
//  test('testInvokeWithSuperABB', testInvokeWithSuperABB);
//  test('testInvokeWithSuperABBB', testInvokeWithSuperABBB);
//  test('testInvokeWithSuperAAB', testInvokeWithSuperAAB);
//  test('testInvokeWithSuperAABB', testInvokeWithSuperAABB);
//  test('testInvokeWithSuperAABBB', testInvokeWithSuperAABBB);
//  test('testInvokeWithSuperAAAB', testInvokeWithSuperAAAB);
//  test('testInvokeWithSuperAAABB', testInvokeWithSuperAAABB);
//  test('testInvokeWithSuperAAABBB', testInvokeWithSuperAAABBB);
  test('testInvokeWithVarArgsAB', testInvokeWithVarArgsAB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsABB', testInvokeWithVarArgsABB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsABBB', testInvokeWithVarArgsABBB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsAAB', testInvokeWithVarArgsAAB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsAABB', testInvokeWithVarArgsAABB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsAABBB', testInvokeWithVarArgsAABBB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsAAAB', testInvokeWithVarArgsAAAB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsAAABB', testInvokeWithVarArgsAAABB); //TODO(henri): not support [a1,a2,a3] expression yet
  test('testInvokeWithVarArgsAAABBB', testInvokeWithVarArgsAAABBB); //TODO(henri): not support [a1,a2,a3] expression yet
//  test('testBug49655', testBug49655);
//  test('testBugPrimitives', testBugPrimitives);
//  test('testBug50449a', testBug50449a);
//  test('testBug50449b', testBug50449b);
//  test('testBug50790a', testBug50790a);
//  test('testBug50790b', testBug50790b);
//  test('testBug52445a', testBug52445a);
//  //test('testBug52970', testBug52970); //TODO(henri): not support Enum yet
//  test('testBug53792a', testBug53792a);
//  test('testBug53792b', testBug53792b);
//  test('testBug53792c', testBug53792c);
}

