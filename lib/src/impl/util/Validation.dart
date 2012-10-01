//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  06:36:06 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class Validation {
  static bool _SKIP_IDENTIFIER_CHECK = false;

  // Dart keywords, bool literals & the null literal in alphabetical order
  static final List<String> _invalidIdentifiers = const ["abstract", "assert",
    "bool", "break", "case", "catch", "class", "const",
    "continue", "default", "do", "double", "else", "equals", "extends",
    "factory", "false", "final", "finally", "for", "if", "implements",
    "import", "in", "int", "is", "library", "native", "new",
    "null", "num", "on", "return", "static", "super", "switch", "this",
    "throw", "true", "try", "void", "while" ];

  /**
   * Test whether the argument is a Dart identifier.
   */
  static bool isIdentifier(String key) {
    if (_SKIP_IDENTIFIER_CHECK)
      return true;

    // Should not be the case but check to be sure
    if (key == null || key.length == 0)
      return false;

    // Check the list of known invalid values
    int i = 0;
    int j = _invalidIdentifiers.length;
    while (i < j) {
      int k = (i + j) >> 1; // Avoid overflow
      int result = _invalidIdentifiers[k].compareTo(key);
      if (result == 0)
        return false;
      if (result < 0)
        i = k + 1;
      else
        j = k;
    }

    return _IDENT.hasMatch(key);
  }

  static RegExp _IDENT = const RegExp("^[A-Za-z_]{1}[A-Za-z0-9_]*");
}
