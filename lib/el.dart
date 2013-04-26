//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen

library rikulo_el;

import 'dart:mirrors';
import 'dart:collection';
import 'package:rikulo_commons/mirrors.dart';
import 'package:rikulo_commons/util.dart' show ListUtil;

import "elimpl.dart" show ELContextImpl, ExpressionFactoryImpl;

part 'src/ArrayELResolver.dart';
part 'src/BeanELResolver.dart';
part 'src/CompositeELResolver.dart';
part 'src/ELContext.dart';
part 'src/ELContextEvent.dart';
part 'src/ELContextListener.dart';
part 'src/ELException.dart';
part 'src/ELResolver.dart';
part 'src/Expression.dart';
part 'src/ExpressionFactory.dart';
part 'src/FunctionMapper.dart';
//part 'src/ListELResolver.dart'; //duplicate with ArrayELResolver in dart
part 'src/LocalStrings.dart';
part 'src/MapELResolver.dart';
part 'src/MethodExpression.dart';
part 'src/MethodInfo.dart';
part 'src/MethodNotFoundException.dart';
part 'src/PropertyNotFoundException.dart';
part 'src/PropertyNotWritableException.dart';
//part 'src/ResourceBundleELResolver.dart';
part 'src/ValueExpression.dart';
part 'src/ValueReference.dart';
part 'src/VariableMapper.dart';

part 'src/VarELResolver.dart';
part 'src/ClassELResolver.dart';
part 'src/LibELResolver.dart';
part 'src/MessageFormat.dart';
part 'src/PropertiesBundle.dart';
part 'src/ELUtil.dart';

///Converts a map of named parameters to Symbol for synchronous invocation
Map<Symbol, Object> _toNamedParams(Map<String, Object> namedArgs) {
  if (namedArgs != null) {
    Map<Symbol, Object> nargs = new HashMap();
    namedArgs.forEach((k,v) => nargs[new Symbol(k)] = v);
    return nargs;
  }
  return null;
}
