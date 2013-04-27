//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 25, 2012  11:15:34 AM
// Author: hernichen
library ELEval_test;

import 'package:unittest/unittest.dart';
import 'package:rikulo_commons/mirrors.dart';
import 'package:rikulo_el/el.dart';
import 'package:rikulo_el/elimpl.dart' show ELSupport;

void testBug42565() {
  expect(evaluateExpression("\${false?true:false}"), equals("false"));
  expect(evaluateExpression("\${false?true: false}"), equals("false"));
  expect(evaluateExpression("\${false?true :false}"), equals("false"));
  expect(evaluateExpression("\${false?true : false}"), equals("false"));
  expect(evaluateExpression("\${false? true:false}"), equals("false"));
  expect(evaluateExpression("\${false? true: false}"), equals("false"));
  expect(evaluateExpression("\${false? true :false}"), equals("false"));
  expect(evaluateExpression("\${false? true : false}"), equals("false"));
  expect(evaluateExpression("\${false ?true:false}"), equals("false"));
  expect(evaluateExpression("\${false ?true: false}"), equals("false"));
  expect(evaluateExpression("\${false ?true :false}"), equals("false"));
  expect(evaluateExpression("\${false ?true : false}"), equals("false"));
  expect(evaluateExpression("\${false ? true:false}"), equals("false"));
  expect(evaluateExpression("\${false ? true: false}"), equals("false"));
  expect(evaluateExpression("\${false ? true :false}"), equals("false"));
  expect(evaluateExpression("\${false ? true : false}"), equals("false"));
}

void testBug44994() {
  expect(evaluateExpression(
      "\${0 lt 0 ? 1 lt 0 ? 'many': 'one': 'none'}"), equals("none"));
  expect(evaluateExpression(
      "\${0 lt 1 ? 1 lt 1 ? 'many': 'one': 'none'}"), equals("one"));
  expect(evaluateExpression(
      "\${0 lt 2 ? 1 lt 2 ? 'many': 'one': 'none'}"), equals("many"));
}


void testParserBug45511() {
  // Test cases provided by OP
  expect(evaluateExpression("\${empty ('')}"), equals("true"));
  expect(evaluateExpression("\${empty('')}"), equals("true"));
  expect(evaluateExpression("\${(true) and (false)}"), equals("false"));
  expect(evaluateExpression("\${(true)and(false)}"), equals("false"));
}

void testBug48112() {
  expect(evaluateExpression("\${trim('{world}')}"), equals("{world}"));
  expect(evaluateExpression("\${fn:trim('{world}')}"), equals("{fn:trim}"));
}

void testFunctionMapper2() {
  expect(evaluateExpression("\${aaa().name}"), equals("Rikulo"));
}
void testParserLiteralExpression() {
  // Inspired by work on bug 45451, comments from kkolinko on the dev
  // list and looking at the spec to find some edge cases

  // '\' is only an escape character inside a StringLiteral
  expect(evaluateExpression("\\\\"), equals("\\\\"));

  /*
   * LiteralExpresions can only contain ${ or #{ if escaped with \
   * \ is not an escape character in any other circumstances including \\
   */
  expect(evaluateExpression("\\"), equals("\\"));
  expect(evaluateExpression("\$"), equals("\$"));
  expect(evaluateExpression("#"), equals("#"));
  expect(evaluateExpression("\\\$"), equals("\\\$"));
  expect(evaluateExpression("\\#"), equals("\\#"));
  expect(evaluateExpression("\\\\\$"), equals("\\\\\$"));
  expect(evaluateExpression("\\\\#"), equals("\\\\#"));
  expect(evaluateExpression("\\\${"), equals("\${"));
  expect(evaluateExpression("\\#{"), equals("#{"));
  expect(evaluateExpression("\\\\\${"), equals("\\\${"));
  expect(evaluateExpression("\\\\#{"), equals("\\#{"));
}

void testParserStringLiteral() {
  // Inspired by work on bug 45451, comments from kkolinko on the dev
  // list and looking at the spec to find some edge cases

  // The only characters that can be escaped inside a String literal
  // are \ " and '. # and $ are not escaped inside a String literal.
  expect(evaluateExpression("\${'\\\\'}"), equals("\\"));
  expect(evaluateExpression("\${\"\\\\\"}"), equals("\\"));
  expect(evaluateExpression("\${'\\\\\\\"\\'\$#'}"), equals("\\\"'\$#"));
  expect(evaluateExpression("\${\"\\\\\\\"\\'\$#\"}"), equals("\\\"'\$#"));

  // Trying to quote # or $ should throw an error
  Exception e = null;
  try {
    evaluateExpression("\${'\\\$'}");
  } on ELException catch (el) {
    e = el;
  }
  expect(e, isNotNull);

  expect(evaluateExpression("\${'\\\\\$'}"), equals("\\\$"));
  expect(evaluateExpression("\${'\\\\\\\\\$'}"), equals("\\\\\$"));


  // Can use ''' inside '"' when quoting with '"' and vice versa without
  // escaping
  expect(evaluateExpression("\${'\\\\\"'}"), equals("\\\""));
  expect(evaluateExpression("\${'\"\\\\'}"), equals("\"\\"));
  expect(evaluateExpression("\${'\\\\\\''}"), equals("\\'"));
  expect(evaluateExpression("\${'\\'\\\\'}"), equals("'\\"));
  expect(evaluateExpression("\${\"\\\\'\"}"), equals("\\'"));
  expect(evaluateExpression("\${\"'\\\\\"}"), equals("'\\"));
  expect(evaluateExpression("\${\"\\\\\\\"\"}"), equals("\\\""));
  expect(evaluateExpression("\${\"\\\"\\\\\"}"), equals("\"\\"));
}

void compareBoth(String msg, int expected, Object o1, Object o2){
  int i1 = ELSupport.compare(o1, o2);
  int i2 = ELSupport.compare(o2, o1);
  expect(i1, equals(expected), reason:msg);
  expect(-i2, equals(expected), reason:msg);
}

void testElSupportCompare(){
  compareBoth("Nulls should compare equal", 0, null, null);
  compareBoth("Null should compare equal to \"\"", 0, "", null);
//  compareBoth("Null should be less than File()",-1, null, new File(""));
  compareBoth("Null should be less than DateTime.now()",-1, null, new DateTime.now());
  compareBoth("DateTime.fromMillisecondsSinceEpoch(0) should be less than DateTime.fromMillisecondsSinceEpoch(1)",
    -1, new DateTime.fromMillisecondsSinceEpoch(0), new DateTime.fromMillisecondsSinceEpoch(1));
  try {
    compareBoth("Should not compare",0, new DateTime.now(), new Map());
    expect(false, isTrue, reason:"Expecting CastException");
  } on ELException catch (expected) {
    // Expected
  }
  expect(null, isNull);
}

/**
 * Test mixing ${...} and #{...} in the same expression.
 */
void testMixedTypes() {
  // Mixing types should throw an error
  Exception e = null;
  try {
    evaluateExpression("\${1+1}#{1+1}");
  } on ELException catch (el) {
    e = el;
  }
  expect(e, isNotNull);
}

//----------------
String evaluateExpression(String expression) {
  ELContext ctx = new ELContext.from(functionMapper: new FMapper());
  ExpressionFactory exprFactory = new ExpressionFactory();
  ValueExpression ve = exprFactory.createValueExpression(ctx, expression,
      STRING_MIRROR);
  return ve.getValue(ctx);
}

class Person {
  String name;
  Person(this.name);
}

Person person = new Person('Rikulo');

aaa() => person;

class FMapper extends FunctionMapper {

  //@Override
  Function resolveFunction(String name) {
    switch (name) {
      case "trim":
        return (String input) => input.trim();
      case "fn:trim":
        return (String input) => "{fn:trim}";
      case "aaa":
        return aaa;
    }

    return null;
  }
}

//class Inner$Class {
//
//  static final String RETVAL = "Return from bug49555";
//  static String bug49555() {
//    return RETVAL;
//  }
//}


void main() {
  test('Bug42565', testBug42565);
  test('Bug44994', testBug44994);
  test('ParserBug45511', testParserBug45511);
  test('Bug48112', testBug48112);
  test('testFunctionMapper2', testFunctionMapper2);
  test('parserLiteralExpression', testParserLiteralExpression);
  test('parserStringLiteral', testParserStringLiteral);
  test('ElSupportCompare', testElSupportCompare);
  test('mixedTypes', testMixedTypes);
}