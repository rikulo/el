//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  05:37:13 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

part of rikulo_elimpl;

/**
 * Helper class for Arithmetic operation.
 */
abstract class ELArithmetic {

//TODO(henri): we don't support BigDecimal yet.
//  static final BigDecimalDelegate BIGDECIMAL = new BigDecimalDelegate();

  static final DoubleDelegate DOUBLE = new DoubleDelegate();

  static final IntDelegate INT = new IntDelegate();

  static final int ZERO = 0;

  static num add(Object obj0, Object obj1) {
    if (obj0 == null && obj1 == null) {
      return ZERO;
    }

    ELArithmetic delegate;
//TODO(henri): we don't support BigDecimal yet.
    if (DOUBLE.matches_(obj0, obj1))
      delegate = DOUBLE;
    else
      delegate = INT;
//    if (BIGDECIMAL.matches_(obj0, obj1))
//      delegate = BIGDECIMAL;
//    else if (DOUBLE.matches_(obj0, obj1)) {
//      if (INT.matches_(obj0, obj1))
//        delegate = BIGDECIMAL;
//      else
//        delegate = DOUBLE;
//    }
//    else
//      delegate = INT;

    num num0 = delegate.coerce_(obj0);
    num num1 = delegate.coerce_(obj1);

    return delegate.add_(num0, num1);
  }

  static num mod(Object obj0, Object obj1) {
    if (obj0 == null && obj1 == null) {
      return ZERO;
    }

    ELArithmetic delegate;
//TODO(henri): we don't support BigDecimal yet.
    if (DOUBLE.matches_(obj0, obj1))
      delegate = DOUBLE;
    else
      delegate = INT;
//    if (BIGDECIMAL.matches_(obj0, obj1))
//      delegate = DOUBLE;
//    else if (DOUBLE.matches_(obj0, obj1))
//      delegate = DOUBLE;
//    else
//      delegate = INT;

    num num0 = delegate.coerce_(obj0);
    num num1 = delegate.coerce_(obj1);

    return delegate.mod_(num0, num1);
  }

  static num subtract(Object obj0, Object obj1) {
    if (obj0 == null && obj1 == null) {
      return ZERO;
    }

    ELArithmetic delegate;
//TODO(henri): we don't support BigDecimal yet.
    if (DOUBLE.matches_(obj0, obj1))
      delegate = DOUBLE;
    else
      delegate = INT;
//    if (BIGDECIMAL.matches_(obj0, obj1))
//      delegate = BIGDECIMAL;
//    else if (DOUBLE.matches_(obj0, obj1)) {
//      if (INT.matches_(obj0, obj1))
//        delegate = BIGDECIMAL;
//      else
//        delegate = DOUBLE;
//    }
//    else
//      delegate = INT;

    num num0 = delegate.coerce_(obj0);
    num num1 = delegate.coerce_(obj1);

    return delegate.subtract_(num0, num1);
  }

  static num divide(Object obj0, Object obj1) {
    if (obj0 == null && obj1 == null) {
      return ZERO;
    }

    ELArithmetic delegate;
//TODO(henri): we don't support BigDecimal yet.
    if (DOUBLE.matches_(obj0, obj1))
      delegate = DOUBLE;
    else
      delegate = INT;
//    if (BIGDECIMAL.matches_(obj0, obj1))
//      delegate = BIGDECIMAL;
//    else if (INT.matches_(obj0, obj1))
//      delegate = BIGDECIMAL;
//    else
//      delegate = DOUBLE;

    num num0 = delegate.coerce_(obj0);
    num num1 = delegate.coerce_(obj1);

    return delegate.divide_(num0, num1);
  }

  static num multiply(Object obj0, Object obj1) {
    if (obj0 == null && obj1 == null) {
      return ZERO;
    }

    ELArithmetic delegate;
//TODO(henri): we don't support BigDecimal yet.
    if (DOUBLE.matches_(obj0, obj1))
      delegate = DOUBLE;
    else
      delegate = INT;
//    if (BIGDECIMAL.matches_(obj0, obj1))
//      delegate = BIGDECIMAL;
//    else if (DOUBLE.matches_(obj0, obj1)) {
//      if (INT.matches_(obj0, obj1))
//        delegate = BIGDECIMAL;
//      else
//        delegate = DOUBLE;
//    }
//    else
//      delegate = INT;

    num num0 = delegate.coerce_(obj0);
    num num1 = delegate.coerce_(obj1);

    return delegate.multiply_(num0, num1);
  }

  static bool isNumber(Object obj)
    => obj is num;
//TODO(henri): we don't support BigDecimal yet.
//    => obj is num || obj is BigDecimal;

  static bool isNumberType(ClassMirror type)
    => ClassUtil.isAssignableFrom(NUM_MIRROR, type);

  num add_(num num0, num num1);

  num multiply_(num num0, num num1);

  num subtract_(num num0, num num1);

  num mod_(num num0, num num1);

  num coerceNumber_(num value);

  num coerce_(Object obj) {

    if (isNumber(obj)) {
      return coerceNumber_(obj);
    }
    if (obj == null || "" == obj) {
      return coerceNumber_(ZERO);
    }
    if (obj is String) {
      return coerceString_(obj);
    }

    throw new ArgumentError(MessageFactory.getString("error.convert",
        [obj, reflect(obj).type.qualifiedName, "num"]));
  }

  num coerceString_(String str);

  num divide_(num num0, num num1);

  bool matches_(Object obj0, Object obj1);
}

//TODO(henri): we don't support BigDecimal yet
//class BigDecimalDelegate extends ELArithmetic {
//
//  //@Override
//  num add_(num num0, num num1) {
//    return num0 + num1;
//  }
//
//  //@Override
//  num coerceNumber_(num num0) {
//    if (num0 is BigDecimal)
//      return num0;
//    if (num0 is int)
//      return new BigDecimal.fromInt(num0);
//    return new BigDecimal.fromDouble(num0.toDouble());
//  }
//
//  //@Override
//  num coerceString_(String str) {
//    return new BigDecimal.fromString(str);
//  }
//
//  //@Override
//  num divide_(num num0, num num1) {
//    return num0.divide(num1, BigDecimal.ROUND_HALF_UP);
//  }
//
//  //@Override
//  num subtract_(num num0, num num1) {
//    return num0.subtract(num1);
//  }
//
//  //@Override
//  num mod_(num num0, num num1) {
//    return num0.toDouble() % num1.toDouble();
//  }
//
//  //@Override
//  num multiply_(num num0, num num1) {
//    return num0.multiply(num1);
//  }
//
//  //@Override
//  bool matches_(Object obj0, Object obj1) {
//    return (obj0 is BigDecimal || obj1 is BigDecimal);
//  }
//}

class DoubleDelegate extends ELArithmetic {

  //@Override
  num add_(num num0, num num1) {
    // could only be one of these
//TODO(henri): we don't support BigDecimal yet.
//    if (num0 is BigDecimal) {
//      return num0.add(new BigDecimal.fromDouble(num1.toDouble()));
//    } else if (num1 is BigDecimal) {
//      return new BigDecimal.fromDouble(num0.toDouble()).add(num1);
//    }
    return num0.toDouble() + num1.toDouble();
  }

  //@Override
  num coerceNumber_(num num0) {
    if (num0 is double)
      return num0;
//TODO(henri): we don't support BigDecimal yet.
//    if (num0 is int)
//      return new BigDecimal.fromInt(num0);
    return num0.toDouble();
  }

  //@Override
  num coerceString_(String str) {
    return double.parse(str);
  }

  //@Override
  num divide_(num num0, num num1) {
    return num0.toDouble() / num1.toDouble();
  }

  //@Override
  num mod_(num num0, num num1) {
    return num0.toDouble() % num1.toDouble();
  }

  //@Override
  num subtract_(num num0, num num1) {
    // could only be one of these
//TODO(henri): we don't support BigDecimal yet.
//    if (num0 is BigDecimal) {
//      return num0.subtract(new BigDecimal.fromDouble(num1.toDouble()));
//    } else if (num1 is BigDecimal) {
//      return new BigDecimal.fromDouble(num0.toDouble()).subtract(num1);
//    }
    return num0.toDouble() - num1.toDouble();
  }

  //@Override
  num multiply_(num num0, num num1) {
    // could only be one of these
//TODO(henri): we don't support BigDecimal yet.
//    if (num0 is BigDecimal) {
//      return num0.multiply(new BigDecimal(num1.toDouble()));
//    } else if (num1 is BigDecimal) {
//      return new BigDecimal.fromDouble(num0.toDouble()).multiply(num1);
//    }
    return num0.toDouble() * num1.toDouble();
  }

  //@Override
  bool matches_(Object obj0, Object obj1) {
    return obj0 is double
        || obj1 is double
        || (obj0 is String && ELSupport.isStringFloat(obj0))
        || (obj1 is String && ELSupport.isStringFloat(obj1));
  }
}

class IntDelegate extends ELArithmetic {

  //@Override
  num add_(num num0, num num1) {
    return num0.toInt() + num1.toInt();
  }

  //@Override
  num coerceNumber_(num num0) {
    return num0.toInt();
  }

  //@Override
  num coerceString_(String str) {
    return int.parse(str);
  }

  //@Override
  num divide_(num num0, num num1) {
    return num0.toInt() ~/ num1.toInt();
  }

  //@Override
  num mod_(num num0, num num1) {
    return num0.toInt() % num1.toInt();
  }

  //@Override
  num subtract_(num num0, num num1) {
    return num0.toInt() - num1.toInt();
  }

  //@Override
  num multiply_(num num0, num num1) {
    return num0.toInt() * num1.toInt();
  }

  //@Override
  bool matches_(Object obj0, Object obj1) {
    return (obj0 is int);
  }
}
