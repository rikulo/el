//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  04:01:28 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/**
 * Describes the input token stream.
 */
class Token {

  /**
   * An integer that describes the kind_ of this token.  This numbering
   * system is determined by JavaCCParser, and a table of these numbers is
   * stored in the file ...Constants.java.
   */
  int kind_ = 0;

  /** The line number of the first character of this Token. */
  int beginLine_ = 0;
  /** The column number of the first character of this Token. */
  int beginColumn_ = 0;
  /** The line number of the last character of this Token. */
  int endLine_ = 0;
  /** The column number of the last character of this Token. */
  int endColumn_ = 0;

  /**
   * The string image_ of the token.
   */
  String image_;

  /**
   * A reference to the next_ regular (non-special) token from the input
   * stream.  If this is the last token from the input stream, or if the
   * token manager has not read tokens beyond this one, this field is
   * set to null.  This is true only if this token is also a regular
   * token.  Otherwise, see below for a description of the contents of
   * this field.
   */
  Token next_;

  /**
   * This field is used to access special tokens that occur prior to this
   * token, but after the immediately preceding regular (non-special) token.
   * If there are no such special tokens, this field is set to null.
   * When there are more than one such special token, this field refers
   * to the last of these special tokens, which in turn refers to the next_
   * previous special token through its specialToken_ field, and so on
   * until the first special token (whose specialToken_ field is null).
   * The next_ fields of special tokens refer to other special tokens that
   * immediately follow it (without an intervening regular token).  If there
   * is no such token, this field is null.
   */
  Token specialToken_;

  /**
   * An optional attribute value of the Token.
   * Tokens which are not used as syntactic sugar will often contain
   * meaningful values that will be used later on by the compiler or
   * interpreter. This attribute value is often different from the image_.
   * Any subclass of Token that actually wants to return a non-null value can
   * override this method as appropriate.
   */
  getValue() {
    return null;
  }

  /**
   * Constructs a new token for the specified Image and Kind.
   */
  Token([int kind, String image])
  {
    this.kind_ = kind;
    this.image_ = image;
  }

  /**
   * Returns the image.
   */
  String toString()
  {
    return image_;
  }

  /**
   * Returns a new Token object, by default. However, if you want, you
   * can create and return subclass objects based on the value of ofKind.
   * Simply add the cases to the switch for all those special cases.
   * For example, if you have a subclass of Token called IDToken that
   * you want to create if ofKind is ID, simply add something like :
   *
   *    case MyParserConstants.ID : return new IDToken(ofKind, image_);
   *
   * to the following switch statement. Then you can cast matchedToken
   * variable to the appropriate type and use sit in your lexical actions.
   */
  static Token newToken([int ofKind, String image])
  {
    switch(ofKind)
    {
      default : return new Token(ofKind, image);
    }
  }

}
/* JavaCC - OriginalChecksum=3fc97649fffa8b13e1e03af022020b2f (do not edit this line) */
