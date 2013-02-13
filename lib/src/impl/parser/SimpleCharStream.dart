//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 19, 2012  12:10:41 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/**
 * An implementation of interface CharStream, where the stream is assumed to
 * contain only ASCII characters (without unicode processing).
 */
class SimpleCharStream
{
/** Whether parser is static. */
  static final bool staticFlag = false;
  int bufsize = 0;
  int available = 0;
  int tokenBegin = 0;
/** Position in buffer. */
  int bufpos = -1;
  List<int> bufline_;
  List<int> bufcolumn_;

  int column_ = 0;
  int line_ = 1;

  bool prevCharIsCR_ = false;
  bool prevCharIsLF_ = false;

  Reader inputStream_;

  List<int> buffer_;
  int maxNextCharInd_ = 0;
  int inBuf_ = 0;
  int tabSize_ = 8;

  void setTabSize(int i) { tabSize_ = i; }
  int getTabSize(int i) { return tabSize_; }


  void ExpandBuff_(bool wrapAround)
  {
    List<int> newbuffer = _newIntList(bufsize + 2048);
    List<int> newbufline = _newIntList(bufsize + 2048);
    List<int> newbufcolumn = _newIntList(bufsize + 2048);

//    try
//    {
      if (wrapAround)
      {
        Arrays.copy(buffer_, tokenBegin, newbuffer, 0, bufsize - tokenBegin);
        Arrays.copy(buffer_, 0, newbuffer, bufsize - tokenBegin, bufpos);
        buffer_ = newbuffer;

        Arrays.copy(bufline_, tokenBegin, newbufline, 0, bufsize - tokenBegin);
        Arrays.copy(bufline_, 0, newbufline, bufsize - tokenBegin, bufpos);
        bufline_ = newbufline;

        Arrays.copy(bufcolumn_, tokenBegin, newbufcolumn, 0, bufsize - tokenBegin);
        Arrays.copy(bufcolumn_, 0, newbufcolumn, bufsize - tokenBegin, bufpos);
        bufcolumn_ = newbufcolumn;

        maxNextCharInd_ = (bufpos += (bufsize - tokenBegin));
      }
      else
      {
        Arrays.copy(buffer_, tokenBegin, newbuffer, 0, bufsize - tokenBegin);
        buffer_ = newbuffer;

        Arrays.copy(bufline_, tokenBegin, newbufline, 0, bufsize - tokenBegin);
        bufline_ = newbufline;

        Arrays.copy(bufcolumn_, tokenBegin, newbufcolumn, 0, bufsize - tokenBegin);
        bufcolumn_ = newbufcolumn;

        maxNextCharInd_ = (bufpos -= tokenBegin);
      }
//    }
//    on Exception catch (t)
//    {
//      throw new Error(t.toString());
//    }


    bufsize += 2048;
    available = bufsize;
    tokenBegin = 0;
  }

  void FillBuff_()
  {
    if (maxNextCharInd_ == available)
    {
      if (available == bufsize)
      {
        if (tokenBegin > 2048)
        {
          bufpos = maxNextCharInd_ = 0;
          available = tokenBegin;
        }
        else if (tokenBegin < 0)
          bufpos = maxNextCharInd_ = 0;
        else
          ExpandBuff_(false);
      }
      else if (available > tokenBegin)
        available = bufsize;
      else if ((tokenBegin - available) < 2048)
        ExpandBuff_(true);
      else
        available = tokenBegin;
    }

    int i = 0;
    try {
      if ((i = inputStream_.read(buffer_, maxNextCharInd_, available - maxNextCharInd_)) == -1)
      {
        inputStream_.close();
        throw new ReaderIOException();
      }
      else
        maxNextCharInd_ += i;
      return;
    }
    on ReaderIOException catch(e) {
      --bufpos;
      backup(0);
      if (tokenBegin == -1)
        tokenBegin = bufpos;
      throw e;
    }
  }

/** Start. */
  int BeginToken()
  {
    tokenBegin = -1;
    int c = readCharCode();
    tokenBegin = bufpos;

    return c;
  }

  void UpdateLineColumn_(int ccode)
  {
    String c = new String.fromCharCodes([ccode]);
    column_++;

    if (prevCharIsLF_)
    {
      prevCharIsLF_ = false;
      line_ += (column_ = 1);
    }
    else if (prevCharIsCR_)
    {
      prevCharIsCR_ = false;
      if (c == '\n')
      {
        prevCharIsLF_ = true;
      }
      else
        line_ += (column_ = 1);
    }

    switch (c)
    {
      case '\r' :
        prevCharIsCR_ = true;
        break;
      case '\n' :
        prevCharIsLF_ = true;
        break;
      case '\t' :
        column_--;
        column_ += (tabSize_ - (column_ % tabSize_));
        break;
      default :
        break;
    }

    bufline_[bufpos] = line_;
    bufcolumn_[bufpos] = column_;
  }

/** Read a character. */
  int readCharCode()
  {
    if (inBuf_ > 0)
    {
      --inBuf_;

      if (++bufpos == bufsize)
        bufpos = 0;

      return buffer_[bufpos];
    }

    if (++bufpos >= maxNextCharInd_)
      FillBuff_();

    int c = buffer_[bufpos];

    UpdateLineColumn_(c);
    return c;
  }

  /** Get token end column number. */
  int getEndColumn() {
    return bufcolumn_[bufpos];
  }

  /** Get token end line number. */
  int getEndLine() {
     return bufline_[bufpos];
  }

  /** Get token beginning column number. */
  int getBeginColumn() {
    return bufcolumn_[tokenBegin];
  }

  /** Get token beginning line number. */
  int getBeginLine() {
    return bufline_[tokenBegin];
  }

/** Backup a number of characters. */
  void backup(int amount) {

    inBuf_ += amount;
    if ((bufpos -= amount) < 0)
      bufpos += bufsize;
  }

  /** Constructor. */
  SimpleCharStream(Reader dstream, [int startline = 1,
  int startcolumn = 1, int buffersize = 4096])
  {
    inputStream_ = dstream;
    line_ = startline;
    column_ = startcolumn - 1;

    available = bufsize = buffersize;
    buffer_ = _newIntList(buffersize);
    bufline_ = _newIntList(buffersize);
    bufcolumn_ = _newIntList(buffersize);
  }

//  /** Constructor. */
//  SimpleCharStream(Reader dstream, int startline,
//                          int startcolumn)
//  {
//    this(dstream, startline, startcolumn, 4096);
//  }
//
//  /** Constructor. */
//  SimpleCharStream(Reader dstream)
//  {
//    this(dstream, 1, 1, 4096);
//  }

  /** Reinitialise. */
  void ReInit(Reader dstream, [int startline = 1,
  int startcolumn = 1, int buffersize = 4096])
  {
    inputStream_ = dstream;
    line_ = startline;
    column_ = startcolumn - 1;

    if (buffer_ == null || buffersize != buffer_.length)
    {
      available = bufsize = buffersize;
      buffer_ = _newIntList(buffersize);
      bufline_ = _newIntList(buffersize);
      bufcolumn_ = _newIntList(buffersize);
    }
    prevCharIsLF_ = prevCharIsCR_ = false;
    tokenBegin = inBuf_ = maxNextCharInd_ = 0;
    bufpos = -1;
  }

//  /** Reinitialise. */
//  void ReInit(Reader dstream, int startline,
//                     int startcolumn)
//  {
//    ReInit(dstream, startline, startcolumn, 4096);
//  }
//
//  /** Reinitialise. */
//  void ReInit(Reader dstream)
//  {
//    ReInit(dstream, 1, 1, 4096);
//  }
//  /** Constructor. */
//  SimpleCharStream(java.io.InputStream dstream, String encoding, int startline,
//  int startcolumn, int buffersize) throws java.io.UnsupportedEncodingException
//  {
//    this(encoding == null ? new java.io.InputStreamReader(dstream) : new java.io.InputStreamReader(dstream, encoding), startline, startcolumn, buffersize);
//  }
//
//  /** Constructor. */
//  SimpleCharStream(java.io.InputStream dstream, int startline,
//  int startcolumn, int buffersize)
//  {
//    this(new java.io.InputStreamReader(dstream), startline, startcolumn, buffersize);
//  }
//
//  /** Constructor. */
//  SimpleCharStream(java.io.InputStream dstream, String encoding, int startline,
//                          int startcolumn) throws java.io.UnsupportedEncodingException
//  {
//    this(dstream, encoding, startline, startcolumn, 4096);
//  }
//
//  /** Constructor. */
//  SimpleCharStream(java.io.InputStream dstream, int startline,
//                          int startcolumn)
//  {
//    this(dstream, startline, startcolumn, 4096);
//  }
//
//  /** Constructor. */
//  SimpleCharStream(java.io.InputStream dstream, String encoding) throws java.io.UnsupportedEncodingException
//  {
//    this(dstream, encoding, 1, 1, 4096);
//  }
//
//  /** Constructor. */
//  SimpleCharStream(java.io.InputStream dstream)
//  {
//    this(dstream, 1, 1, 4096);
//  }
//
//  /** Reinitialise. */
//  void ReInit(java.io.InputStream dstream, String encoding, int startline,
//                          int startcolumn, int buffersize) throws java.io.UnsupportedEncodingException
//  {
//    ReInit(encoding == null ? new java.io.InputStreamReader(dstream) : new java.io.InputStreamReader(dstream, encoding), startline, startcolumn, buffersize);
//  }
//
//  /** Reinitialise. */
//  void ReInit(java.io.InputStream dstream, int startline,
//                          int startcolumn, int buffersize)
//  {
//    ReInit(new java.io.InputStreamReader(dstream), startline, startcolumn, buffersize);
//  }
//
//  /** Reinitialise. */
//  void ReInit(java.io.InputStream dstream, String encoding) throws java.io.UnsupportedEncodingException
//  {
//    ReInit(dstream, encoding, 1, 1, 4096);
//  }
//
//  /** Reinitialise. */
//  void ReInit(java.io.InputStream dstream)
//  {
//    ReInit(dstream, 1, 1, 4096);
//  }
//  /** Reinitialise. */
//  void ReInit(java.io.InputStream dstream, String encoding, int startline,
//                     int startcolumn) throws java.io.UnsupportedEncodingException
//  {
//    ReInit(dstream, encoding, startline, startcolumn, 4096);
//  }
//  /** Reinitialise. */
//  void ReInit(java.io.InputStream dstream, int startline,
//                     int startcolumn)
//  {
//    ReInit(dstream, startline, startcolumn, 4096);
//  }
  /** Get token literal value. */
  String GetImage()
  {
    if (bufpos >= tokenBegin)
      return _charCodesToString(buffer_, tokenBegin, bufpos - tokenBegin + 1);
    else
      return new StringBuffer(_charCodesToString(buffer_, tokenBegin, bufsize - tokenBegin))
          .add(_charCodesToString(buffer_, 0, bufpos + 1)).toString();
  }

  String _charCodesToString(List<int> src, int offset, int count) {
    List<int> charCodes = new List(count);
    Arrays.copy(src, offset, charCodes, 0, count);
    return new String.fromCharCodes(charCodes);
  }

  /** Get the suffix. */
  List<int> GetSuffix(int len)
  {
    List<int> ret = _newIntList(len);

    if ((bufpos + 1) >= len)
      Arrays.copy(buffer_, bufpos - len + 1, ret, 0, len);
    else
    {
      Arrays.copy(buffer_, bufsize - (len - bufpos - 1), ret, 0,
                                                        len - bufpos - 1);
      Arrays.copy(buffer_, 0, ret, len - bufpos - 1, bufpos + 1);
    }

    return ret;
  }

  /** Reset buffer when finished. */
  void Done()
  {
    buffer_ = null;
    bufline_ = null;
    bufcolumn_ = null;
  }

  /**
   * Method to adjust line and column numbers for the start of a token.
   */
  void adjustBeginLineColumn(int newLine, int newCol)
  {
    int start = tokenBegin;
    int len = 0;

    if (bufpos >= tokenBegin)
    {
      len = bufpos - tokenBegin + inBuf_ + 1;
    }
    else
    {
      len = bufsize - tokenBegin + bufpos + 1 + inBuf_;
    }

    int i = 0, j = 0, k = 0;
    int nextColDiff = 0, columnDiff = 0;

    while (i < len && bufline_[j = start % bufsize] == bufline_[k = ++start % bufsize])
    {
      bufline_[j] = newLine;
      nextColDiff = columnDiff + bufcolumn_[k] - bufcolumn_[j];
      bufcolumn_[j] = newCol + columnDiff;
      columnDiff = nextColDiff;
      i++;
    }

    if (i < len)
    {
      bufline_[j] = newLine++;
      bufcolumn_[j] = newCol + columnDiff;

      while (i++ < len)
      {
        if (bufline_[j = start % bufsize] != bufline_[++start % bufsize])
          bufline_[j] = newLine++;
        else
          bufline_[j] = newLine;
      }
    }

    line_ = bufline_[j];
    column_ = bufcolumn_[j];
  }

}
/* JavaCC - OriginalChecksum=9ba0db3918bffb8019f00da1e421f339 (do not edit this line) */

abstract class Reader {
  int read(List<int> cbuf, int off, int len);
  void close();
}

class StringReader implements Reader {
  String _ref;

  StringReader(String ref)
      : _ref = ref;

  int read(List<int> cbuf, int off, int len) {
    if (off >= _ref.length) return -1;
    int count = 0;
    for(int j = off; j < _ref.length && count < len; ++j) {
      cbuf[count++] = _ref.codeUnitAt(j);
    }
    return count;
  }

  void close() {}
}

class ReaderIOException extends ELException {
  ReaderIOException([String message, Exception cause])
      : super(message, cause);
}