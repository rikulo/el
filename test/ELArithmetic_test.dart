//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 26, 2012  09:58:41 AM
// Author: hernichen
#import("dart:mirrors");

#import("package:unittest/unittest.dart");
#import("package:rikulo_el/api.dart");
#import("package:rikulo_el/impl.dart");

final String a = "1.1";
final int b = 1000000000000000000000;

//TODO(henri): BigDecimal is not supported yet
////@Test
//void testAdd()  {
//    expect("${ELArithmetic.add(a, b)}", equals("1000000000000000000001.1"));
//}
//
////@Test
//void testSubtract()  {
//    expect("${ELArithmetic.subtract(a, b)}", equals("-999999999999999999998.9"));
//}
//
////@Test
//void testMultiply()  {
//    expect("${ELArithmetic.multiply(a, b)}", equals("1100000000000000000000.0"));
//}
//
////@Test
//void testDivide()  {
//    expect("${ELArithmetic.divide(a, b)}", equals("0.0"));
//}

//@Test
void testMod()  {
    expect("${ELArithmetic.mod(a, b)}", equals("1.1"));
}

//TODO(henri): BigDecimal not supported yet
//@Test
//void testBug47371bigDecimal()  {
//    expect(ELArithmetic.add("", BigDecimal.valueOf(1)), equals(BigDecimal.valueOf(1)));
//}

//@Test
void testBug47371double()  {
    expect(ELArithmetic.add("", 7.toDouble()), equals(7.toDouble()));
}

//@Test
void testBug47371doubleString()  {
    expect(ELArithmetic.add("", "2.0"), equals(2.toDouble()));
}

//@Test
void testBug47371bigInteger()  {
    expect(ELArithmetic.multiply("", 1), equals(0));
}

//@Test
void testBug47371long()  {
    expect(ELArithmetic.add("", 1), equals(1));
}

//@Test
void testBug47371long2()  {
    expect(ELArithmetic.subtract("1", "4"), equals(-3));
}

//@Test
void testBug47371doubleString2()  {
    expect(ELArithmetic.add("1.0", "1"), equals(2.toDouble()));
}

void main() {
  //test('testAdd', testAdd); //TODO(henri): BigDecimal is not supported yet
  //test('testSubtract', testSubtract); //TODO(henri): BigDecimal is not supported yet
  //test('testMultiply', testMultiply); //TODO(henri): BigDecimal is not supported yet
  //test('testDivide', testDivide); //TODO(henri): BigDecimal is not supported yet
  test('testMod', testMod);
  //test('testBug47371bigDecimal', testBug47371bigDecimal); //TODO(henri): BigDecimal is not supported yet
  test('testBug47371double', testBug47371double);
  test('testBug47371doubleString', testBug47371doubleString);
  test('testBug47371bigInteger', testBug47371bigInteger);
  test('testBug47371long', testBug47371long);
  test('testBug47371long2', testBug47371long2);
  test('testBug47371doubleString2', testBug47371doubleString2);
}
