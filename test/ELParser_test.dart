/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 26, 2012  09:44:11 AM
// Author: hernichen
#import("dart:mirrors");

#import("package:unittest/unittest.dart");
#import("package:rikulo_el/el.dart");
#import("package:rikulo_el/el/impl.dart");

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
    ExpressionFactory elfactory = ExpressionFactory.newInstance();
    ELContext context = new ELContextImpl();

    TesterBeanA beanA = new TesterBeanA();
    beanA.setInt("five");
    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type);
    context.getVariableMapper().setVariable("beanA", var0);

    // Should fail
    Exception e = null;
    try {
        elfactory.createValueExpression(context, "\${beanA.int}",
                ClassUtil.STRING_MIRROR);
    } on ELException catch (ele) {
        e = ele;
    }
    expect(e, isNotNull);
}

//@Test
void testJavaKeyWordIdentifier() {
    ExpressionFactory elfactory = ExpressionFactory.newInstance();
    ELContext context = new ELContextImpl();

    TesterBeanA beanA = new TesterBeanA();
    beanA.setInt("five");
    ValueExpression var0 =
        elfactory.createValueExpressionByInstance(beanA, reflect(beanA).type);
    context.getVariableMapper().setVariable("this", var0);

    // Should fail
    Exception e = null;
    try {
        elfactory.createValueExpression(context, "\${this}", ClassUtil.STRING_MIRROR);
    } on ELException catch (ele) {
        e = ele;
    }
    expect(e, isNotNull);
}


void _testExpression(String expression, String expected) {
    ExpressionFactory elfactory = ExpressionFactory.newInstance();
    ELContext context = new ELContextImpl();

    ValueExpression ve = elfactory.createValueExpression(
            context, expression, ClassUtil.STRING_MIRROR);

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
