//Examples used in the tutorial blog

import 'dart:mirrors' show reflect;
import 'package:rikulo_el/el.dart';

class Person {
  String name;
  Person(this.name);
}

void main() {
  //Prepare an expression factory.
  ExpressionFactory ef = new ExpressionFactory();

  //Prepare the expression script
  //expression inside #{...} is to be evaluated
  String script = 'Hello, #{person.name}!'; 

  //Prepare an expression context.
  ELContext ctx = new ELContext(
    resolveVariable:
      (String name) => name == 'person' ? new Person('Rikulo'): null);

  //Parse the script and create a value expression which expect a String type
  ValueExpression ve = ef.createValueExpression(ctx, script, reflect('').type);
  
  //Evaluate the expression and return the evaluated result
  print(ve.getValue(ctx)); //'Hello, Rikulo!'
}
