#Rikulo EL

[Rikulo EL](http://rikulo.org) is an implementation of the [Unified Expression
 Language](http://en.wikipedia.org/wiki/Unified_Expression_Language) 
 specification plus enhancements for and in Dart. 

* [Home](http://rikulo.org)
* [Tutorial](http://blog.rikulo.org/posts/2012/Sep/Tutorial/rikulo-el-an-expression-language-for-and-in-dart/)
* [API Reference](http://api.rikulo.org/el/latest/)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/el/issues)

Rikulo EL is distributed under the Apache 2.0 License.

[![Build Status](https://drone.io/github.com/rikulo/el/status.png)](https://drone.io/github.com/rikulo/el/latest)

##Install from Dart Pub Repository

Add this to your `pubspec.yaml` (or create it):

    dependencies:
      rikulo_el:

Then run the [Pub Package Manager](http://pub.dartlang.org/doc) (comes with the Dart SDK):

    pub install

##Install from Github for Bleeding Edge Stuff

To install stuff that is still in development, add this to your `pubspec.yam`:

    dependencies:
      rikulo_el:
        git: git://github.com/rikulo/el.git

For more information, please refer to [Pub: Dependencies](http://pub.dartlang.org/doc/pubspec.html#dependencies).

##Usage

Using Rikulo EL is straightforward.

	import 'dart:mirrors' show reflect;
    import "package:rikulo_el/el.dart";

    class Person {
      String name;
      Person(this.name);
    }
    Person person = new Person('Rikulo');

    class _FunctionMapper extends FunctionMapper {
      Function resolveFunction(String name)
      => name == "owner" ? () => person: null;
    }

    void main() {
      ValueExpression expr = new ExpressionFactory().createValueExpression(
        new ELContext(functionMapper: new _FunctionMapper()),
        'Hello, #{owner().name}!', reflect('').type);
      print(expr.getValue(ctx)); //'Hello, Rikulo!'
    }

For more examples, please refer to [here](https://github.com/rikulo/el/blob/master/test/ValueExpressionImpl_test.dart), [here](https://github.com/rikulo/el/blob/master/test/MethodExpressionImpl_test.dart) and [here](https://github.com/rikulo/el/blob/master/test/ELEval_test.dart).

##Notes to Contributors

###Test and Debug

You are welcome to submit [bugs and feature requests](https://github.com/rikulo/el/issues). Or even better if you can fix or implement them!

###Create Addons

Rikulo is easy to extend. The simplest way to enhance Rikulo is to [create a new repository](https://help.github.com/articles/create-a-repo) and add your own great widgets and libraries to it.

###Fork Rikulo

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

Please be aware that one of Rikulo's design goals is to keep the sphere of API as neat and consistency as possible. Strong enhancement always demands greater consensus.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.
