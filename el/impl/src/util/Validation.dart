/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Sep 14, 2012  06:36:06 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

class Validation {
    static bool _SKIP_IDENTIFIER_CHECK = false;

    // Java keywords, bool literals & the null literal in alphabetical order
    static final List<String> _invalidIdentifiers = const ["abstract", "assert",
        "bool", "break", "case", "catch", "class", "const",
        "continue", "default", "do", "double", "else", "equals", "extends", "factory",
        "false", "final", "finally", "for", "if", "implements",
        "import", "in", "int", "is", "library", "native", "new",
        "null", "num", "on", "return", "static", "super", "switch", "this",
        "throw", "true", "try", "void", "while" ];

    /**
     * Test whether the argument is a Dart identifier.
     */
    static bool isIdentifier(String key) {

        if (_SKIP_IDENTIFIER_CHECK) {
            return true;
        }

        // Should not be the case but check to be sure
        if (key == null || key.length == 0) {
            return false;
        }

        // Check the list of known invalid values
        int i = 0;
        int j = _invalidIdentifiers.length;
        while (i < j) {
            int k = (i + j) >> 1; // Avoid overflow
            int result = _invalidIdentifiers[k].compareTo(key);
            if (result == 0) {
                return false;
            }
            if (result < 0) {
                i = k + 1;
            } else {
                j = k;
            }
        }

        return _IDENT.hasMatch(key);
    }

    static RegExp _IDENT = const RegExp("^[A-Za-z_]{1}[A-Za-z0-9_]*");
}
