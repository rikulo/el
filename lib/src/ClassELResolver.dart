//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Oct 03, 2012  06:55:03 PM
// Author: hernichen

part of rikulo_el;

/**
 * Resolve ClassMirror static variable and static method.
 */
//issue6: resolve class level static variable and method
class ClassELResolver implements ELResolver {
  final bool _readOnly;

  ClassELResolver([bool readOnly = false])
      : this._readOnly = readOnly;

  //@Override
  getValue(ELContext context, base, property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! ClassMirror)
      return null;

    ClassMirror cm = base;
    MethodMirror getter = cm.declarations[new Symbol(property)];
    if (getter == null || !getter.isStatic)
      return null;

    context.isPropertyResolved = true;
    return ClassUtil.invokeByMirror(cm, getter, []);
  }

  //@Override
  TypeMirror getType(ELContext context, base, property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! ClassMirror)
      return null;

    ClassMirror cm = base;
    MethodMirror getter = cm.declarations[new Symbol(property)];
    if (getter == null || !getter.isStatic)
      return null;

    context.isPropertyResolved = true;
    return getter.returnType;
  }

  //@Override
  void setValue(ELContext context, base, property, value) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! ClassMirror)
      return;

    ClassMirror cm = base;
    MethodMirror setter = cm.declarations[new Symbol("$property=")];
    if (setter == null  || !setter.isStatic)
      return;

    context.isPropertyResolved = true;

    if (this._readOnly)
      throw new PropertyNotWritableException(ELResolver.message(context,
               "resolverNotWriteable", [property]));

    ClassUtil.invokeByMirror(cm, setter, [value]);
  }

  //@Override
  bool isReadOnly(ELContext context, base, property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! ClassMirror)
      return false;

    context.isPropertyResolved = true;

    return this._readOnly || !_hasSetter(base, property);
  }

  bool _hasSetter(base, property) {
    ClassMirror cm = base;
    MethodMirror setter = cm.declarations[new Symbol("$property=")];
    return setter != null && setter.isStatic;
  }

  //@Override
  ClassMirror getCommonPropertyType(ELContext context, base) {
    if (context == null)
      throw new ArgumentError("context: null");

    return base != null ? OBJECT_MIRROR : null;
  }

  //@Override
  invoke(ELContext context, base, method,
                List params, [Map<String, dynamic> namedArgs]) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || method == null || base is! ClassMirror)
      return null;

    String methodName = method.toString();
    ClassMirror cm = base;
    MethodMirror m = cm.declarations[new Symbol(methodName)];
    if (m == null || !m.isStatic)
      return null;

    context.isPropertyResolved = true;

    return ClassUtil.invokeByMirror(cm, m , params, namedArgs);
  }
}
