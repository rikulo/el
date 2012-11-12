//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:06:58 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ELException implements Exception {
  final cause;
  final message;

  /**
   * Creates an ELException with the given detail message and root cause.
   *
   * + [message] - the detail message
   * + [cause] - the originating cause of this exception
   */
  const ELException([var message, var cause])
      : this.cause = cause,
        this.message = message;

  String toString() => (message == null) ?
      "Exception: ${cause == null ? '' : '\nCaused by\n$cause'}" :
      "Exception: $message${cause == null ? '' : '\nCaused by\n$cause'}";
}
