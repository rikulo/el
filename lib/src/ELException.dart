//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:06:58 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class ELException extends ExceptionImplementation {
  final Exception cause;
    /**
     * Creates an ELException with the given detail message and root cause.
     *
     * @param message
     *            the detail message
     * @param cause
     *            the originating cause of this exception
     */
    const ELException([String message, Exception cause])
      : this.cause = cause,
        super(message);
}
