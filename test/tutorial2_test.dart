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
  String script = 'Hello, #{currentPerson().name}!';

  //Prepare an expression context.
  Person currentPerson() => new Person('Rikulo');
  ELContext ctx = new ELContext(
    resolveFunction:
      (String name) => name == "currentPerson" ? currentPerson: null);

  //Parse the script and create a value expression which expect a String type
  ValueExpression ve = ef.createValueExpression(ctx, script, reflect('').type);
  
  //Evaluate the expression and return the evaluated result
  print(ve.getValue(ctx)); //'Hello, Rikulo!'
}
