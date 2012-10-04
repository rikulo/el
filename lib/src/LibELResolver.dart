//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Oct 03, 2012  06:55:03 PM
// Author: hernichen

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
      throw const NullPointerException();

    if (base == null || property == null || base is! LibraryMirror)
      return null;

    LibraryMirror lm = base;

    //try top level getter
    MethodMirror getter = lm.getters[property];
    if (getter != null && getter.isStatic) {
      context.setPropertyResolved(true);
      return ClassUtil.invokeObjectMirror(lm, getter, []);
    }

    //try class in library
    ClassMirror clz = lm.classes[property];
    if (clz != null) {
      context.setPropertyResolved(true);
      return clz;
    }

    return null;
  }

  //@Override
  ClassMirror getType(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! LibraryMirror)
      return null;

    LibraryMirror lm = base;
    MethodMirror getter = lm.getters[property];
    if (getter == null || !getter.isStatic)
      return null;

    context.setPropertyResolved(true);
    return ClassUtil.getCorrespondingClassMirror(getter.returnType);
  }

  //@Override
  void setValue(ELContext context, Object base, Object property, Object value) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! LibraryMirror)
      return;

    LibraryMirror lm = base;
    MethodMirror setter = lm.setters[property];
    if (setter == null  || !setter.isStatic)
      return;

    context.setPropertyResolved(true);

    if (this._readOnly)
      throw new PropertyNotWritableException(message(context,
               "resolverNotWriteable", [property]));

    ClassUtil.invokeObjectMirror(lm, setter, [value]);
  }

  //@Override
  bool isReadOnly(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base == null || property == null || base is! LibraryMirror)
      return false;

    context.setPropertyResolved(true);

    return this._readOnly || !_hasSetter(base, property);
  }

  bool _hasSetter(Object base, Object property) {
    LibraryMirror lm = base;
    String name = "${property}=";
    MethodMirror setter = lm.setters[name];
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

    if (base == null || method == null || base is! LibraryMirror)
      return null;

    String methodName = method.toString();
    LibraryMirror lm = base;
    MethodMirror fn = lm.functions[methodName];
    if (fn == null || !fn.isStatic)
      return null;

    context.setPropertyResolved(true);
    return ClassUtil.invokeObjectMirror(lm, fn , params, namedArgs);
  }
}
