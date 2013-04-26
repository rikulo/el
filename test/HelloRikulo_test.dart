//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 26, 2012  11:13:24 AM
// Author: hernichen
library test_hello_rikulo;

import 'dart:mirrors';
import 'package:rikulo_el/el.dart';
import 'package:rikulo_el/elimpl.dart';

class Person {
  static Person xyz = new Person('xyz');

  String name;
  Person(this.name);
}

Person person = new Person('Rikulo');

aaa() => person;

void main() {
  //Prepare an expression factory.
  ExpressionFactory ef = new ExpressionFactory();

  //Prepare the expression script
  String script = 'Hello, #{aaa().name}!'; //script inside #{...} is to be evaluated

  //Prepare an expression context.
  ELContext ctx = new ELContext();

  //Parse the script and create a value expression which expect a String type
  ValueExpression ve = ef.createValueExpression(ctx, script, reflect('').type);

  //Evaluate the expression and return the evaluated result
  print(ve.getValue(ctx)); //'Hello, Rikulo!'
}
