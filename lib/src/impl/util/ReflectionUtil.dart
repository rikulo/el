//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  04:06:33 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/**
 * Utilities for Managing Serialization and Reflection
 *
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Id: ReflectionUtil.java 1304933 2012-03-24 21:33:47Z markt $
 */
class ReflectionUtil {
//  static Map<String, ClassMirror> _PRIMITIVE_NAMES = _initPrimitiveNames();

//  static Map<String, ClassMirror> _initPrimitiveNames() {
//    Map<String, ClassMirror> map = new Map();
//    map["bool"] = BOOL_MIRROR;
//    map["num"] = NUM_MIRROR;
//    map["int"] = INT_MIRROR;
//    map["double"] = DOUBLE_MIRROR;
//    map["DateTime"] = DATE_TIME_MIRROR;
//    map["String"] = STRING_MIRROR;
//    map["Object"] = OBJECT_MIRROR;
//    map["Map"] = MAP_MIRROR;
//    map["List"] = LIST_MIRROR;
//    map["Queue"] = QUEUE_MIRROR;
//    map["Set"] = SET_MIRROR;
//    //map["Enum"] = ENUM_MIRROR;;
//    return map;
//  }

//  static ClassMirror forName(String name) {
//    if (null == name || "" == name)
//        return null;
//
//    ClassMirror c = _PRIMITIVE_NAMES[name];
//    if (c == null)
//      c = ClassUtil.forName(name);
//    return c;
//  }

  /**
   * Converts an array of qulified class names to class types.
   */
//  static List<ClassMirror> toTypeArray(List<String> s) {
//    if (s == null)
//        return null;
//
//    List<ClassMirror> c = new List();
//    for (int i = 0; i < s.length; i++)
//        c[i] = forName(s[i]);
//    return c;
//  }

  /**
   * Converts an array of class types to class qualified names
   */
//  static List<String> toTypeNameArray(List<ClassMirror> c) {
//    if (c == null)
//        return null;
//
//    List<String> s = new List();
//    for (int i = 0; i < c.length; i++)
//        s[i] = c[i].qualifiedName;
//    return s;
//  }

  static MethodMirror _getMethod0(ClassMirror owner, String methodName) {
    ClassMirror clz = owner;
    final methodSymbol = new Symbol(methodName);
    MethodMirror m = clz.methods[methodSymbol];
    if (m == null)
      m = clz.getters[methodSymbol];

    while(!ClassUtil.isTopClass(clz) && (m == null || m.isPrivate)) {
      clz = owner.superclass;
      m = clz.methods[methodSymbol];
      if (m == null)
        m = clz.getters[methodSymbol];
    }
    return m == null || m.isPrivate ? null : m;
  }

  /**
   * Returns a method per the object and method name.
   * + [base] - the object
   * + [property] - the method name
   */
  static MethodMirror getMethod(Object base, Object property) {
    if (base == null || property == null)
      throw new MethodNotFoundException(
          MessageFactory.getString("error.method.notfound", [base, property, ""]));

    String methodName = (property is String) ? property : property.toString();

    MethodMirror m =_getMethod0(reflect(base).type, methodName);
    if (m == null)
      throw new MethodNotFoundException(
          MessageFactory.getString("error.method.notfound", [base, property, ""]));

    return m;
  }

  /**
   * Returns whether a source class is assignable to target class.
   *
   * + [tgt] - target class
   * + [src] - source class
   */
//  static bool _isAssignableFrom(ClassMirror src, ClassMirror target)
//    => ClassUtil.isAssignableFrom(target, src);

//  static bool _isCoercibleFrom(Object src, ClassMirror target) {
//    // TODO: This isn't pretty but it works. Significant refactoring would
//    //       be required to avoid the exception.
//    try {
//      ELSupport.coerceToType(src, target);
//    } on ELException catch (e) {
//      return false;
//    }
//
//    return true;
//  }

  /** Returns the parameter types as a comma delimited String. */
//  static String paramString_(List<ClassMirror> types) {
//    if (types != null) {
//      StringBuffer sb = new StringBuffer();
//      for (int i = 0; i < types.length; i++)
//          sb.write(types[i].simpleName).add(", ");
//      return sb.length > 2 ? sb.toString().substring(0, sb.length - 2) : "";
//    }
//    return null;
//  }
}
