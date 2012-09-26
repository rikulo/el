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
//History: Wed, Sep 26, 2012  11:13:24 AM
// Author: hernichen
#import("file:///D:/Program/dart/dart-sdk/pkg/unittest/unittest.dart");
#import("../../el/el.dart");
#import("../../el/impl/impl.dart");
#import("dart:mirrors");

//@Test
void testEquals() {
    expect(ELSupport.areEqual("01", 1), isTrue);
}

//TODO(henri): BigDecimal is not supported yet
////@Test
//void testBigDecimal() {
//    _testIsSame(new BigDecimal(
//            "0.123456789012345678901234567890123456789012345678901234567890123456789"));
//}

//@Test
void testBigInteger() {
    _testIsSame(1234567890123456789012345678901234567890123456789012345678901234567890);
}

//@Test
void testLong() {
    _testIsSame(0x0102030405060708);
}

//@Test
void testInteger() {
    _testIsSame(0x01020304);
}

//@Test
void testShort() {
    _testIsSame(0x0102);
}

//@Test
void testByte() {
    _testIsSame(0xEF);
}

//@Test
void testDouble() {
    _testIsSame(0.123456789012345678901234);
}

//@Test
void testFloat() {
    _testIsSame(0.123456);
}

//@Test
void testCoerceIntegerToNumber() {
    int input = 4390241;
    Object output = ELSupport.coerceToType(input, ClassUtil.NUM_MIRROR);
    expect(output, equals(input));
}

//@Test
void testCoerceNullToNumber() {
    Object output = ELSupport.coerceToType(null, ClassUtil.NUM_MIRROR);
    expect(output, equals(0));
}

//TODO(henri): Enum is not supported yet
////@Test
//void testCoerceEnumAToEnumA() {
//    Object output = null;
//    try {
//        output = ELSupport.coerceToEnum(TestEnumA.VALA1, TestEnumA.class);
//    } finally {
//        assertEquals(TestEnumA.VALA1, output);
//    }
//}
//
////@Test
//void testCoerceEnumAToEnumB() {
//    Object output = null;
//    try {
//        output = ELSupport.coerceToEnum(TestEnumA.VALA1, TestEnumB.class);
//    } catch (ELException ele) {
//        // Ignore
//    }
//    assertNull(output);
//}
//
////@Test
//void testCoerceEnumAToEnumC() {
//    Object output = null;
//    try {
//        output = ELSupport.coerceToEnum(TestEnumA.VALA1, TestEnumC.class);
//    } catch (ELException ele) {
//        // Ignore
//    }
//    assertNull(output);
//}

void _testIsSame(Object value) {
    expect(ELSupport.coerceToNumber(value, reflect(value).type), equals(value));
}

//Enum is not supported yet
//static enum TestEnumA {
//    VALA1,
//    VALA2
//}
//static enum TestEnumB {
//    VALB1,
//    VALB2
//}
//static enum TestEnumC {
//    VALA1,
//    VALA2,
//    VALB1,
//    VALB2
//}
//

void main() {
  test('testEquals', testEquals);
  //test('testBigDecimal', testBigDecimal); //TODO(henri): BigDecimal is not supported yet
  test('testBigInteger', testBigInteger);
  test('testLong', testLong);
  test('testInteger', testInteger);
  test('testShort', testShort);
  test('testByte', testByte);
  test('testDouble', testDouble);
  test('testFloat', testFloat);
  test('testCoerceIntegerToNumber', testCoerceIntegerToNumber);
  test('testCoerceNullToNumber', testCoerceNullToNumber);
  //test('testCoerceEnumAToEnumA', testCoerceEnumAToEnumA); //TODO(henri): Enum is not supported yet
  //test('testCoerceEnumAToEnumB', testCoerceEnumAToEnumB); //TODO(henri): Enum is not supported yet
  //test('testCoerceEnumAToEnumC', testCoerceEnumAToEnumC); //TODO(henri): Enum is not supported yet
}
