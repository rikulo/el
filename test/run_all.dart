//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Tue, Apr 09, 2013  4:50:32 PM
// Author: tomyeh
library test_run_all;

import 'dart:io' show Options;
import 'package:unittest/compact_vm_config.dart';
import 'package:unittest/unittest.dart';

import 'ELArithmetic_test.dart' as ELArithmetic_test;
import 'ELEval_test.dart' as ELEval_test;
import 'ELParser_test.dart' as ELParser_test;
import 'ELSupport_test.dart' as ELSupport_test;
import 'MethodExpressionImpl_test.dart' as MethodExpressionImpl_test;
import 'ValueExpressionImpl_test.dart' as ValueExpressionImpl_test;

main() {
//  useCompactVMConfiguration();

  group("ELArithmetic_test", ELArithmetic_test.main);
  group("ELEval_test", ELEval_test.main);
  group("ELParser_test", ELParser_test.main);
  group("ELSupport_test", ELSupport_test.main);
  group("MethodExpressionImpl_test", MethodExpressionImpl_test.main);
  group("ValueExpressionImpl_test", ValueExpressionImpl_test.main);
}
