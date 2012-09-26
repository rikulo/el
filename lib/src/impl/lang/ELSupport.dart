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
//History: Sat, Sep 15, 2012  04:05:37 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * A helper class that implements the EL Specification
 *
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Id: ELSupport.java 1244574 2012-02-15 16:30:37Z markt $
 */
class ELSupport {
    /**
     * Compare two objects, after coercing to the same type if appropriate.
     *
     * If the objects are identical, or they are equal according to
     * {@link #equals(Object, Object)} then return 0.
     *
     * If either object is a BigDecimal, then coerce both to BigDecimal first.
     * Similarly for Double(Float), BigInteger, and Long(Integer, Char, Short, Byte).
     *
     * Otherwise, check that the first object is an instance of Comparable, and compare
     * against the second object. If that is null, return 1, otherwise
     * return the result of comparing against the second object.
     *
     * Similarly, if the second object is Comparable, if the first is null, return -1,
     * else return the result of comparing against the first object.
     *
     * A null object is considered as:
     * <ul>
     * <li>ZERO when compared with Numbers</li>
     * <li>the empty string for String compares</li>
     * <li>Otherwise null is considered to be lower than anything else.</li>
     * </ul>
     *
     * @param obj0 first object
     * @param obj1 second object
     * @return -1, 0, or 1 if this object is less than, equal to, or greater than val.
     * @throws ELException if neither object is Comparable
     * @throws ClassCastException if the objects are not mutually comparable
     */
    static int compare(Object obj0, Object obj1) {
        if (obj0 == obj1 || areEqual(obj0, obj1)) {
            return 0;
        }
//TODO(henri): we don't support BigDecimal yet.
//        if (isBigDecimalOp(obj0, obj1)) {
//            BigDecimal bd0 = coerceToNumber(obj0, ClassUtil.BIGDECIMAL_MIRROR);
//            BigDecimal bd1 = coerceToNumber(obj1, ClassUtil.BIGDECIMAL_MIRROR);
//            return bd0.compareTo(bd1);
//        }
        if (isDoubleOp(obj0, obj1)) {
            double d0 = coerceToNumber(obj0, ClassUtil.DOUBLE_MIRROR);
            double d1 = coerceToNumber(obj1, ClassUtil.DOUBLE_MIRROR);
            return d0.compareTo(d1);
        }
        if (isIntOp(obj0, obj1)) {
            int l0 = coerceToNumber(obj0, ClassUtil.INT_MIRROR);
            int l1 = coerceToNumber(obj1, ClassUtil.INT_MIRROR);
            return l0.compareTo(l1);
        }
        if (obj0 is String || obj1 is String) {
            return coerceToString(obj0).compareTo(coerceToString(obj1));
        }
        if (obj0 is Comparable) {
            return (obj1 != null) ? obj0.compareTo(obj1) : 1;
        }
        if (obj1 is Comparable) {
            return (obj0 != null) ? -obj1.compareTo(obj0) : -1;
        }
        throw new ELException(MessageFactory.getString("error.compare", [obj0, obj1]));
    }

    /**
     * Compare two objects for equality, after coercing to the same type if appropriate.
     *
     * If the objects are identical (including both null) return true.
     * If either object is null, return false.
     * If either object is Boolean, coerce both to Boolean and check equality.
     * Similarly for Enum, String, BigDecimal, Double(Float), Long(Integer, Short, Byte, Character)
     * Otherwise default to using Object.equals().
     *
     * @param obj0 the first object
     * @param obj1 the second object
     * @return true if the objects are equal
     * @throws ELException
     */
    static bool areEqual(Object obj0, Object obj1) {
        if (obj0 == obj1) {
            return true;
        } else if (obj0 == null || obj1 == null) {
            return false;
//TODO(henri): we don't support BigDecimal yet.
//        } else if (isBigDecimalOp(obj0, obj1)) {
//            BigDecimal bd0 = coerceToNumber(obj0, ClassUtil.BIGDECIMAL_MIRROR);
//            BigDecimal bd1 = coerceToNumber(obj1, ClassUtil.BIGDECIMAL_MIRROR);
//            return bd0 == bd1;
        } else if (isDoubleOp(obj0, obj1)) {
            double d0 = coerceToNumber(obj0, ClassUtil.DOUBLE_MIRROR);
            double d1 = coerceToNumber(obj1, ClassUtil.DOUBLE_MIRROR);
            return d0 == d1;
        } else if (isIntOp(obj0, obj1)) {
            int l0 = coerceToNumber(obj0, ClassUtil.INT_MIRROR);
            int l1 = coerceToNumber(obj1, ClassUtil.INT_MIRROR);
            return l0 == l1;
        } else if (obj0 is bool || obj1 is bool) {
            return coerceToBoolean(obj0) == coerceToBoolean(obj1);
//TODO(henri): we don't support Enum yet.
//        } else if (obj0 is Enum) {
//            return obj0 == coerceToEnum(obj1, reflect(obj0).type);
//        } else if (obj1 is Enum) {
//            return obj1 == coerceToEnum(obj0, reflect(obj1).type);
        } else if (obj0 is String || obj1 is String) {
            int lexCompare = coerceToString(obj0).compareTo(coerceToString(obj1));
            return (lexCompare == 0) ? true : false;
        } else {
            return obj0 == obj1;
        }
    }

    // Going to have to have some casts /raw types somewhere so doing it here
    // keeps them all in one place. There might be a neater / better solution
    // but I couldn't find it
//TODO(henri): we don't support Enum yet.
//    static Enum coerceToEnum(Object obj, ClassMirror type) {
//        if (obj == null || "" == obj) {
//            return null;
//        }
//        if (ClassUtil.isAssignableFrom(type, reflect(obj).type)) {
//            return obj;
//        }
//
//        if (!(obj is String)) {
//            throw new ELException(MessageFactory.getString("error.convert",
//                    [obj, reflect(obj).type.qualifiedName, type]));
//        }
//
//        Enum result;
//        try {
//             result = Enum.valueOf(type, obj);
//        } on IllegalArgumentException catch (iae) {
//            throw new ELException(MessageFactory.getString("error.convert",
//                    [obj, reflect(obj).type.qualifiedName, type]));
//        }
//        return result;
//    }

    /**
     * Convert an object to Boolean.
     * Null and empty string are false.
     * @param obj the object to convert
     * @return the Boolean value of the object
     * @throws ELException if object is not Boolean or String
     */
    static bool coerceToBoolean(Object obj) {
        if (obj == null || "" == obj) {
            return false;
        }
        if (obj is bool) {
            return obj;
        }
        if (obj is String) {
            return "true" == obj;
        }

        throw new ELException(MessageFactory.getString("error.convert",
                [obj, reflect(obj).type.qualifiedName, "bool"]));
    }

    // static Character coerceToCharacter(Object obj) {
    //     if (obj == null || "".equals(obj)) {
    //         return Character.valueOf((char) 0);
    //     }
    //     if (obj is String) {
    //         return Character.valueOf(((String) obj).charAt(0));
    //     }
    //     if (ELArithmetic.isNumber(obj)) {
    //         return Character.valueOf((char) ((num) obj).shortValue());
    //     }
    //     ClassMirror objType = obj.getClass();
    //     if (obj is Character) {
    //         return (Character) obj;
    //     }

    //     throw new ELException(MessageFactory.get("error.convert",
    //             obj, objType, Character.class));
    // }

    static num coerceNumberToNumber_(num number,
            ClassMirror type) {
        if (ClassUtil.INT_MIRROR == type) {
            return number.toInt();
        }
        if (ClassUtil.DOUBLE_MIRROR == type) {
            return number.toDouble();
        }
//TODO(henri): we don't support BigDecimal yet.
//        if (ClassUtil.BIGDECIMAL_MIRROR == type) {
//            if (number is BigDecimal) {
//                return number;
//            }
//            if (number is int) {
//                return new BigDecimal.fromInt(number);
//            }
//            return new BigDecimal.fromDouble(number.toDouble());
//        }
        if (ClassUtil.NUM_MIRROR == type) {
            return number;
        }

        throw new ELException(MessageFactory.getString("error.convert",
                [number, reflect(number).type.qualifiedName, type]));
    }

    static num coerceToNumber(Object obj,
            ClassMirror type) {
        if (obj == null || "" == obj) {
            return coerceNumberToNumber_(0, type);
        }
        if (obj is String) {
            return coerceStringToNumber_(obj, type);
        }
        if (ELArithmetic.isNumber(obj)) {
            return coerceNumberToNumber_(obj, type);
        }

        throw new ELException(MessageFactory.getString("error.convert",
                [obj, reflect(obj).type.qualifiedName, type]));
    }

    static num coerceStringToNumber_(String val,
            ClassMirror type) {
        if (ClassUtil.INT_MIRROR == type) {
            return int.parse(val);
        }
        if (ClassUtil.DOUBLE_MIRROR == type) {
            return double.parse(val);
        }
//TODO(henri): we don't support BigDecimal yet.
//        if (ClassUtil.BIGDECIMAL_MIRROR == type) {
//            try {
//                return new BigDecimal.fromString(val);
//            } on NumberFormatException catch (nfe) {
//                throw new ELException(MessageFactory.getString("error.convert",
//                        [val, "String", type]));
//            }
//        }

        throw new ELException(MessageFactory.getString("error.convert",
                [val, "String", type]));
    }

    /**
     * Coerce an object to a string
     * @param obj
     * @return the String value of the object
     */
    static String coerceToString(Object obj) {
        if (obj == null) {
            return "";
        } else if (obj is String) {
            return obj;
//TODO(henri): we don't support Enum yet.
//        } else if (obj is Enum) {
//            return obj.name;
        } else {
            return obj.toString();
        }
    }

    static Object coerceToType(Object obj,
            ClassMirror type) {
        if (type == null || type == ClassUtil.OBJECT_MIRROR ||
                (obj != null && ClassUtil.isAssignableFrom(type, reflect(obj).type))) {
            return obj;
        }
        if (ClassUtil.STRING_MIRROR == type) {
            return coerceToString(obj);
        }
        if (ELArithmetic.isNumberType(type)) {
            return coerceToNumber(obj, type);
        }
        if (ClassUtil.BOOL_MIRROR == type) {
            return coerceToBoolean(obj);
        }
//TODO(henri): we don't support Enum yet.
//        if (ClassUtil.isAssignableFrom(ClassUtil.ENUM_MIRROR, type)) {
//            return coerceToEnum(obj, type);
//        }

        // new to spec
        if (obj == null)
            return null;
        if (obj is String) {
            if ("" == obj)
                return null;
        }
        throw new ELException(MessageFactory.getString("error.convert",
                [obj, reflect(obj).type.qualifiedName, type]));
    }

//TODO(henri): we don't support BigDecimal yet.
//    static bool isBigDecimalOp(Object obj0,
//            Object obj1) {
//        return (obj0 is BigDecimal || obj1 is BigDecimal);
//    }

    static bool isDoubleOp(Object obj0, Object obj1) {
        return obj0 is double
                || obj1 is double;
    }

    static bool isIntOp(Object obj0, Object obj1) {
        return obj0 is int
                || obj1 is int;
    }

    static bool isStringFloat(String str) {
        int len = str.length;
        if (len > 1) {
            for (int i = 0; i < len; i++) {
                switch (str.substring(i, i+1)) {
                case "E":
                case "e":
                case ".":
                    return true;
                }
            }
        }
        return false;
    }

    static List<Object> convertArgs(List<Object> src, MethodMirror m, Node node) {
      List<ParameterMirror> params = m.parameters;
      int paramCount = params.length;
      if (paramCount == 0) {
        return new List(0);
      }

      ParameterInfo pinfo = new ParameterInfo(params);
      int sCount = src == null ? 0 : src.length;
      int pCount = pinfo.positionals.length;
      int oCount = pinfo.optionals.length;
      if (pCount > sCount || sCount > (pCount + oCount)) { //incorrect argument count
        throw new ELException(MessageFactory.getString("error.method.arguments",
                                                       [pCount, oCount, sCount, node.getImage()]));
      }

      List<ClassMirror> ptypes = ClassUtil.getParameterTypes(pinfo.positionals);
      List<ClassMirror> otypes = ClassUtil.getParameterTypes(pinfo.optionals);

      List<Object> dest = new List(pCount + oCount);

      //positional arguments
      int desti = 0;
      for (int i = 0; i < pCount; i++, desti++) {
        dest[desti] = coerceToType(src[desti], ptypes[i]);
      }

      //optional arguments
      int oi = 0;
      for (; oi < oCount && desti < sCount; oi++, desti++) {
        dest[desti] = coerceToType(src[desti], otypes[oi]);
      }

//TODO(henri): dartbug.org, defaultValue is not supported yet in mirror
      //default value for arguments
//      for (; oi < oCount; oi++, desti++) {
//        ParameterMirror pm = pinfo.optionals[oi];
//        dest[desti] = coerceToType(pm.defaultValue, otypes[oi]);
//      }

      return dest;
    }
}
