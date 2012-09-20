/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Wed, Sep 12, 2012  11:06:58 AM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * Represents any of the exception conditions that can arise during expression
 * evaluation.
 *
 * @since 2.1
 */
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
