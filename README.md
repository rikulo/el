#Rikulo-el

[Rikulo-el](http://rikulo.org) is an implementation of the [Unified Expression Language](http://en.wikipedia.org/wiki/Unified_Expression_Language) specification in Dart.
While the EL specification is originally designed for Java language, it serves as a powerful tool to embed expressions into web pages; thus we port it to Dart.

Rikulo-el is distributed under the Apache 2.0 License.

* [Home](http://rikulo.org)
* [Documentation](http://docs.rikulo.org)
* [API Reference](http://api.rikulo.org)
* [Discussion](http://stackoverflow.com/questions/tagged/rikulo)
* [Issues](https://github.com/rikulo/rikulo-el/issues)

#History
* Sep. 20, 2012: alpha version
 * Porting EL 2.2 from Java implementation of Tomcat 7 to Dart language(in brutal way :-)).
 * Some Java specific functions are removed(e.g. There is no BigDecimal in Dart; thus not in Rikulo-el, either).
 * It uses Dart Mirror a lot.
 * EL parser seems work great.
 * There must be rooms for extra features in Dart specifically(e.g. named optional arguments for function).

##Notes to Contributors

###Test and Debug

You are welcome to submit bugs and feature requests. Or even better if you can fix or implement them!

###Fork Rikulo

If you'd like to contribute back to the core, you can [fork this repository](https://help.github.com/articles/fork-a-repo) and send us a pull request, when it is ready.

If you are new to Git or GitHub, please read [this guide](https://help.github.com/) first.

##Development Notes

###Directories
el/src -- API interfaces
el/impl/src -- API implementations