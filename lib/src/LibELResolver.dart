//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Oct 03, 2012  06:55:03 PM
// Author: hernichen

part of rikulo_el;

/**
 * Resolve LibraryMirror variable and function.
 */
//issue7: resolve library level variable and method
class LibELResolver implements ELResolver {
  final bool _readOnly;

  LibELResolver([bool readOnly = false])
      : this._readOnly = readOnly;

  //@Override
  Object getValue(ELContext context, Object base, Object property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! LibraryMirror)
      return null;

    LibraryMirror lm = base;

    //try top level getter
    MethodMirror getter = lm.getters[new Symbol(property)];
    if (getter != null && getter.isStatic) {
      context.isPropertyResolved = true;
      return ClassUtil.invokeByMirror(lm, getter, []);
    }

    //try class in library
    ClassMirror clz = lm.classes[new Symbol(property)];
    if (clz != null) {
      context.isPropertyResolved = true;
      return clz;
    }

    return null;
  }

  //@Override
  TypeMirror getType(ELContext context, Object base, Object property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! LibraryMirror)
      return null;

    LibraryMirror lm = base;
    MethodMirror getter = lm.getters[new Symbol(property)];
    if (getter == null || !getter.isStatic)
      return null;

    context.isPropertyResolved = true;
    return getter.returnType;
  }

  //@Override
  void setValue(ELContext context, Object base, Object property, Object value) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! LibraryMirror)
      return;

    LibraryMirror lm = base;
    MethodMirror setter = lm.setters[new Symbol(property)];
    if (setter == null  || !setter.isStatic)
      return;

    context.isPropertyResolved = true;

    if (this._readOnly)
      throw new PropertyNotWritableException(message(context,
               "resolverNotWriteable", [property]));

    ClassUtil.invokeByMirror(lm, setter, [value]);
  }

  //@Override
  bool isReadOnly(ELContext context, Object base, Object property) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || property == null || base is! LibraryMirror)
      return false;

    context.isPropertyResolved = true;

    return this._readOnly || !_hasSetter(base, property);
  }

  bool _hasSetter(Object base, Object property) {
    LibraryMirror lm = base;
    MethodMirror setter = lm.setters[new Symbol("${property}=")];
    return setter != null && setter.isStatic;
  }

  //@Override
  ClassMirror getCommonPropertyType(ELContext context, Object base) {
    if (context == null)
      throw new ArgumentError("context: null");

    return base != null ? OBJECT_MIRROR : null;
  }

  //@Override
  Object invoke(ELContext context, Object base, Object method,
                List params, [Map<String, Object> namedArgs]) {
    if (context == null)
      throw new ArgumentError("context: null");

    if (base == null || method == null || base is! LibraryMirror)
      return null;

    String methodName = method.toString();
    LibraryMirror lm = base;
    MethodMirror fn = lm.functions[new Symbol(methodName)];
    if (fn == null || !fn.isStatic)
      return null;

    context.isPropertyResolved = true;
    return ClassUtil.invokeByMirror(lm, fn , params, namedArgs);
  }
}
