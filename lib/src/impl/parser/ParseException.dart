//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  03:28:41 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/**
 * This exception is thrown when parse errors are encountered.
 * You can explicitly create objects of this exception type by
 * calling the method generateParseException in the generated
 * parser.
 *
 * You can modify this class to customize your error reporting
 * mechanisms so long as you retain the fields.
 */
class ParseException implements Exception {
  final message;
  /**
   * This constructor is used by the method "generateParseException"
   * in the generated parser.  Calling this constructor generates
   * a new object of this type with the fields "currentToken_",
   * "expectedTokenSequences_", and "tokenImage_" set.
   */
  ParseException.fromToken(Token currentTokenVal,
                        List<List<int>> expectedTokenSequencesVal,
                        List<String> tokenImageVal)
      : this.message = _initialise(currentTokenVal, expectedTokenSequencesVal, tokenImageVal) {

    this.currentToken_ = currentTokenVal;
    this.expectedTokenSequences_ = expectedTokenSequencesVal;
    this.tokenImage_ = tokenImageVal;
  }

  /** Constructor with message. */
  ParseException([this.message]);

  String toString() => (message == null) ? "Exception:" : "Exception: $message";

  /**
   * This is the last token that has been consumed successfully.  If
   * this object has been created due to a parse error, the token
   * followng this token will (therefore) be the first error token.
   */
  Token currentToken_;

  /**
   * Each entry in this array is an array of integers.  Each array
   * of integers represents a sequence of tokens (by their ordinal
   * values) that is expected at this point of the parse.
   */
  List<List<int>> expectedTokenSequences_;

  /**
   * This is a reference to the "tokenImage_" array of the generated
   * parser within which the parse error occurred.  This array is
   * defined in the generated ...Constants interface.
   */
  List<String> tokenImage_;

  String getMessage() => toString();

  /**
   * It uses "currentToken_" and "expectedTokenSequences_" to generate a parse
   * error message and returns it.  If this object has been created
   * due to a parse error, and you do not catch it (it gets thrown
   * from the parser) the correct error message
   * gets displayed.
   */
  static String _initialise(Token currentToken_,
                           List<List<int>> expectedTokenSequences_,
                           List<String> tokenImage) {
    String eol = "\n"; //String eol = System.getProperty("line.separator", "\n");
    StringBuffer expected = new StringBuffer();
    int maxSize = 0;
    for (int i = 0; i < expectedTokenSequences_.length; i++) {
      if (maxSize < expectedTokenSequences_[i].length) {
        maxSize = expectedTokenSequences_[i].length;
      }
      for (int j = 0; j < expectedTokenSequences_[i].length; j++) {
        expected..write(tokenImage[expectedTokenSequences_[i][j]])..write(' ');
      }
      if (expectedTokenSequences_[i][expectedTokenSequences_[i].length - 1] != 0) {
        expected.write("...");
      }
      expected..write(eol)..write("    ");
    }
    StringBuffer retval = new StringBuffer("Encountered \"");
    Token tok = currentToken_.next_;
    for (int i = 0; i < maxSize; i++) {
      if (i != 0) retval.write(" ");
      if (tok.kind_ == 0) {
        retval.write(tokenImage[0]);
        break;
      }
      retval..write(" ")..write(tokenImage[tok.kind_])
        ..write(" \"")
        ..write(add_escapes(tok.image_))
        ..write("\" ");
      tok = tok.next_;
    }
    retval..write("\" at line ")..write(currentToken_.next_.beginLine_)
      ..write(", column ")..write(currentToken_.next_.beginColumn_);
    retval..write(".")..write(eol);
    if (expectedTokenSequences_.length == 1) {
      retval..write("Was expecting:")..write(eol)..write("    ");
    } else {
      retval..write("Was expecting one of:")..write(eol)..write("    ");
    }
    retval.write(expected.toString());
    return retval.toString();
  }

  /**
   * The end of line string for this machine.
   */
  String eol_ = "\n"; //System.getProperty("line.separator", "\n");

  /**
   * Used to convert raw characters to their escaped version
   * when these raw version cannot be used as part of an ASCII
   * string literal.
   */
  static String add_escapes(String str) {
      StringBuffer retval = new StringBuffer();
      int ch;
      for (int i = 0; i < str.length; i++) {
        switch (str.substring(i, i+1))
        {
//           case 0:
//              continue;
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
                 retval.write("\\u${s.substring(s.length - 4, s.length)}");
              } else if (ch != 0) {
                 retval..write(new String.fromCharCodes([ch]))..write("(")..write(ch)..write(")");
              }
              continue;
        }
      }
      return retval.toString();
   }


}

/* JavaCC - OriginalChecksum=87586a39aa89f164889cc59bc6a7e7ad (do not edit this line) */
