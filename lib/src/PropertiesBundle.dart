//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  02:11:03 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

abstract class PropertiesBundle {
  Map<String, String> _localemsgs;

  PropertiesBundle(String locale) {
    _localemsgs = _getProperties(locale);
  }

  String getString(String key) {
  	return _localemsgs == null ? null : _localemsgs[key];
  }

  Map<String, String> _getProperties(String locale) {
    Map<String, Map<String, String>> msgs = getBundle_();

    Map<String, String> props = msgs[locale];
    while(props == null) {
      locale = _nextLocale(locale);
   	  props = msgs[locale];
   	}
    if (props == null)
      props = msgs["en_US"];
   	return props;
  }

  String _nextLocale(String locale) {
  	int j = locale.lastIndexOf("_");
  	return j < 0 ? null : locale.substring(0, j);
  }

  Map<String, Map<String, String>> getBundle_();
}
