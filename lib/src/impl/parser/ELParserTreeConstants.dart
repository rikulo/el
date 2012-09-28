//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Mon, Sep 17, 2012  03:54:11 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ELParserTreeConstants
{
  static const int JJTCOMPOSITEEXPRESSION = 0;
  static const int JJTLITERALEXPRESSION = 1;
  static const int JJTDEFERREDEXPRESSION = 2;
  static const int JJTDYNAMICEXPRESSION = 3;
  static const int JJTVOID = 4;
  static const int JJTCHOICE = 5;
  static const int JJTOR = 6;
  static const int JJTAND = 7;
  static const int JJTEQUAL = 8;
  static const int JJTNOTEQUAL = 9;
  static const int JJTLESSTHAN = 10;
  static const int JJTGREATERTHAN = 11;
  static const int JJTLESSTHANEQUAL = 12;
  static const int JJTGREATERTHANEQUAL = 13;
  static const int JJTPLUS = 14;
  static const int JJTMINUS = 15;
  static const int JJTMULT = 16;
  static const int JJTDIV = 17;
  static const int JJTMOD = 18;
  static const int JJTNEGATIVE = 19;
  static const int JJTNOT = 20;
  static const int JJTEMPTY = 21;
  static const int JJTVALUE = 22;
  static const int JJTDOTSUFFIX = 23;
  static const int JJTBRACKETSUFFIX = 24;
  static const int JJTMETHODPARAMETERS = 25;
  static const int JJTIDENTIFIER = 26;
  static const int JJTFUNCTION = 27;
  static const int JJTTRUE = 28;
  static const int JJTFALSE = 29;
  static const int JJTFLOATINGPOINT = 30;
  static const int JJTINTEGER = 31;
  static const int JJTSTRING = 32;
  static const int JJTNULL = 33;

  //20120927, henrichen: #issue1, support Array [a1,a2,a3,...]
  static const int JJTARRAY = 34;
  //20120927, henrichen: #issue1, support Map {k1:v1, k2:v2, ...}
  static const int JJTMAP = 35;
  static const int JJTMAPENTRY = 36;

  static const List<String> jjtNodeName = const [
    "CompositeExpression",
    "LiteralExpression",
    "DeferredExpression",
    "DynamicExpression",
    "void",
    "Choice",
    "Or",
    "And",
    "Equal",
    "NotEqual",
    "LessThan",
    "GreaterThan",
    "LessThanEqual",
    "GreaterThanEqual",
    "Plus",
    "Minus",
    "Mult",
    "Div",
    "Mod",
    "Negative",
    "Not",
    "Empty",
    "Value",
    "DotSuffix",
    "BracketSuffix",
    "MethodParameters",
    "Identifier",
    "Function",
    "True",
    "False",
    "FloatingPoint",
    "Integer",
    "String",
    "Null",
    "Array",
    "Map",
    "MapEntry"
  ];
}
/* JavaCC - OriginalChecksum=437008e736f149e8fa6712fb36d831a1 (do not edit this line) */
