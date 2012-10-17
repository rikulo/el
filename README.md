#Rikulo EL

[Rikulo EL](http://rikulo.org) is an implementation of the [Unified Expression
 Language](http://en.wikipedia.org/wiki/Unified_Expression_Language) 
 specification plus some enhancements for and in Dart. While the EL specification
 is originally designed for Java language, it serves as a powerful tool to embed 
 expressions into web pages.
 

* [Home](http://rikulo.org)
* [Tutorial](http://blog.rikulo.org/posts/2012/Sep/tutorial/rikulo-el-an-expression-language-for-and-in-dart/)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/rikulo-el/issues)

Rikulo EL is distributed under the Apache 2.0 License.

##Installation

Add this to your `pubspec.yaml` (or create it):

    dependencies:
      rikulo_el:

Then run the [Pub Package Manager](http://www.dartlang.org/docs/pub-package-manager/) (comes with the Dart SDK):

    pub install

##Usage

Using Rikulo EL is straightforward.

    import "package:rikulo_el/el.dart"; //(Required) EL interfaces and utility classes
    import "package:rikulo_el/impl.dart"; //(Optional) EL implementation

    class Person {
      String name;
      Person(this.name);
    }
    Person person = new Person('Rikulo');

    void main() {
      ExpressionFactory ef = new ExpressionFactory();
      ValueExpression ve = ef.createValueExpression(
        new ELContext(), 'Hello, #{person.name}!', reflect('').type);
      print(ve.getValue(ctx)); //'Hello, Rikulo!'
    }

##Notes to Contributors

###Test and Debug

You are welcome to submit bugs and feature requests. Or even better if you can fix or implement them!

###Fork Rikulo EL

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.
