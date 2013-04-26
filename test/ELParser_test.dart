//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 26, 2012  09:44:11 AM
// Author: hernichen

import 'dart:mirrors';
import 'package:unittest/unittest.dart';
import 'package:rikulo_commons/mirrors.dart';
import 'package:rikulo_el/el.dart';

//@Test
void testBug49081() {
    // OP's report
    _testExpression("#\${1+1}", "#2");

    // Variations on a theme
    _testExpression("#", "#");
    _testExpression("##", "##");
    _testExpression("###", "###");
    _testExpression("\$", "\$");
    _testExpression("\$\$", "\$\$");
    _testExpression("\$\$\$", "\$\$\$");
    _testExpression("#\$", "#\$");
    _testExpression("#\$#", "#\$#");
    _testExpression("\$#", "\$#");
    _testExpression("\$#\$", "\$#\$");

    _testExpression("#{1+1}", "2");
    _testExpression("##{1+1}", "#2");
    _testExpression("###{1+1}", "##2");
    _testExpression("\${1+1}", "2");
    _testExpression("\$\${1+1}", "\$2");
    _testExpression("\$\$\${1+1}", "\$\$2");
    _testExpression("#\${1+1}", "#2");
    _testExpression("#\$#{1+1}", "#\$2");
    _testExpression("\$#{1+1}", "\$2");
    _testExpression("\$#\${1+1}", "\$#2");
}

//@Test
void testJavaKeyWordSuffix() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    TesterBeanA beanA = new TesterBeanA();
    beanA.setInt("five");
    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type);
    context.getVariableMapper().setVariable("beanA", var0);

    // Should fail
    Exception e = null;
    try {
        elfactory.createValueExpression(context, "\${beanA.int}",
                STRING_MIRROR);
    } on ELException catch (ele) {
        e = ele;
    }
    expect(e, isNotNull);
}

//@Test
void testJavaKeyWordIdentifier() {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    TesterBeanA beanA = new TesterBeanA();
    beanA.setInt("five");
    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type);
    context.getVariableMapper().setVariable("this", var0);

    // Should fail
    Exception e = null;
    try {
        elfactory.createValueExpression(context, "\${this}", STRING_MIRROR);
    } on ELException catch (ele) {
        e = ele;
    }
    expect(e, isNotNull);
}


void _testExpression(String expression, String expected) {
    ExpressionFactory elfactory = new ExpressionFactory();
    ELContext context = new ELContext();

    ValueExpression ve = elfactory.createValueExpression(
            context, expression, STRING_MIRROR);

    String result = ve.getValue(context);
    expect(result, equals(expected));
}

//---------------------
class TesterBeanA {
    String _keywordInt;

    String getInt() {
        return _keywordInt;
    }

    void setInt(String keywordInt) {
        this._keywordInt = keywordInt;
    }
}

void main() {
  test('testBug49081', testBug49081);
  test('testJavaKeyWordSuffix', testJavaKeyWordSuffix);
  test('testJavaKeyWordIdentifier', testJavaKeyWordIdentifier);
}
