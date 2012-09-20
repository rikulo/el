//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 03, 2012  02:51:12 PM
// Author: hernichen

/** Utility class used with Mirror */
class ClassUtil {
  static final ClassMirror BOOL_MIRROR = ClassUtil.forName("dart:core.bool");
  static final ClassMirror NUM_MIRROR = ClassUtil.forName("dart:core.num");
  static final ClassMirror INT_MIRROR = ClassUtil.forName("dart:core.int");
  static final ClassMirror DOUBLE_MIRROR = ClassUtil.forName("dart:core.double");
  static final ClassMirror DATE_MIRROR = ClassUtil.forName("dart:core.Date");
  static final ClassMirror STRING_MIRROR = ClassUtil.forName("dart:core.String");
  static final ClassMirror OBJECT_MIRROR = ClassUtil.forName("dart:core.Object");

  static final ClassMirror ENUM_MIRROR = ClassUtil.forName("rikulo:orm.Enum");

  static final ClassMirror MAP_MIRROR = ClassUtil.forName("dart:core.Map");
  static final ClassMirror LIST_MIRROR = ClassUtil.forName("dart:core.List");
  static final ClassMirror QUEUE_MIRROR = ClassUtil.forName("dart:core.Queue");
  static final ClassMirror SET_MIRROR = ClassUtil.forName("dart:core.Set");
  static final ClassMirror COLLECTION_MIRROR = ClassUtil.forName("dart:core.Collection");

  /** Return the ClassMirror of the qualified class name */
  static ClassMirror forName(String qname) {
    Map splited = _splitQualifiedName(qname);
    if (splited != null) {
      String libName = splited["libName"];
      String clsName = splited["clsName"];
      LibraryMirror l = currentMirrorSystem().libraries[libName];
      if (l != null) {
        ClassMirror m = l.classes[clsName];
        if (m != null) return m;
      }
    }
    throw new NoSuchClassException(qname);
  }

  /** Returns whether a source ClassMirror is assignable to target ClassMirror */
  static bool isAssignableFrom(ClassMirror tgt, ClassMirror src) {
    if (src == null)
      return null;

    if (tgt.qualifiedName == src.qualifiedName)
      return true;

    for (ClassMirror inf in src.superinterfaces)
      if (isAssignableFrom(tgt, inf)) return true; //recursive

    return isAssignableFrom(tgt, src.superclass); //recursive
  }

  /** Returns the corresponding ClassMirror of a given TypeMirror. */
  static ClassMirror getCorrespondingClassMirror(TypeMirror type)
    => type is ClassMirror ? type : forName(type.qualifiedName);

  static bool isSimple(ClassMirror cls) {
    String qname = cls.qualifiedName;
    return qname == "dart:core.int" ||
           qname == "dart:core.double" ||
           qname == "dart:core.String" ||
           qname == "dart:core.Date" ||
           qname == "dart:core.bool";
  }

  static ClassMirror getElementClassMirror(ClassMirror collection) {
    int idx = isAssignableFrom(MAP_MIRROR, collection) ? 1 : 0;
    return _getElementClassMirror0(collection, idx);
  }

  static ClassMirror getKeyClassMirror(ClassMirror map)
    => _getElementClassMirror0(map, 0);

  static ClassMirror _getElementClassMirror0(ClassMirror collection, int idx) {
    List<TypeVariableMirror> vars = collection.typeVariables.getValues();
    return getCorrespondingClassMirror(vars[idx].upperBound);
  }

  static bool isInstance(ClassMirror cls, Object val)
    => isAssignableFrom(cls, reflect(val).type);

  static Map _splitQualifiedName(String qname) {
    int j = qname.lastIndexOf(".");
    return j < 1 || j >= (qname.length - 1) ? null :
      {"libName" : qname.substring(0, j), "clsName" : qname.substring(j+1)};
  }

  static List<ClassMirror> getParameterTypes(MethodMirror m) {
    List<ParameterMirror> params = m.parameters;
    List<ClassMirror> types = new List();
    for (ParameterMirror param in params) {
      if (param.isNamed) { //TODO(henri) : we have not supported named parameter
        continue;
      }
      types.add(getCorrespondingClassMirror(param.type));
    }
    return types;
  }

  static Object invoke(Object inst, MethodMirror m, List<Object> params, [Map<String, Object> namedArgs]) {
    Future<InstanceMirror> result = reflect(inst).invoke(m.simpleName, params, namedArgs);
    while(!result.isComplete) //wait until complete
      ;
    return result.value.reflectee;
  }

  static Object apply(Function fn, List<Object> params, [Map<String, Object> namedArgs]) {
    ClosureMirror closure = reflect(fn);
    params = _convertParams(params);
    namedArgs = _convertNamedArgs(namedArgs);
    Future<InstanceMirror> result = closure.apply(params, namedArgs);
    while(!result.isComplete) //wait until complete
      ;
    return result.value.reflectee;
  }

  static List _convertParams(List params) {
    if (params != null) {
      List ps = new List();
      params.forEach((v) => ps.add(_convertParam(v)));
      return ps;
    }
    return null;
  }

  static Map<String, Object> _convertNamedArgs(Map namedArgs) {
    if (namedArgs != null) {
      Map<String, Object> nargs = new Map();
      namedArgs.forEach((k,v) => nargs[k] = _convertParam(v));
      return nargs;
    }
    return null;
  }

  static Object _convertParam(var v) {
    if (v == null || v is num || v is bool || v is String)
      return v;
    return reflect(v);
  }
}
