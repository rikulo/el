//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:43:11 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class LocalStrings extends PropertiesBundle {
  static final Map<String, Map<String, String>> _msgs = const {
    "en_US" : const {
      "propertyNotFound" : "Property ''{1}'' not found on type {0}",
      "propertyNotReadable" : "Property ''{1}'' not readable on type {0}",
      "propertyNotWritable" : "Property ''{1}'' not writable on type {0}",
      "propertyReadError" : "Error reading ''{1}'' on type {0}",
      "propertyWriteError" : "Error writing ''{1}'' on type {0}",
      "objectNotAssignable" : "Unable to add an object of type [{0}] to an array of objects of type [{1}]"
    },
    "es" : const {
      "propertyNotFound" : "Propiedad ''{1}'' no hallada en el tipo {0}",
      "propertyNotReadable" : "Propiedad ''{1}'' no legible para el tipo {0}",
      "propertyNotWritable" : "Propiedad ''{1}'' no grabable para el tipo {0}",
      "propertyReadError" : "Error reading ''{1}'' en el tipo {0}",
      "propertyWriteError" : "Error writing ''{1}'' en el tipo {0}",
      "objectNotAssignable" : "No puedo a\u00F1adir un objeto del tipo [{0}] a un arreglo de objetos del tipo [{1}]"
    }
  };

  LocalStrings(String locale)
    : super(locale);

  Map<String, Map<String, String>> getBundle_() => _msgs;
}