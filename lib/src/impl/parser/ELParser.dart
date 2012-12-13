//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  07:23:41 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

class ELParser {
  JJTELParserState jj_save_ = new JJTELParserState();

  static Node parse(var ref)
    {
        try {
            return (new ELParser(new StringReader(ref))).CompositeExpression();
        } on ParseException catch (pe) {
            throw new ELException(pe.getMessage());
        }
    }

/*
 * CompositeExpression
 * Allow most flexible parsing, restrict by examining
 * type of returned node
 */
  AstCompositeExpression CompositeExpression() {

  AstCompositeExpression jjtn000 = new AstCompositeExpression(ELParserTreeConstants.JJTCOMPOSITEEXPRESSION);
  bool jjtc000 = true;
  jj_save_.openNodeScope(jjtn000);
    try {
      label_1:
      while (true) {
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.LITERAL_EXPRESSION:
        case ELParserConstants.START_DYNAMIC_EXPRESSION:
        case ELParserConstants.START_DEFERRED_EXPRESSION:
          ;
          break;
        default:
          _jj_la1[0] = _jj_gen;
          break label_1;
        }
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.START_DEFERRED_EXPRESSION:
          DeferredExpression();
          break;
        case ELParserConstants.START_DYNAMIC_EXPRESSION:
          DynamicExpression();
          break;
        case ELParserConstants.LITERAL_EXPRESSION:
          LiteralExpression();
          break;
        default:
          _jj_la1[1] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
      }
      _jj_consume_token(0);
      jj_save_.closeNodeScopeByCondition(jjtn000, true);
      jjtc000 = false;
      {if (true) return jjtn000;}
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
    throw new Exception("Missing return statement in function");
  }

/*
 * LiteralExpression
 * Non-EL Expression blocks
 */
  void LiteralExpression() {
    AstLiteralExpression jjtn000 = new AstLiteralExpression(ELParserTreeConstants.JJTLITERALEXPRESSION);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);Token t = null;
    try {
      t = _jj_consume_token(ELParserConstants.LITERAL_EXPRESSION);
      jj_save_.closeNodeScopeByCondition(jjtn000, true);
      jjtc000 = false;
      jjtn000.setImage(t.image_);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * DeferredExpression
 * #{..} Expressions
 */
  void DeferredExpression() {
    AstDeferredExpression jjtn000 = new AstDeferredExpression(ELParserTreeConstants.JJTDEFERREDEXPRESSION);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);
    try {
      _jj_consume_token(ELParserConstants.START_DEFERRED_EXPRESSION);
      Expression();
      _jj_consume_token(ELParserConstants.END_EXPRESSION);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * DynamicExpression
 * ${..} Expressions
 */
  void DynamicExpression() {
    AstDynamicExpression jjtn000 = new AstDynamicExpression(ELParserTreeConstants.JJTDYNAMICEXPRESSION);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);
    try {
      _jj_consume_token(ELParserConstants.START_DYNAMIC_EXPRESSION);
      Expression();
      _jj_consume_token(ELParserConstants.END_EXPRESSION);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * Expression
 * EL Expression Language Root, goes to Choice
 */
  void Expression() {
    Choice();
  }

/*
 * Choice
 * For Choice markup a ? b : c, then Or
 */
  void Choice() {
    Or();
    label_2:
    while (true) {
      if (_jj_2_1(3)) {
        ;
      } else {
        break label_2;
      }
      _jj_consume_token(ELParserConstants.QUESTIONMARK);
      Choice();
      _jj_consume_token(ELParserConstants.COLON);
      AstChoice jjtn001 = new AstChoice(ELParserTreeConstants.JJTCHOICE);
      bool jjtc001 = true;
      jj_save_.openNodeScope(jjtn001);
      try {
        Choice();
      } on Exception catch (jjte001) {
        if (jjtc001) {
          jj_save_.clearNodeScope(jjtn001);
          jjtc001 = false;
        } else {
          jj_save_.popNode();
        }
        throw jjte001;
      } finally {
        if (jjtc001) {
          jj_save_.closeNodeScope(jjtn001,  3);
        }
      }
    }
  }

/*
 * Or
 * For 'or' '||', then And
 */
  void Or() {
    And();
    label_3:
    while (true) {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.OR0:
      case ELParserConstants.OR1:
        ;
        break;
      default:
        _jj_la1[2] = _jj_gen;
        break label_3;
      }
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.OR0:
        _jj_consume_token(ELParserConstants.OR0);
        break;
      case ELParserConstants.OR1:
        _jj_consume_token(ELParserConstants.OR1);
        break;
      default:
        _jj_la1[3] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
      AstOr jjtn001 = new AstOr(ELParserTreeConstants.JJTOR);
      bool jjtc001 = true;
      jj_save_.openNodeScope(jjtn001);
      try {
        And();
      } on Exception catch (jjte001) {
        if (jjtc001) {
          jj_save_.clearNodeScope(jjtn001);
          jjtc001 = false;
        } else {
          jj_save_.popNode();
        }
        throw jjte001;
      } finally {
        if (jjtc001) {
          jj_save_.closeNodeScope(jjtn001,  2);
        }
      }
    }
  }

/*
 * And
 * For 'and' '&&', then Equality
 */
  void And() {
    Equality();
    label_4:
    while (true) {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.AND0:
      case ELParserConstants.AND1:
        ;
        break;
      default:
        _jj_la1[4] = _jj_gen;
        break label_4;
      }
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.AND0:
        _jj_consume_token(ELParserConstants.AND0);
        break;
      case ELParserConstants.AND1:
        _jj_consume_token(ELParserConstants.AND1);
        break;
      default:
        _jj_la1[5] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
      AstAnd jjtn001 = new AstAnd(ELParserTreeConstants.JJTAND);
      bool jjtc001 = true;
      jj_save_.openNodeScope(jjtn001);
      try {
        Equality();
      } on Exception catch (jjte001) {
        if (jjtc001) {
          jj_save_.clearNodeScope(jjtn001);
          jjtc001 = false;
        } else {
          jj_save_.popNode();
        }
        throw jjte001;
      } finally {
        if (jjtc001) {
          jj_save_.closeNodeScope(jjtn001,  2);
        }
      }
    }
  }

/*
 * Equality
 * For '==' 'eq' '!=' 'ne', then Compare
 */
  void Equality() {
    Compare();
    label_5:
    while (true) {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.EQ0:
      case ELParserConstants.EQ1:
      case ELParserConstants.NE0:
      case ELParserConstants.NE1:
        ;
        break;
      default:
        _jj_la1[6] = _jj_gen;
        break label_5;
      }
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.EQ0:
      case ELParserConstants.EQ1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.EQ0:
          _jj_consume_token(ELParserConstants.EQ0);
          break;
        case ELParserConstants.EQ1:
          _jj_consume_token(ELParserConstants.EQ1);
          break;
        default:
          _jj_la1[7] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
        AstEqual jjtn001 = new AstEqual(ELParserTreeConstants.JJTEQUAL);
        bool jjtc001 = true;
        jj_save_.openNodeScope(jjtn001);
        try {
          Compare();
        } on Exception catch (jjte001) {
          if (jjtc001) {
            jj_save_.clearNodeScope(jjtn001);
            jjtc001 = false;
          } else {
            jj_save_.popNode();
          }
          throw jjte001;
        } finally {
          if (jjtc001) {
            jj_save_.closeNodeScope(jjtn001,  2);
          }
        }
        break;
      case ELParserConstants.NE0:
      case ELParserConstants.NE1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.NE0:
          _jj_consume_token(ELParserConstants.NE0);
          break;
        case ELParserConstants.NE1:
          _jj_consume_token(ELParserConstants.NE1);
          break;
        default:
          _jj_la1[8] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
        AstNotEqual jjtn002 = new AstNotEqual(ELParserTreeConstants.JJTNOTEQUAL);
        bool jjtc002 = true;
        jj_save_.openNodeScope(jjtn002);
        try {
          Compare();
        } on Exception catch (jjte002) {
          if (jjtc002) {
            jj_save_.clearNodeScope(jjtn002);
            jjtc002 = false;
          } else {
            jj_save_.popNode();
          }
          throw jjte002;
        } finally {
          if (jjtc002) {
            jj_save_.closeNodeScope(jjtn002,  2);
          }
        }
        break;
      default:
        _jj_la1[9] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
    }
  }

/*
 * Compare
 * For a bunch of them, then Math
 */
  void Compare() {
    Math();
    label_6:
    while (true) {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.GT0:
      case ELParserConstants.GT1:
      case ELParserConstants.LT0:
      case ELParserConstants.LT1:
      case ELParserConstants.GE0:
      case ELParserConstants.GE1:
      case ELParserConstants.LE0:
      case ELParserConstants.LE1:
        ;
        break;
      default:
        _jj_la1[10] = _jj_gen;
        break label_6;
      }
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.LT0:
      case ELParserConstants.LT1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.LT0:
          _jj_consume_token(ELParserConstants.LT0);
          break;
        case ELParserConstants.LT1:
          _jj_consume_token(ELParserConstants.LT1);
          break;
        default:
          _jj_la1[11] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
                         AstLessThan jjtn001 = new AstLessThan(ELParserTreeConstants.JJTLESSTHAN);
                         bool jjtc001 = true;
                         jj_save_.openNodeScope(jjtn001);
        try {
          Math();
        } on Exception catch (jjte001) {
                         if (jjtc001) {
                           jj_save_.clearNodeScope(jjtn001);
                           jjtc001 = false;
                         } else {
                           jj_save_.popNode();
                         }
                           throw jjte001;
        } finally {
                         if (jjtc001) {
                           jj_save_.closeNodeScope(jjtn001,  2);
                         }
        }
        break;
      case ELParserConstants.GT0:
      case ELParserConstants.GT1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.GT0:
          _jj_consume_token(ELParserConstants.GT0);
          break;
        case ELParserConstants.GT1:
          _jj_consume_token(ELParserConstants.GT1);
          break;
        default:
          _jj_la1[12] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
                         AstGreaterThan jjtn002 = new AstGreaterThan(ELParserTreeConstants.JJTGREATERTHAN);
                         bool jjtc002 = true;
                         jj_save_.openNodeScope(jjtn002);
        try {
          Math();
        } on Exception catch (jjte002) {
                         if (jjtc002) {
                           jj_save_.clearNodeScope(jjtn002);
                           jjtc002 = false;
                         } else {
                           jj_save_.popNode();
                         }
                           throw jjte002;
        } finally {
                         if (jjtc002) {
                           jj_save_.closeNodeScope(jjtn002,  2);
                         }
        }
        break;
      case ELParserConstants.LE0:
      case ELParserConstants.LE1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.LE0:
          _jj_consume_token(ELParserConstants.LE0);
          break;
        case ELParserConstants.LE1:
          _jj_consume_token(ELParserConstants.LE1);
          break;
        default:
          _jj_la1[13] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
                         AstLessThanEqual jjtn003 = new AstLessThanEqual(ELParserTreeConstants.JJTLESSTHANEQUAL);
                         bool jjtc003 = true;
                         jj_save_.openNodeScope(jjtn003);
        try {
          Math();
        } on Exception catch (jjte003) {
                         if (jjtc003) {
                           jj_save_.clearNodeScope(jjtn003);
                           jjtc003 = false;
                         } else {
                           jj_save_.popNode();
                         }
                         throw jjte003;
        } finally {
                         if (jjtc003) {
                           jj_save_.closeNodeScope(jjtn003,  2);
                         }
        }
        break;
      case ELParserConstants.GE0:
      case ELParserConstants.GE1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.GE0:
          _jj_consume_token(ELParserConstants.GE0);
          break;
        case ELParserConstants.GE1:
          _jj_consume_token(ELParserConstants.GE1);
          break;
        default:
          _jj_la1[14] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
                         AstGreaterThanEqual jjtn004 = new AstGreaterThanEqual(ELParserTreeConstants.JJTGREATERTHANEQUAL);
                         bool jjtc004 = true;
                         jj_save_.openNodeScope(jjtn004);
        try {
          Math();
        } on Exception catch (jjte004) {
                         if (jjtc004) {
                           jj_save_.clearNodeScope(jjtn004);
                           jjtc004 = false;
                         } else {
                           jj_save_.popNode();
                         }
                         throw jjte004;
        } finally {
                         if (jjtc004) {
                           jj_save_.closeNodeScope(jjtn004,  2);
                         }
        }
        break;
      default:
        _jj_la1[15] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
    }
  }

/*
 * Math
 * For '+' '-', then Multiplication
 */
  void Math() {
    Multiplication();
    label_7:
    while (true) {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.PLUS:
      case ELParserConstants.MINUS:
        ;
        break;
      default:
        _jj_la1[16] = _jj_gen;
        break label_7;
      }
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.PLUS:
        _jj_consume_token(ELParserConstants.PLUS);
                  AstPlus jjtn001 = new AstPlus(ELParserTreeConstants.JJTPLUS);
                  bool jjtc001 = true;
                  jj_save_.openNodeScope(jjtn001);
        try {
          Multiplication();
        } on Exception catch (jjte001) {
                  if (jjtc001) {
                    jj_save_.clearNodeScope(jjtn001);
                    jjtc001 = false;
                  } else {
                    jj_save_.popNode();
                  }
                  throw jjte001;
        } finally {
                  if (jjtc001) {
                    jj_save_.closeNodeScope(jjtn001,  2);
                  }
        }
        break;
      case ELParserConstants.MINUS:
        _jj_consume_token(ELParserConstants.MINUS);
                   AstMinus jjtn002 = new AstMinus(ELParserTreeConstants.JJTMINUS);
                   bool jjtc002 = true;
                   jj_save_.openNodeScope(jjtn002);
        try {
          Multiplication();
        } on Exception catch (jjte002) {
                   if (jjtc002) {
                     jj_save_.clearNodeScope(jjtn002);
                     jjtc002 = false;
                   } else {
                     jj_save_.popNode();
                   }
                   throw jjte002;
        } finally {
                   if (jjtc002) {
                     jj_save_.closeNodeScope(jjtn002,  2);
                   }
        }
        break;
      default:
        _jj_la1[17] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
    }
  }

/*
 * Multiplication
 * For a bunch of them, then Unary
 */
  void Multiplication() {
    Unary();
    label_8:
    while (true) {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.MULT:
      case ELParserConstants.DIV0:
      case ELParserConstants.DIV1:
      case ELParserConstants.MOD0:
      case ELParserConstants.MOD1:
        ;
        break;
      default:
        _jj_la1[18] = _jj_gen;
        break label_8;
      }
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.MULT:
        _jj_consume_token(ELParserConstants.MULT);
                  AstMult jjtn001 = new AstMult(ELParserTreeConstants.JJTMULT);
                  bool jjtc001 = true;
                  jj_save_.openNodeScope(jjtn001);
        try {
          Unary();
        } on Exception catch (jjte001) {
                  if (jjtc001) {
                    jj_save_.clearNodeScope(jjtn001);
                    jjtc001 = false;
                  } else {
                    jj_save_.popNode();
                  }
                  throw jjte001;
        } finally {
                  if (jjtc001) {
                    jj_save_.closeNodeScope(jjtn001,  2);
                  }
        }
        break;
      case ELParserConstants.DIV0:
      case ELParserConstants.DIV1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.DIV0:
          _jj_consume_token(ELParserConstants.DIV0);
          break;
        case ELParserConstants.DIV1:
          _jj_consume_token(ELParserConstants.DIV1);
          break;
        default:
          _jj_la1[19] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
                           AstDiv jjtn002 = new AstDiv(ELParserTreeConstants.JJTDIV);
                           bool jjtc002 = true;
                           jj_save_.openNodeScope(jjtn002);
        try {
          Unary();
        } on Exception catch (jjte002) {
                           if (jjtc002) {
                             jj_save_.clearNodeScope(jjtn002);
                             jjtc002 = false;
                           } else {
                             jj_save_.popNode();
                           }
                            throw jjte002;
        } finally {
                           if (jjtc002) {
                             jj_save_.closeNodeScope(jjtn002,  2);
                           }
        }
        break;
      case ELParserConstants.MOD0:
      case ELParserConstants.MOD1:
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.MOD0:
          _jj_consume_token(ELParserConstants.MOD0);
          break;
        case ELParserConstants.MOD1:
          _jj_consume_token(ELParserConstants.MOD1);
          break;
        default:
          _jj_la1[20] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
                           AstMod jjtn003 = new AstMod(ELParserTreeConstants.JJTMOD);
                           bool jjtc003 = true;
                           jj_save_.openNodeScope(jjtn003);
        try {
          Unary();
        } on Exception catch (jjte003) {
                           if (jjtc003) {
                             jj_save_.clearNodeScope(jjtn003);
                             jjtc003 = false;
                           } else {
                             jj_save_.popNode();
                           }
                           throw jjte003;
        } finally {
                           if (jjtc003) {
                             jj_save_.closeNodeScope(jjtn003,  2);
                           }
        }
        break;
      default:
        _jj_la1[21] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
    }
  }

/*
 * Unary
 * For '-' '!' 'not' 'empty', then Value
 */
  void Unary() {
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.MINUS:
      _jj_consume_token(ELParserConstants.MINUS);
                  AstNegative jjtn001 = new AstNegative(ELParserTreeConstants.JJTNEGATIVE);
                  bool jjtc001 = true;
                  jj_save_.openNodeScope(jjtn001);
      try {
        Unary();
      } on Exception catch (jjte001) {
                  if (jjtc001) {
                    jj_save_.clearNodeScope(jjtn001);
                    jjtc001 = false;
                  } else {
                    jj_save_.popNode();
                  }
                  throw jjte001;
      } finally {
                  if (jjtc001) {
                    jj_save_.closeNodeScopeByCondition(jjtn001, true);
                  }
      }
      break;
    case ELParserConstants.NOT0:
    case ELParserConstants.NOT1:
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.NOT0:
        _jj_consume_token(ELParserConstants.NOT0);
        break;
      case ELParserConstants.NOT1:
        _jj_consume_token(ELParserConstants.NOT1);
        break;
      default:
        _jj_la1[22] = _jj_gen;
        _jj_consume_token(-1);
        throw new ParseException();
      }
                          AstNot jjtn002 = new AstNot(ELParserTreeConstants.JJTNOT);
                          bool jjtc002 = true;
                          jj_save_.openNodeScope(jjtn002);
      try {
        Unary();
      } on Exception catch (jjte002) {
                          if (jjtc002) {
                            jj_save_.clearNodeScope(jjtn002);
                            jjtc002 = false;
                          } else {
                            jj_save_.popNode();
                          }
                          throw jjte002;
      } finally {
                          if (jjtc002) {
                            jj_save_.closeNodeScopeByCondition(jjtn002, true);
                          }
      }
      break;
    case ELParserConstants.EMPTY:
      _jj_consume_token(ELParserConstants.EMPTY);
                  AstEmpty jjtn003 = new AstEmpty(ELParserTreeConstants.JJTEMPTY);
                  bool jjtc003 = true;
                  jj_save_.openNodeScope(jjtn003);
      try {
        Unary();
      } on Exception catch (jjte003) {
                  if (jjtc003) {
                    jj_save_.clearNodeScope(jjtn003);
                    jjtc003 = false;
                  } else {
                    jj_save_.popNode();
                  }
                  throw jjte003;
      } finally {
                  if (jjtc003) {
                    jj_save_.closeNodeScopeByCondition(jjtn003, true);
                  }
      }
      break;
    case ELParserConstants.INTEGER_LITERAL:
    case ELParserConstants.FLOATING_POINT_LITERAL:
    case ELParserConstants.STRING_LITERAL:
    case ELParserConstants.TRUE:
    case ELParserConstants.FALSE:
    case ELParserConstants.NULL:
    case ELParserConstants.LPAREN:
    case ELParserConstants.IDENTIFIER:
    case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
    case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
      Value();
      break;
    default:
      _jj_la1[23] = _jj_gen;
      _jj_consume_token(-1);
      throw new ParseException();
    }
  }

/*
 * Value
 * Defines Prefix plus zero or more Suffixes
 */
  void Value() {
      AstValue jjtn001 = new AstValue(ELParserTreeConstants.JJTVALUE);
      bool jjtc001 = true;
      jj_save_.openNodeScope(jjtn001);
    try {
      ValuePrefix();
      label_9:
      while (true) {
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.DOT:
        case ELParserConstants.LBRACK:
          ;
          break;
        default:
          _jj_la1[24] = _jj_gen;
          break label_9;
        }
        ValueSuffix();
      }
    } on Exception catch (jjte001) {
      if (jjtc001) {
        jj_save_.clearNodeScope(jjtn001);
        jjtc001 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte001;
    } finally {
      if (jjtc001) {
        jj_save_.closeNodeScopeByCondition(jjtn001, jj_save_.nodeArity() > 1);
      }
    }
  }

/*
 * ValuePrefix
 * For Literals, Variables, and Functions
 */
  void ValuePrefix() {
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.INTEGER_LITERAL:
    case ELParserConstants.FLOATING_POINT_LITERAL:
    case ELParserConstants.STRING_LITERAL:
    case ELParserConstants.TRUE:
    case ELParserConstants.FALSE:
    case ELParserConstants.NULL:
      Literal();
      break;
    case ELParserConstants.LPAREN:
    case ELParserConstants.IDENTIFIER:
    case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
    case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
      NonLiteral();
      break;
    default:
      _jj_la1[25] = _jj_gen;
      _jj_consume_token(-1);
      throw new ParseException();
    }
  }

/*
 * ValueSuffix
 * Either dot or bracket notation
 */
  void ValueSuffix() {
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.DOT:
      DotSuffix();
      break;
    case ELParserConstants.LBRACK:
      BracketSuffix();
      break;
    default:
      _jj_la1[26] = _jj_gen;
      _jj_consume_token(-1);
      throw new ParseException();
    }
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.LPAREN:
      MethodParameters();
      break;
    default:
      _jj_la1[27] = _jj_gen;
      ;
    }
  }

/*
 * DotSuffix
 * Dot Property
 */
  void DotSuffix() {
                               /*@bgen(jj_save_) DotSuffix */
                                AstDotSuffix jjtn000 = new AstDotSuffix(ELParserTreeConstants.JJTDOTSUFFIX);
                                bool jjtc000 = true;
                                jj_save_.openNodeScope(jjtn000);Token t = null;
    try {
      _jj_consume_token(ELParserConstants.DOT);
      t = _jj_consume_token(ELParserConstants.IDENTIFIER);
                           jj_save_.closeNodeScopeByCondition(jjtn000, true);
                           jjtc000 = false;
                           jjtn000.setImage(t.image_);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * BracketSuffix
 * Sub Expression Suffix
 */
  void BracketSuffix() {
                                       /*@bgen(jj_save_) BracketSuffix */
  AstBracketSuffix jjtn000 = new AstBracketSuffix(ELParserTreeConstants.JJTBRACKETSUFFIX);
  bool jjtc000 = true;
  jj_save_.openNodeScope(jjtn000);
    try {
      _jj_consume_token(ELParserConstants.LBRACK);
      Expression();
      _jj_consume_token(ELParserConstants.RBRACK);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * MethodParameters
 */
  void MethodParameters() {
                                             /*@bgen(jj_save_) MethodParameters */
  AstMethodParameters jjtn000 = new AstMethodParameters(ELParserTreeConstants.JJTMETHODPARAMETERS);
  bool jjtc000 = true;
  jj_save_.openNodeScope(jjtn000);
    try {
      _jj_consume_token(ELParserConstants.LPAREN);
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.INTEGER_LITERAL:
      case ELParserConstants.FLOATING_POINT_LITERAL:
      case ELParserConstants.STRING_LITERAL:
      case ELParserConstants.TRUE:
      case ELParserConstants.FALSE:
      case ELParserConstants.NULL:
      case ELParserConstants.LPAREN:
      case ELParserConstants.NOT0:
      case ELParserConstants.NOT1:
      case ELParserConstants.EMPTY:
      case ELParserConstants.MINUS:
      case ELParserConstants.IDENTIFIER:
      case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
      case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
        Expression();
        label_10:
        while (true) {
          switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
          case ELParserConstants.COMMA:
            ;
            break;
          default:
            _jj_la1[28] = _jj_gen;
            break label_10;
          }
          _jj_consume_token(ELParserConstants.COMMA);
          Expression();
        }
        break;
      default:
        _jj_la1[29] = _jj_gen;
        ;
      }
      _jj_consume_token(ELParserConstants.RPAREN);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * NonLiteral
 * For Grouped Operations, Identifiers, and Functions
 */
  void NonLiteral() {
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.LPAREN:
      _jj_consume_token(ELParserConstants.LPAREN);
      Expression();
      _jj_consume_token(ELParserConstants.RPAREN);
      break;
    case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
      ELArray();
      break;
    case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
      ELMap();
      break;
    default:
      _jj_la1[30] = _jj_gen;
      if (_jj_2_2(2147483647)) {
        Function();
      } else {
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.IDENTIFIER:
          Identifier();
          break;
        default:
          _jj_la1[31] = _jj_gen;
          _jj_consume_token(-1);
          throw new ParseException();
        }
      }
    }
  }

/*
 * Identifier
 * Java Language Identifier
 */
  void Identifier() {
                                 /*@bgen(jj_save_) Identifier */
                                  AstIdentifier jjtn000 = new AstIdentifier(ELParserTreeConstants.JJTIDENTIFIER);
                                  bool jjtc000 = true;
                                  jj_save_.openNodeScope(jjtn000);Token t = null;
    try {
      t = _jj_consume_token(ELParserConstants.IDENTIFIER);
                     jj_save_.closeNodeScopeByCondition(jjtn000, true);
                     jjtc000 = false;
                     jjtn000.setImage(t.image_);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * Function
 * Namespace:Name(a,b,c)
 */
  void Function() {
 /*@bgen(jj_save_) Function */
    AstFunction jjtn000 = new AstFunction(ELParserTreeConstants.JJTFUNCTION);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);Token t0 = null;
    Token t1 = null;
    try {
      if (_jj_2_3(2)) {
        t0 = _jj_consume_token(ELParserConstants.IDENTIFIER);
        _jj_consume_token(ELParserConstants.COLON);
      } else {
        ;
      }
      t1 = _jj_consume_token(ELParserConstants.IDENTIFIER);
        if (t0 != null) {
            jjtn000.setPrefix(t0.image_);
            jjtn000.setLocalName(t1.image_);
        } else {
            jjtn000.setLocalName(t1.image_);
        }
      _jj_consume_token(ELParserConstants.LPAREN);
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.INTEGER_LITERAL:
      case ELParserConstants.FLOATING_POINT_LITERAL:
      case ELParserConstants.STRING_LITERAL:
      case ELParserConstants.TRUE:
      case ELParserConstants.FALSE:
      case ELParserConstants.NULL:
      case ELParserConstants.LPAREN:
      case ELParserConstants.NOT0:
      case ELParserConstants.NOT1:
      case ELParserConstants.EMPTY:
      case ELParserConstants.MINUS:
      case ELParserConstants.IDENTIFIER:
      case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
      case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
        Expression();
        label_11:
        while (true) {
          switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
          case ELParserConstants.COMMA:
            ;
            break;
          default:
            _jj_la1[32] = _jj_gen;
            break label_11;
          }
          _jj_consume_token(ELParserConstants.COMMA);
          Expression();
        }
        break;
      default:
        _jj_la1[33] = _jj_gen;
        ;
      }
      _jj_consume_token(ELParserConstants.RPAREN);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

  //20120927, henrichen: #issue1, support Array
  /*
   * Array
   * [a,b,c]
   */
  void ELArray() {
    AstArray jjtn000 = new AstArray(ELParserTreeConstants.JJTARRAY);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);Token t0 = null;
    Token t1 = null;
    try {
      _jj_consume_token(ELParserConstants.LBRACK);
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.INTEGER_LITERAL:
      case ELParserConstants.FLOATING_POINT_LITERAL:
      case ELParserConstants.STRING_LITERAL:
      case ELParserConstants.TRUE:
      case ELParserConstants.FALSE:
      case ELParserConstants.NULL:
      case ELParserConstants.LPAREN:
      case ELParserConstants.NOT0:
      case ELParserConstants.NOT1:
      case ELParserConstants.EMPTY:
      case ELParserConstants.MINUS:
      case ELParserConstants.IDENTIFIER:
      case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
      case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
        Expression();
        label_11:
        while (true) {
          switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
          case ELParserConstants.COMMA:
            ;
            break;
          default:
            _jj_la1[32] = _jj_gen;
            break label_11;
          }
          _jj_consume_token(ELParserConstants.COMMA);
          Expression();
        }
        break;
      default:
        _jj_la1[33] = _jj_gen;
        ;
      }
      _jj_consume_token(ELParserConstants.RBRACK);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

  //20120927, henrichen: #issue2, support Map
  /*
   * Map
   * {k1:v1, k2:v2, k3:v3}
   */
  void ELMap() {
    AstMap jjtn000 = new AstMap(ELParserTreeConstants.JJTMAP);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);Token t0 = null;
    Token t1 = null;
    try {
      _jj_consume_token(ELParserConstants.LBRACE);
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.INTEGER_LITERAL:
      case ELParserConstants.FLOATING_POINT_LITERAL:
      case ELParserConstants.STRING_LITERAL:
      case ELParserConstants.TRUE:
      case ELParserConstants.FALSE:
      case ELParserConstants.NULL:
      case ELParserConstants.LPAREN:
      case ELParserConstants.NOT0:
      case ELParserConstants.NOT1:
      case ELParserConstants.EMPTY:
      case ELParserConstants.MINUS:
      case ELParserConstants.IDENTIFIER:
      case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
      case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
        ELMapEntry();
        label_11:
        while (true) {
          switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
          case ELParserConstants.COMMA:
            ;
            break;
          default:
            _jj_la1[32] = _jj_gen;
            break label_11;
          }
          _jj_consume_token(ELParserConstants.COMMA);
          ELMapEntry();
        }
        break;
      default:
        _jj_la1[33] = _jj_gen;
        ;
      }
      _jj_consume_token(ELParserConstants.RBRACE);
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

  //20120927, henrichen: MAPENTRY
  /*
   * MapEntry
   * k1:v1
   */
  void ELMapEntry() {
    AstMapEntry jjtn000 = new AstMapEntry(ELParserTreeConstants.JJTMAPENTRY);
    bool jjtc000 = true;
    jj_save_.openNodeScope(jjtn000);Token t0 = null;
    Token t1 = null;
    try {
      switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
      case ELParserConstants.INTEGER_LITERAL:
      case ELParserConstants.FLOATING_POINT_LITERAL:
      case ELParserConstants.STRING_LITERAL:
      case ELParserConstants.TRUE:
      case ELParserConstants.FALSE:
      case ELParserConstants.NULL:
      case ELParserConstants.LPAREN:
      case ELParserConstants.NOT0:
      case ELParserConstants.NOT1:
      case ELParserConstants.EMPTY:
      case ELParserConstants.MINUS:
      case ELParserConstants.IDENTIFIER:
      case ELParserConstants.LBRACK: //20120927, henrichen: #issue1, support Array
      case ELParserConstants.LBRACE: //20120927, henrichen: #issue2, support Map
        Expression();
        switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
        case ELParserConstants.COLON:
          _jj_consume_token(ELParserConstants.COLON);
          Expression();
          break;
        default:
          _jj_la1[32] = _jj_gen;
          break;
        }
        break;
      default:
        _jj_la1[33] = _jj_gen;
        ;
      }
    } on Exception catch (jjte000) {
      if (jjtc000) {
        jj_save_.clearNodeScope(jjtn000);
        jjtc000 = false;
      } else {
        jj_save_.popNode();
      }
      throw jjte000;
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * Literal
 * Reserved Keywords
 */
  void Literal() {
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.TRUE:
    case ELParserConstants.FALSE:
      Boolean();
      break;
    case ELParserConstants.FLOATING_POINT_LITERAL:
      FloatingPoint();
      break;
    case ELParserConstants.INTEGER_LITERAL:
      Integer();
      break;
    case ELParserConstants.STRING_LITERAL:
      String();
      break;
    case ELParserConstants.NULL:
      Null();
      break;
    default:
      _jj_la1[34] = _jj_gen;
      _jj_consume_token(-1);
      throw new ParseException();
    }
  }

/*
 * Boolean
 * For 'true' 'false'
 */
  void Boolean() {
    switch ((_jj_ntk==-1)?_jj_ntkind():_jj_ntk) {
    case ELParserConstants.TRUE:
      AstTrue jjtn001 = new AstTrue(ELParserTreeConstants.JJTTRUE);
      bool jjtc001 = true;
      jj_save_.openNodeScope(jjtn001);
      try {
        _jj_consume_token(ELParserConstants.TRUE);
      } finally {
      if (jjtc001) {
        jj_save_.closeNodeScopeByCondition(jjtn001, true);
      }
      }
      break;
    case ELParserConstants.FALSE:
        AstFalse jjtn002 = new AstFalse(ELParserTreeConstants.JJTFALSE);
        bool jjtc002 = true;
        jj_save_.openNodeScope(jjtn002);
      try {
        _jj_consume_token(ELParserConstants.FALSE);
      } finally {
        if (jjtc002) {
          jj_save_.closeNodeScopeByCondition(jjtn002, true);
        }
      }
      break;
    default:
      _jj_la1[35] = _jj_gen;
      _jj_consume_token(-1);
      throw new ParseException();
    }
  }

/*
 * FloatinPoint
 * For Decimal and Floating Point Literals
 */
  void FloatingPoint() {
                                       /*@bgen(jj_save_) FloatingPoint */
                                        AstFloatingPoint jjtn000 = new AstFloatingPoint(ELParserTreeConstants.JJTFLOATINGPOINT);
                                        bool jjtc000 = true;
                                        jj_save_.openNodeScope(jjtn000);Token t = null;
    try {
      t = _jj_consume_token(ELParserConstants.FLOATING_POINT_LITERAL);
                                 jj_save_.closeNodeScopeByCondition(jjtn000, true);
                                 jjtc000 = false;
                                 jjtn000.setImage(t.image_);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * Integer
 * For Simple Numeric Literals
 */
  void Integer() {
                           /*@bgen(jj_save_) Integer */
                            AstInteger jjtn000 = new AstInteger(ELParserTreeConstants.JJTINTEGER);
                            bool jjtc000 = true;
                            jj_save_.openNodeScope(jjtn000);Token t = null;
    try {
      t = _jj_consume_token(ELParserConstants.INTEGER_LITERAL);
                          jj_save_.closeNodeScopeByCondition(jjtn000, true);
                          jjtc000 = false;
                          jjtn000.setImage(t.image_);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * String
 * For Quoted Literals
 */
  void String() {
                         /*@bgen(jj_save_) String */
                          AstString jjtn000 = new AstString(ELParserTreeConstants.JJTSTRING);
                          bool jjtc000 = true;
                          jj_save_.openNodeScope(jjtn000);Token t = null;
    try {
      t = _jj_consume_token(ELParserConstants.STRING_LITERAL);
                         jj_save_.closeNodeScopeByCondition(jjtn000, true);
                         jjtc000 = false;
                         jjtn000.setImage(t.image_);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

/*
 * Null
 * For 'null'
 */
  void Null() {
                     /*@bgen(jj_save_) Null */
  AstNull jjtn000 = new AstNull(ELParserTreeConstants.JJTNULL);
  bool jjtc000 = true;
  jj_save_.openNodeScope(jjtn000);
    try {
      _jj_consume_token(ELParserConstants.NULL);
    } finally {
      if (jjtc000) {
        jj_save_.closeNodeScopeByCondition(jjtn000, true);
      }
    }
  }

  bool _jj_2_1(int xla) {
    _jj_la = xla; _jj_lastpos = _jj_scanpos = token;
    try { return !_jj_3_1(); }
    on _LookaheadSuccess catch(ls) { return true; }
    finally { _jj_save(0, xla); }
  }

  bool _jj_2_2(int xla) {
    _jj_la = xla; _jj_lastpos = _jj_scanpos = token;
    try { return !_jj_3_2(); }
    on _LookaheadSuccess catch(ls) { return true; }
    finally { _jj_save(1, xla); }
  }

  bool _jj_2_3(int xla) {
    _jj_la = xla; _jj_lastpos = _jj_scanpos = token;
    try { return !_jj_3_3(); }
    on _LookaheadSuccess catch(ls) { return true; }
    finally { _jj_save(2, xla); }
  }

  bool _jj_3R_13() {
    if (_jj_scan_token(ELParserConstants.IDENTIFIER)) return true;
    if (_jj_scan_token(ELParserConstants.COLON)) return true;
    return false;
  }

  bool _jj_3_2() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_13()) _jj_scanpos = xsp;
    if (_jj_scan_token(ELParserConstants.IDENTIFIER)) return true;
    if (_jj_scan_token(ELParserConstants.LPAREN)) return true;
    return false;
  }

  bool _jj_3R_69() {
    if (_jj_scan_token(ELParserConstants.IDENTIFIER)) return true;
    return false;
  }

  bool _jj_3R_25() {
    if (_jj_3R_31()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_32()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_59() {
    if (_jj_3R_69()) return true;
    return false;
  }

  bool _jj_3R_34() {
    if (_jj_scan_token(ELParserConstants.MINUS)) return true;
    return false;
  }

  bool _jj_3R_58() {
    if (_jj_3R_68()) return true;
    return false;
  }

  bool _jj_3R_26() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_33()) {
    _jj_scanpos = xsp;
    if (_jj_3R_34()) return true;
    }
    return false;
  }

  bool _jj_3R_33() {
    if (_jj_scan_token(ELParserConstants.PLUS)) return true;
    return false;
  }

  bool _jj_3R_57() {
    if (_jj_scan_token(ELParserConstants.LPAREN)) return true;
    if (_jj_3R_67()) return true;
    return false;
  }

  bool _jj_3R_49() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_57()) {
    _jj_scanpos = xsp;
    if (_jj_3R_58()) {
    _jj_scanpos = xsp;
    if (_jj_3R_59()) return true;
    }
    }
    return false;
  }

  bool _jj_3R_66() {
    if (_jj_scan_token(ELParserConstants.NULL)) return true;
    return false;
  }

  bool _jj_3R_21() {
    if (_jj_3R_25()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_26()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_30() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(27)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(28)) return true;
    }
    return false;
  }

  bool _jj_3R_65() {
    if (_jj_scan_token(ELParserConstants.STRING_LITERAL)) return true;
    return false;
  }

  bool _jj_3R_29() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(29)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(30)) return true;
    }
    return false;
  }

  bool _jj_3R_28() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(23)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(24)) return true;
    }
    return false;
  }

  bool _jj_3R_22() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_27()) {
    _jj_scanpos = xsp;
    if (_jj_3R_28()) {
    _jj_scanpos = xsp;
    if (_jj_3R_29()) {
    _jj_scanpos = xsp;
    if (_jj_3R_30()) return true;
    }
    }
    }
    return false;
  }

  bool _jj_3R_27() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(25)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(26)) return true;
    }
    return false;
  }

  bool _jj_3R_61() {
    if (_jj_scan_token(ELParserConstants.LBRACK)) return true;
    return false;
  }

  bool _jj_3R_51() {
    if (_jj_3R_61()) return true;
    return false;
  }

  bool _jj_3R_64() {
    if (_jj_scan_token(ELParserConstants.INTEGER_LITERAL)) return true;
    return false;
  }

  bool _jj_3R_19() {
    if (_jj_3R_21()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_22()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_60() {
    if (_jj_scan_token(ELParserConstants.DOT)) return true;
    return false;
  }

  bool _jj_3R_24() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(33)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(34)) return true;
    }
    return false;
  }

  bool _jj_3R_63() {
    if (_jj_scan_token(ELParserConstants.FLOATING_POINT_LITERAL)) return true;
    return false;
  }

  bool _jj_3R_23() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(31)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(32)) return true;
    }
    return false;
  }

  bool _jj_3R_20() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_23()) {
    _jj_scanpos = xsp;
    if (_jj_3R_24()) return true;
    }
    return false;
  }

  bool _jj_3R_50() {
    if (_jj_3R_60()) return true;
    return false;
  }

  bool _jj_3R_18() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(37)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(38)) return true;
    }
    return false;
  }

  bool _jj_3R_47() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_50()) {
    _jj_scanpos = xsp;
    if (_jj_3R_51()) return true;
    }
    return false;
  }

  bool _jj_3R_71() {
    if (_jj_scan_token(ELParserConstants.FALSE)) return true;
    return false;
  }

  bool _jj_3R_17() {
    if (_jj_3R_19()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_20()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_44() {
    if (_jj_3R_47()) return true;
    return false;
  }

  bool _jj_3R_70() {
    if (_jj_scan_token(ELParserConstants.TRUE)) return true;
    return false;
  }

  bool _jj_3R_62() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_70()) {
    _jj_scanpos = xsp;
    if (_jj_3R_71()) return true;
    }
    return false;
  }

  bool _jj_3R_46() {
    if (_jj_3R_49()) return true;
    return false;
  }

  bool _jj_3R_45() {
    if (_jj_3R_48()) return true;
    return false;
  }

  bool _jj_3R_15() {
    if (_jj_3R_17()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_18()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_43() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_45()) {
    _jj_scanpos = xsp;
    if (_jj_3R_46()) return true;
    }
    return false;
  }

  bool _jj_3R_56() {
    if (_jj_3R_66()) return true;
    return false;
  }

  bool _jj_3R_16() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(39)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(40)) return true;
    }
    return false;
  }

  bool _jj_3R_55() {
    if (_jj_3R_65()) return true;
    return false;
  }

  bool _jj_3R_54() {
    if (_jj_3R_64()) return true;
    return false;
  }

  bool _jj_3R_53() {
    if (_jj_3R_63()) return true;
    return false;
  }

  bool _jj_3R_52() {
    if (_jj_3R_62()) return true;
    return false;
  }

  bool _jj_3R_48() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_52()) {
    _jj_scanpos = xsp;
    if (_jj_3R_53()) {
    _jj_scanpos = xsp;
    if (_jj_3R_54()) {
    _jj_scanpos = xsp;
    if (_jj_3R_55()) {
    _jj_scanpos = xsp;
    if (_jj_3R_56()) return true;
    }
    }
    }
    }
    return false;
  }

  bool _jj_3R_14() {
    if (_jj_3R_15()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_16()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_42() {
    if (_jj_3R_43()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3R_44()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3_1() {
    if (_jj_scan_token(ELParserConstants.QUESTIONMARK)) return true;
    if (_jj_3R_12()) return true;
    if (_jj_scan_token(ELParserConstants.COLON)) return true;
    return false;
  }

  bool _jj_3R_38() {
    if (_jj_3R_42()) return true;
    return false;
  }

  bool _jj_3R_37() {
    if (_jj_scan_token(ELParserConstants.EMPTY)) return true;
    if (_jj_3R_31()) return true;
    return false;
  }

  bool _jj_3R_12() {
    if (_jj_3R_14()) return true;
    Token xsp;
    while (true) {
      xsp = _jj_scanpos;
      if (_jj_3_1()) { _jj_scanpos = xsp; break; }
    }
    return false;
  }

  bool _jj_3R_36() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(35)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(36)) return true;
    }
    if (_jj_3R_31()) return true;
    return false;
  }

  bool _jj_3R_31() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_35()) {
    _jj_scanpos = xsp;
    if (_jj_3R_36()) {
    _jj_scanpos = xsp;
    if (_jj_3R_37()) {
    _jj_scanpos = xsp;
    if (_jj_3R_38()) return true;
    }
    }
    }
    return false;
  }

  bool _jj_3R_35() {
    if (_jj_scan_token(ELParserConstants.MINUS)) return true;
    if (_jj_3R_31()) return true;
    return false;
  }

  bool _jj_3_3() {
    if (_jj_scan_token(ELParserConstants.IDENTIFIER)) return true;
    if (_jj_scan_token(ELParserConstants.COLON)) return true;
    return false;
  }

  bool _jj_3R_68() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3_3()) _jj_scanpos = xsp;
    if (_jj_scan_token(ELParserConstants.IDENTIFIER)) return true;
    if (_jj_scan_token(ELParserConstants.LPAREN)) return true;
    return false;
  }

  bool _jj_3R_67() {
    if (_jj_3R_12()) return true;
    return false;
  }

  bool _jj_3R_41() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(49)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(50)) return true;
    }
    return false;
  }

  bool _jj_3R_40() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_scan_token(47)) {
    _jj_scanpos = xsp;
    if (_jj_scan_token(48)) return true;
    }
    return false;
  }

  bool _jj_3R_32() {
    Token xsp;
    xsp = _jj_scanpos;
    if (_jj_3R_39()) {
    _jj_scanpos = xsp;
    if (_jj_3R_40()) {
    _jj_scanpos = xsp;
    if (_jj_3R_41()) return true;
    }
    }
    return false;
  }

  bool _jj_3R_39() {
    if (_jj_scan_token(ELParserConstants.MULT)) return true;
    return false;
  }

  /** Generated Token Manager. */
  ELParserTokenManager token_source;
  SimpleCharStream jj_input_stream_;
  /** Current token. */
  Token token;
  /** Next token. */
  Token jj_nt;
  int _jj_ntk = 0;
  Token _jj_scanpos, _jj_lastpos;
  int _jj_la = 0;
  int _jj_gen = 0;
  List<int> _jj_la1 = _newIntList(36);
  static List<int> _jj_la1_0 = const [0xe,0xe,0x0,0x0,0x0,0x0,0x80000000,0x80000000,0x0,0x80000000,0x7f800000,0x6000000,0x1800000,0x60000000,0x18000000,0x7f800000,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x27b00,0x90000,0x27b00,0x90000,0x20000,0x400000,0x27b00,0x20000,0x0,0x400000,0x27b00,0x7b00,0x3000,];
  static List<int> _jj_la1_1 = const [0x0,0x0,0x180,0x180,0x60,0x60,0x7,0x1,0x6,0x7,0x0,0x0,0x0,0x0,0x0,0x0,0x3000,0x3000,0x78800,0x18000,0x60000,0x78800,0x18,0x82218,0x0,0x80000,0x0,0x0,0x0,0x82218,0x0,0x80000,0x0,0x82218,0x0,0x0,];
//   static {
//      _jj_la1_init_0();
//      _jj_la1_init_1();
//   }
//   static void _jj_la1_init_0() {
//      _jj_la1_0 = new int[] {0xe,0xe,0x0,0x0,0x0,0x0,0x80000000,0x80000000,0x0,0x80000000,0x7f800000,0x6000000,0x1800000,0x60000000,0x18000000,0x7f800000,0x0,0x0,0x0,0x0,0x0,0x0,0x0,0x27b00,0x90000,0x27b00,0x90000,0x20000,0x400000,0x27b00,0x20000,0x0,0x400000,0x27b00,0x7b00,0x3000,};
//   }
//   static void _jj_la1_init_1() {
//      _jj_la1_1 = new int[] {0x0,0x0,0x180,0x180,0x60,0x60,0x7,0x1,0x6,0x7,0x0,0x0,0x0,0x0,0x0,0x0,0x3000,0x3000,0x78800,0x18000,0x60000,0x78800,0x18,0x82218,0x0,0x80000,0x0,0x0,0x0,0x82218,0x0,0x80000,0x0,0x82218,0x0,0x0,};
//   }
  final List<JJCalls> _jj_2_rtns = new List(3);
  bool _jj_rescan = false;
  int _jj_gc = 0;

  /** Constructor with InputStream and supplied encoding */
//TODO(henri) : InputStream is not supported yet
//  ELParser.fromInputStream(java.io.InputStream stream, [String encoding]) {
//    try { jj_input_stream_ = new SimpleCharStream(stream, encoding, 1, 1); } on UnsupportedEncodingException catch(e) { throw new RuntimeException(e); }
//    token_source = new ELParserTokenManager(jj_input_stream_);
//    token = new Token();
//    _jj_ntk = -1;
//    _jj_gen = 0;
//    for (int i = 0; i < 36; i++) _jj_la1[i] = -1;
//    for (int i = 0; i < _jj_2_rtns.length; i++) _jj_2_rtns[i] = new JJCalls();
//  }

  /** Reinitialise. */
//TODO(henri) : InputStream is not supported yet
//  void ReInitFromInputStream(java.io.InputStream stream, [String encoding]) {
//    try { jj_input_stream_.ReInitFromInputStream(stream, encoding, 1, 1); } on UnsupportedEncodingException catch(e) { throw new RuntimeException(e); }
//    token_source.ReInit(jj_input_stream_);
//    token = new Token();
//    _jj_ntk = -1;
//    jj_save_.reset();
//    _jj_gen = 0;
//    for (int i = 0; i < 36; i++) _jj_la1[i] = -1;
//    for (int i = 0; i < _jj_2_rtns.length; i++) _jj_2_rtns[i] = new JJCalls();
//  }

  /** Constructor. */
  ELParser(Reader stream) {
    jj_input_stream_ = new SimpleCharStream(stream, 1, 1);
    token_source = new ELParserTokenManager(jj_input_stream_);
    token = new Token();
    _jj_ntk = -1;
    _jj_gen = 0;
    for (int i = 0; i < 36; i++) _jj_la1[i] = -1;
    for (int i = 0; i < _jj_2_rtns.length; i++) _jj_2_rtns[i] = new JJCalls();
  }

  /** Reinitialise. */
  void ReInit(Reader stream) {
    jj_input_stream_.ReInit(stream, 1, 1);
    token_source.ReInit(jj_input_stream_);
    token = new Token();
    _jj_ntk = -1;
    jj_save_.reset();
    _jj_gen = 0;
    for (int i = 0; i < 36; i++) _jj_la1[i] = -1;
    for (int i = 0; i < _jj_2_rtns.length; i++) _jj_2_rtns[i] = new JJCalls();
  }

  /** Constructor with generated Token Manager. */
  ELParser.fromTokenManager(ELParserTokenManager tm) {
    token_source = tm;
    token = new Token();
    _jj_ntk = -1;
    _jj_gen = 0;
    for (int i = 0; i < 36; i++) _jj_la1[i] = -1;
    for (int i = 0; i < _jj_2_rtns.length; i++) _jj_2_rtns[i] = new JJCalls();
  }

  /** Reinitialise. */
  void ReInitFromTokenManager(ELParserTokenManager tm) {
    token_source = tm;
    token = new Token();
    _jj_ntk = -1;
    jj_save_.reset();
    _jj_gen = 0;
    for (int i = 0; i < 36; i++) _jj_la1[i] = -1;
    for (int i = 0; i < _jj_2_rtns.length; i++) _jj_2_rtns[i] = new JJCalls();
  }

  Token _jj_consume_token(int kind) {
    Token oldToken;
    if ((oldToken = token).next_ != null) token = token.next_;
    else token = token.next_ = token_source.getNextToken();
    _jj_ntk = -1;
    if (token.kind_ == kind) {
      _jj_gen++;
      if (++_jj_gc > 100) {
        _jj_gc = 0;
        for (int i = 0; i < _jj_2_rtns.length; i++) {
          JJCalls c = _jj_2_rtns[i];
          while (c != null) {
            if (c.gen_ < _jj_gen) c.first_ = null;
            c = c.next_;
          }
        }
      }
      return token;
    }
    token = oldToken;
    _jj_kind = kind;
    throw generateParseException();
  }

  final _LookaheadSuccess _jj_ls = new _LookaheadSuccess();
  bool _jj_scan_token(int kind) {
    if (_jj_scanpos == _jj_lastpos) {
      _jj_la--;
      if (_jj_scanpos.next_ == null) {
        _jj_lastpos = _jj_scanpos = _jj_scanpos.next_ = token_source.getNextToken();
      } else {
        _jj_lastpos = _jj_scanpos = _jj_scanpos.next_;
      }
    } else {
      _jj_scanpos = _jj_scanpos.next_;
    }
    if (_jj_rescan) {
      int i = 0; Token tok = token;
      while (tok != null && tok != _jj_scanpos) { i++; tok = tok.next_; }
      if (tok != null) _jj_add_error_token(kind, i);
    }
    if (_jj_scanpos.kind_ != kind) return true;
    if (_jj_la == 0 && _jj_scanpos == _jj_lastpos) throw _jj_ls;
    return false;
  }


/** Get the next Token. */
  Token getNextToken() {
    if (token.next_ != null) token = token.next_;
    else token = token.next_ = token_source.getNextToken();
    _jj_ntk = -1;
    _jj_gen++;
    return token;
  }

/** Get the specific Token. */
  Token getToken(int index) {
    Token t = token;
    for (int i = 0; i < index; i++) {
      if (t.next_ != null) t = t.next_;
      else t = t.next_ = token_source.getNextToken();
    }
    return t;
  }

  int _jj_ntkind() {
    if ((jj_nt=token.next_) == null)
      return (_jj_ntk = (token.next_=token_source.getNextToken()).kind_);
    else
      return (_jj_ntk = jj_nt.kind_);
  }

  List<List<int>> _jj_expentries = new List();
  List<int> _jj_expentry;
  int _jj_kind = -1;
  List<int> _jj_lasttokens = _newIntList(100);
  int _jj_endpos = 0;

  void _jj_add_error_token(int kind, int pos) {
    if (pos >= 100) return;
    if (pos == _jj_endpos + 1) {
      _jj_lasttokens[_jj_endpos++] = kind;
    } else if (_jj_endpos != 0) {
      _jj_expentry = _newIntList(_jj_endpos);
      for (int i = 0; i < _jj_endpos; i++) {
        _jj_expentry[i] = _jj_lasttokens[i];
      }

      jj_entries_loop: for (List<int> oldentry in _jj_expentries) {
        if (oldentry.length == _jj_expentry.length) {
          for (int i = 0; i < _jj_expentry.length; i++) {
            if (oldentry[i] != _jj_expentry[i]) {
              continue jj_entries_loop;
            }
          }
          _jj_expentries.add(_jj_expentry);
          break jj_entries_loop;
        }
      }

      if (pos != 0) _jj_lasttokens[(_jj_endpos = pos) - 1] = kind;
    }
  }

  /** Generate ParseException. */
  ParseException generateParseException() {
    _jj_expentries.clear();
    List<bool> la1tokens = _newBoolList(57);

    if (_jj_kind >= 0) {
      la1tokens[_jj_kind] = true;
      _jj_kind = -1;
    }
    for (int i = 0; i < 36; i++) {
      if (_jj_la1[i] == _jj_gen) {
        for (int j = 0; j < 32; j++) {
          if ((_jj_la1_0[i] & (1<<j)) != 0) {
            la1tokens[j] = true;
          }
          if ((_jj_la1_1[i] & (1<<j)) != 0) {
            la1tokens[32+j] = true;
          }
        }
      }
    }
    for (int i = 0; i < 57; i++) {
      if (la1tokens[i]) {
        _jj_expentry = new List(1);
        _jj_expentry[0] = i;
        _jj_expentries.add(_jj_expentry);
      }
    }
    _jj_endpos = 0;
    _jj_rescan_token();
    _jj_add_error_token(0, 0);
    List<List<int>> exptokseq = new List(_jj_expentries.length);
    for (int i = 0; i < _jj_expentries.length; i++) {
      exptokseq[i] = _jj_expentries[i];
    }
    return new ParseException.fromToken(token, exptokseq, ELParserConstants.tokenImage);
  }

  /** Enable tracing. */
  void enable_tracing() {
  }

  /** Disable tracing. */
  void disable_tracing() {
  }

  void _jj_rescan_token() {
    _jj_rescan = true;
    for (int i = 0; i < 3; i++) {
    try {
      JJCalls p = _jj_2_rtns[i];
      do {
        if (p.gen_ > _jj_gen) {
          _jj_la = p.arg_; _jj_lastpos = _jj_scanpos = p.first_;
          switch (i) {
            case 0: _jj_3_1(); break;
            case 1: _jj_3_2(); break;
            case 2: _jj_3_3(); break;
          }
        }
        p = p.next_;
      } while (p != null);
      } on _LookaheadSuccess catch(ls) { }
    }
    _jj_rescan = false;
  }

  void _jj_save(int index, int xla) {
    JJCalls p = _jj_2_rtns[index];
    while (p.gen_ > _jj_gen) {
      if (p.next_ == null) { p = p.next_ = new JJCalls(); break; }
      p = p.next_;
    }
    p.gen_ = _jj_gen + xla - _jj_la; p.first_ = token; p.arg_ = xla;
  }
}

class JJCalls {
  int gen_ = 0;
  Token first_;
  int arg_ = 0;
  JJCalls next_;
}

class _LookaheadSuccess implements Exception {
  final message;
  _LookaheadSuccess([this.message]);
  String toString() => (message == null) ? "Exception:" : "Exception: $message";
}

//20120920, henrichen: new and initialize.
//------
//new a List<bool> and initialize all item to false.
List<bool> _newBoolList(int size) {
  List<bool> list = new List(size);
  //henrichen: initial list to all false
  for (int j = 0; j < size; ++j)
    list[j] = false;

  return list;
}

//new a List<int> and initialize all item to 0.
List<int> _newIntList(int size) {
  List<int> list = new List(size);
  //henrichen: initial list to all 0
  for (int j = 0; j < size; ++j)
    list[j] = 0;

  return list;
}
