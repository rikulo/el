//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  03:52:08 PM
// Author: hernichen

part of rikulo_el;

class MessageFormat {
  static final int _QUOTE = "'".codeUnitAt(0);
  static final int _LBRACE = "{".codeUnitAt(0);
  static final int _RBRACE = "}".codeUnitAt(0);

	static String format(String pattern, List props) {
    StringBuffer sb = new StringBuffer();
    int openQuote = -2;
    int lbrace = -2;
    for (int j = 0; j < pattern.length; ++j) {
      int ch = pattern.codeUnitAt(j);
      if (ch ==_QUOTE) {
        if ((openQuote + 1) == j) {//consequtive quotes
          if (lbrace >= 0)
            sb.add(pattern.substring(lbrace, openQuote));
          sb.add("'");
          openQuote = lbrace = -2;
        }
        else if (openQuote >= 0) {
          sb.add(pattern.substring(openQuote + 1, j));
          openQuote = lbrace = -2;
        }
        else {
          openQuote = j;
          if (lbrace >= 0) {
            sb.add(pattern.substring(lbrace, j));
            lbrace = -2;
          }
        }
      }
      else if (ch == _LBRACE) {
        if (openQuote < 0)
          lbrace = j;
      }
      else if (ch == _RBRACE) {
        if (lbrace >= 0) {
          sb.add(props[int.parse(pattern.substring(lbrace+1, j))]);
          lbrace = -2;
        } else if (openQuote < 0)
          sb.add('}');
      }
      else if (lbrace < 0 && openQuote < 0){
        sb.addCharCode(ch);
      }
    }
    return sb.toString();
  }
}