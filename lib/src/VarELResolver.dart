//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Sat, Sep 29, 2012  04:08:11 PM
// Author: hernichen

//issue3: resolve top level variable
class VarELResolver implements ELResolver {
  final bool _readOnly;

  VarELResolver([bool readOnly = false])
      : this._readOnly = readOnly;

  //@Override
  Object getValue(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base != null || property == null)
      return null;

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return null;

    context.setPropertyResolved(true);
    Future<InstanceMirror> result = _getLib().getField(property);

    //TODO(henri) : handle exception
    while(!result.isComplete)
      ; //wait another Isolate to complete
    return result.value.reflectee;
  }

  //@Override
  ClassMirror getType(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base != null || property == null)
      return null;

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return null;

    context.setPropertyResolved(true);
    return ClassUtil.getCorrespondingClassMirror(vm.type);
  }

  //@Override
  void setValue(ELContext context, Object base, Object property, Object value) {
    if (context == null) {
      throw const NullPointerException();
    }
    if (base != null || property == null) {
      return;
    }

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return;

    context.setPropertyResolved(true);

    if (this._readOnly)
      throw new PropertyNotWritableException(message(context,
               "resolverNotWriteable", [property]));

    Future<InstanceMirror> result = _getLib().setField(property, value);

    //TODO(henri) : handle exception
    while(!result.isComplete)
      ; //wait another Isolate to complete
  }

  //@Override
  bool isReadOnly(ELContext context, Object base, Object property) {
    if (context == null)
      throw const NullPointerException();

    if (base != null || property == null)
      return false;

    VariableMirror vm = _getVar(property);
    if (vm == null)
      return false;

    context.setPropertyResolved(true);
    return this._readOnly || vm.isFinal;
  }

  //@Override
  ClassMirror getCommonPropertyType(ELContext context, Object base) {
    if (context == null)
      throw const NullPointerException();

    return base == null ? ClassUtil.OBJECT_MIRROR : null;
  }

  //@Override
  Object invoke(ELContext context, Object base, Object method,
                List params, [Map<String, Object> namedArgs]) => null;

  LibraryMirror _getLib() {
    return currentMirrorSystem().isolate.rootLibrary;
  }

  VariableMirror _getVar(Object property) {
    LibraryMirror lm = currentMirrorSystem().isolate.rootLibrary;
    return lm != null ? lm.variables[property] : null;
  }
}
