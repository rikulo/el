//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  04:01:28 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/** Token Manager Error. */
class TokenMgrError implements Exception
{

  /*
   * Ordinals for various reasons why an Error of this type can be thrown.
   */

  /**
   * Lexical error occurred.
   */
  static final int LEXICAL_ERROR = 0;

  /**
   * An attempt was made to create a second instance of a static token manager.
   */
  static final int STATIC_LEXER_ERROR = 1;

  /**
   * Tried to change to an invalid lexical state.
   */
  static final int INVALID_LEXICAL_STATE = 2;

  /**
   * Detected (and bailed out of) an infinite loop in the token manager.
   */
  static final int LOOP_DETECTED = 3;

  /**
   * Indicates the reason why the exception is thrown. It will have
   * one of the above 4 values.
   */
  int errorCode_;

  final message;

  /**
   * Replaces unprintable characters by their escaped (or unicode escaped)
   * equivalents in the given string
   */
  static String addEscapes_(String str) {
    StringBuffer retval = new StringBuffer();
    int ch;
    for (int i = 0; i < str.length; i++) {
      switch (str.substring(i, i+1))
      {
//        case 0 :
//          continue;
        case '\b':
          retval.write("\\b");
          continue;
        case '\t':
          retval.write("\\t");
          continue;
        case '\n':
          retval.write("\\n");
          continue;
        case '\f':
          retval.write("\\f");
          continue;
        case '\r':
          retval.write("\\r");
          continue;
        case '\"':
          retval.write("\\\"");
          continue;
        case '\'':
          retval.write("\\\'");
          continue;
        case '\\':
          retval.write("\\\\");
          continue;
        default:
          if ((ch = str.codeUnitAt(i)) < 0x20 || ch > 0x7e) {
            String s = "0000${ch.toRadixString(16)}";
            retval..write("\\u")..write(s.substring(s.length - 4, s.length));
          } else if (ch != 0) {
            retval.write(ch);
          }
          continue;
      }
    }
    return retval.toString();
  }

  /**
   * Returns a detailed message for the Error when it is thrown by the
   * token manager to indicate a lexical error.
   * Parameters :
   *    EOFSeen     : indicates if EOF caused the lexical error
   *    curLexState : lexical state in which this error occurred
   *    errorLine   : line number when the error occurred
   *    errorColumn : column number when the error occurred
   *    errorAfter  : prefix that was seen before this error occurred
   *    curchar     : the offending character
   * Note: You can customize the lexical error message by modifying this method.
   */
  static String LexicalError_(bool EOFSeen, int lexState, int errorLine, int errorColumn, String errorAfter, int curChar) {
    StringBuffer sb = new StringBuffer("Lexical error at line ")
          ..write(errorLine)..write(", column ")
          ..write(errorColumn)..write(".  Encountered: ");
    if (EOFSeen)
      sb.write("<EOF> ");
    else
      sb..write("\"")..write(addEscapes_(new String.fromCharCodes([curChar])))
        ..write("\"")..write(" (")..write(curChar)..write("), ");
    return (sb..write("after : \"")..write(addEscapes_(errorAfter))..write("\"")).toString();
  }

  /**
   * You can also modify the body of this method to customize your error messages.
   * For example, cases like LOOP_DETECTED and INVALID_LEXICAL_STATE are not
   * of end-users concern, so you can return something like :
   *
   *     "Internal Error : Please file a bug report .... "
   *
   * from this method for such cases in the release version of your parser.
   */
  String getMessage() {
    return super.toString();
  }

  /*
   * Constructors of various flavors follow.
   */

  /** Constructor with message and reason. */
 TokenMgrError.fromMessage([this.message, int reason]) {
    errorCode_ = reason;
  }

  /** Full Constructor. */
 TokenMgrError(bool EOFSeen, int lexState, int errorLine, int errorColumn, String errorAfter, int curChar, int reason)
      : this.message = LexicalError_(EOFSeen, lexState, errorLine, errorColumn, errorAfter, curChar) {
    errorCode_ = reason;
  }

  String toString() => (message == null) ?
      "Exception: error code: $errorCode_" : "Exception: $message, error code: $errorCode_";
}
/* JavaCC - OriginalChecksum=de3ff0bacfb0fe749cc8eaf56ae82fea (do not edit this line) */
