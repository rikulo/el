//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  01:41:20 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class Messages extends PropertiesBundle {
  static final Map<String, Map<String, String>> _msgs = const {
    "en_US" : const {
      // General Errors
      "error.convert" : "Cannot convert {0} of type {1} to {2}",
      "error.compare" : "Cannot compare {0} to {1}",
      "error.function" : "Problems calling function ''{0}''",
      "error.unreachable.base" : "Target Unreachable, identifier ''{0}'' resolved to null",
      "error.unreachable.property" : "Target Unreachable, ''{0}'' returned null",
      "error.resolver.unhandled" : "ELResolver did not handle type: {0} with property of ''{1}''",
      "error.resolver.unhandled.null" : "ELResolver cannot handle a null base Object with identifier ''{0}''",

      // ValueExpressionLiteral
      "error.value.literal.write" : "ValueExpression is a literal and not writable: {0}",

      // ExpressionFactoryImpl
      "error.null" : "Expression cannot be null",
      "error.mixed" : "Expression cannot contain both '//{..}' and '\${..}' : {0}",
      "error.method" : "Not a valid MethodExpression : {0}",
      "error.method.nullParms" : "Parameter types cannot be null",
      "error.value.expectedType" : "Expected type cannot be null",

      // ExpressionBuilder
      "error.parseFail" : "Failed to parse the expression [{0}]",

      // ExpressionMediator
      "error.eval" : "Error Evaluating {0} : {1}",

      // ValueSetVisitor
      "error.syntax.set" : "Illegal Syntax for Set Operation",

      // ReflectionUtil
      "error.method.notfound" : "Method not found: {0}.{1}({2})",
      "error.method.ambiguous" : "Unable to find unambiguous method: {0}.{1}({2})",
      "error.property.notfound" : "Property ''{1}'' not found on {0}",

      // ValidatingVisitor
      "error.fnMapper.null" : "Expression uses functions, but no FunctionMapper was provided",
      "error.fnMapper.method" : "Function ''{0}'' not found",
      "error.fnMapper.paramcount" : "Function ''{0}'' specifies {1} positional params plus {2} optional positional params, but {3} were declared",

      // ExpressionImpl
      "error.context.null" : "ELContext was null",

      // ArrayELResolver
      "error.array.outofbounds" : "Index {0} is out of bounds for array of size {1}",

      // ListELResolver
      "error.list.outofbounds" : "Index {0} is out of bounds for list of size {1}",

      // BeanELResolver
//      "error.property.notfound" : "Property ''{1}'' not found on type: {0}",
      "error.property.invocation" : "Property ''{1}'' threw an exception from type: {0}",
      "error.property.notreadable" : "Property ''{1}'' doesn't have a 'get' specified on type: {0}",
      "error.property.notwritable" : "Property ''{1}'' doesn't have a 'set' specified on type: {0}",

      // Parser
      "error.identifier.notdart" : "The identifier [{0}] is a keyword or not a valid Dart identifier.",

      // MethodExpression
      "error.method.arguments" : "Expect [{0}] positional arguments plus [{1}] optional positional arguments but found [{2}] in method ''{3}''."
    },
    "es" : const {
      "error.convert" : "No puedo convertir {0} desde tipo {1} a {2}",
      "error.compare" : "No puedo comparar {0} con {1}",
      "error.function" : "Problemas llamando a funci\u00F3n ''{0}''",
      "error.unreachable.base" : "Objetivo inalcanzable, identificador ''{0}'' resuelto a nulo",
      "error.unreachable.property" : "Objetivo inalcanzable, ''{0}'' devolvi\u00F3 nulo",
      "error.resolver.unhandled" : "ELResolver no manej\u00F3 el tipo\: {0} con propiedad de ''{1}''",
      "error.resolver.unhandled.null" : "ELResolver no puede manejar un Objeto base nulo  con identificador de ''{0}''",
      "error.value.literal.write" : "ValueExpression es un literal y no un grabable\: {0}",
      "error.null" : "La expresi\u00F3n no puede ser nula",
      "error.mixed" : "La expresi\u00F3n no puede contenera la vez '\#{..}' y '\${..}' \: {0}",
      "error.method" : "No es una MethodExpression v\u00E1lida\: {0}",
      "error.method.nullParms" : "Los tipos de par\u00E1metro no pueden ser nulo",
      "error.value.expectedType" : "El tipo esperado no puede ser nulo",
      "error.eval" : "Error Evaluando {0} \: {1}",
      "error.syntax.set" : "Sit\u00E1xis ilegal para Operaci\u00F3n de Poner Valor",
      "error.method.notfound" : "M\u00E9todo no hallado\: {0}.{1}({2})",
      "error.method.ambiguous" : "No pude hallar m\u00E9todo ambiguo\: {0}.{1}({2})",
      "error.property.notfound" : "Propiedad ''{1}'' no hallada en tipo\: {0}",
      "error.fnMapper.null" : "La expresi\u00F3n usa funciones, pero no se ha suministrado FunctionMapper",
      "error.fnMapper.method" : "Funci\u00F3n ''{0}'' no hallada",
      //need translation
      "error.fnMapper.paramcount" : "Function ''{0}'' specifies {1} positional params plus {2} optional positional params, but {3} were declared",

      "error.context.null" : "ELContext era nulo",
      "error.array.outofbounds" : "\u00CDndice {0} fuera de l\u00EDmites para arreglo de medida {1}",
      "error.list.outofbounds" : "\u00CDndice {0} fuera de l\u00EDmites para lista de medida {1}",
      "error.property.invocation" : "Propiedad ''{1}'' lanz\u00F3 una excepci\u00F3n desde tipo\: {0}",
      "error.property.notreadable" : "La propiedad ''{1}'' no tiene un 'get' especificado en el tipo\: {0}",
      "error.property.notwritable" : "La propiedad ''{1}'' no tiene un 'set' especificado en el tipo\: {0}",
      "error.identifier.notdart" : "El identificador [{0}] es una palabra clave o un identificador no válido Dart.",

      //need translation
      "error.method.arguments" : "Expect [{0}] positional arguments plus [{1}] optional positional arguments but found [{2}] in method ''{3}''."
  }
  };

  Messages(String locale)
    : super(locale);

  Map<String, Map<String, String>> getBundle_() => _msgs;
}