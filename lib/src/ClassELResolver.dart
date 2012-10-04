//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Oct 03, 2012  06:55:03 PM
// Author: hernichen

/**
 * Resolve ClassMirror static variable and static method.
 */
//issue6: resolve class level static variable and method
class ClassELResolver implements ELResolver {
  final bool _readOnly;

  ClassELResolver([bool readOnly = false])
      : this._readOnly = readOnly;

  //@Override
  Object getValue(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! ClassMirror)
      return null;

    ClassMirror cm = base;
    MethodMirror getter = cm.getters[property];
    if (getter == null || !getter.isStatic)
      return null;

    context.setPropertyResolved(true);
    return ClassUtil.invokeObjectMirror(cm, getter, []);
  }

  //@Override
  ClassMirror getType(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! ClassMirror)
      return null;

    ClassMirror cm = base;
    MethodMirror getter = cm.getters[property];
    if (getter == null || !getter.isStatic)
      return null;

    context.setPropertyResolved(true);
    return ClassUtil.getCorrespondingClassMirror(getter.returnType);
  }

  //@Override
  void setValue(ELContext context, Object base, Object property, Object value) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! ClassMirror)
      return;

    ClassMirror cm = base;
    MethodMirror setter = cm.setters[property];
    if (setter == null  || !setter.isStatic)
      return;

    context.setPropertyResolved(true);

    if (this._readOnly)
      throw new PropertyNotWritableException(message(context,
               "resolverNotWriteable", [property]));

    ClassUtil.invokeObjectMirror(cm, setter, [value]);
  }

  //@Override
  bool isReadOnly(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! ClassMirror)
      return false;

    context.setPropertyResolved(true);

    return this._readOnly || !_hasSetter(base, property);
  }

  bool _hasSetter(Object base, Object property) {
    ClassMirror cm = base;
    String name = "${property}=";
    MethodMirror setter = cm.setters[name];
    return setter != null && setter.isStatic;
  }

  //@Override
  ClassMirror getCommonPropertyType(ELContext context, Object base) {
    if (context == null)
      throw const NullPointerException();

    return base != null ? ClassUtil.OBJECT_MIRROR : null;
  }

  //@Override
  Object invoke(ELContext context, Object base, Object method,
                List params, [Map<String, Object> namedArgs]) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || method == null || base is! ClassMirror)
      return null;

    String methodName = method.toString();
    ClassMirror cm = base;
    MethodMirror m = cm.methods[methodName];
    if (m == null || !m.isStatic)
      return null;

    context.setPropertyResolved(true);

    return ClassUtil.invokeObjectMirror(cm, m , params, namedArgs);
  }
}
