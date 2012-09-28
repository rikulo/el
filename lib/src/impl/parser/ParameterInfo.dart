//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Tue, Sep 25, 2012  04:15:10 PM
// Author: hernichen

class ParameterInfo {
  List<ParameterMirror> positionals = new List();
  List<ParameterMirror> optionals = new List();
  List<ParameterMirror> nameds = new List();

  ParameterInfo(List<ParameterMirror> params) {
    for(ParameterMirror param in params) {
      if (param.isOptional)
        optionals.add(param);
//TODO(henri): namedArgs is not supported yet.
//      else if (param.isNamed)
//        nameds.add(param);
      else
        positionals.add(param);
    }
  }
}
