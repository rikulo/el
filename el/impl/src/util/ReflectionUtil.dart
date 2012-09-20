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
//History: Fri, Sep 14, 2012  04:06:33 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * Utilities for Managing Serialization and Reflection
 *
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Id: ReflectionUtil.java 1304933 2012-03-24 21:33:47Z markt $
 */
class ReflectionUtil {
  static Map<String, ClassMirror> _PRIMITIVE_NAMES;
  static ClassMirror forName(String name) {
    if (_PRIMITIVE_NAMES == null) {
      _PRIMITIVE_NAMES = new Map();
      _PRIMITIVE_NAMES["bool"] = ClassUtil.BOOL_MIRROR;
      _PRIMITIVE_NAMES["num"] = ClassUtil.NUM_MIRROR;
      _PRIMITIVE_NAMES["int"] = ClassUtil.INT_MIRROR;
      _PRIMITIVE_NAMES["double"] = ClassUtil.DOUBLE_MIRROR;
      _PRIMITIVE_NAMES["Date"] = ClassUtil.DATE_MIRROR;
      _PRIMITIVE_NAMES["String"] = ClassUtil.STRING_MIRROR;
      _PRIMITIVE_NAMES["Object"] = ClassUtil.OBJECT_MIRROR;
      _PRIMITIVE_NAMES["Map"] = ClassUtil.MAP_MIRROR;
      _PRIMITIVE_NAMES["List"] = ClassUtil.LIST_MIRROR;
      _PRIMITIVE_NAMES["Queue"] = ClassUtil.QUEUE_MIRROR;
      _PRIMITIVE_NAMES["Set"] = ClassUtil.SET_MIRROR;
      _PRIMITIVE_NAMES["Collection"] = ClassUtil.COLLECTION_MIRROR;

//      _PRIMITIVE_NAMES["Enum"] = ClassUtil.ENUM_MIRROR;
    }
      if (null == name || "" == name) {
          return null;
      }
      ClassMirror c = _PRIMITIVE_NAMES[name];
      if (c == null) {
        c = ClassUtil.forName(name);
      }
      return c;
  }

  /**
   * Converts an array of Class names to Class types
   * @param s
   * @throws ClassNotFoundException
   */
  static List<ClassMirror> toTypeArray(List<String> s) {
      if (s == null)
          return null;
      List<ClassMirror> c = new List();
      for (int i = 0; i < s.length; i++) {
          c[i] = forName(s[i]);
      }
      return c;
  }

  /**
   * Converts an array of Class types to Class names
   * @param c
   */
  static List<String> toTypeNameArray(List<ClassMirror> c) {
      if (c == null)
          return null;
      List<String> s = new List();
      for (int i = 0; i < c.length; i++) {
          s[i] = c[i].qualifiedName;
      }
      return s;
  }

  static MethodMirror _getMethod0(ClassMirror owner, String methodName) {
    ClassMirror clz = owner;
    MethodMirror m = clz.setters[methodName];
    while(clz != null && (m == null || m.isPrivate)) {
        clz = owner.superclass;
        m = clz.methods[methodName];
    }
    return m;
  }

  /**
   * Returns a method based on the criteria
   * @param base the object that owns the method
   * @param property the name of the method
   * @param paramValues the parameter values
   * @return the method specified
   * @throws MethodNotFoundException
   */
  static MethodMirror getMethod(Object base, Object property) {
    if (base == null || property == null) {
        throw new MethodNotFoundException(
            MessageFactory.getString("error.method.notfound", [base, property, ""]));
    }

    String methodName = (property is String) ? property
            : property.toString();

    return _getMethod0(reflect(base).type, methodName);
  }

  // src will always be an object
  static bool _isAssignableFrom(ClassMirror src, ClassMirror target) =>
    ClassUtil.isAssignableFrom(target, src);

  static bool _isCoercibleFrom(Object src, ClassMirror target) {
    // TODO: This isn't pretty but it works. Significant refactoring would
    //       be required to avoid the exception.
    try {
        ELSupport.coerceToType(src, target);
    } on ELException catch (e) {
        return false;
    }
    return true;
  }

  static String paramString_(List<ClassMirror> types) {
    if (types != null) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < types.length; i++) {
            sb.add(types[i].simpleName).add(", ");
        }
        return sb.length > 2 ? sb.toString().substring(0, sb.length - 2) : "";
    }
    return null;
  }
}
