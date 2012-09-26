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
//History: Sat, Sep 15, 2012  05:35:07 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * @author Jacob Hookom [jacob@hookom.net]
 * @version $Id: FunctionMapperFactory.java 939311 2010-04-29 14:01:02Z kkolinko $
 */
class FunctionMapperFactory extends FunctionMapper {

    FunctionMapperImpl memento_ = null;
    FunctionMapper target_;

    FunctionMapperFactory(FunctionMapper mapper) {
        if (mapper == null) {
            throw const NullPointerException("FunctionMapper target cannot be null");
        }
        this.target_ = mapper;
    }


    /* (non-Javadoc)
     * @see javax.el.FunctionMapper#resolveFunction(java.lang.String, java.lang.String)
     */
    //@Override
    Function resolveFunction(String prefix, String localName) {
        if (this.memento_ == null) {
            this.memento_ = new FunctionMapperImpl();
        }
        Function m = this.target_.resolveFunction(prefix, localName);
        if (m != null) {
            this.memento_.addFunction(prefix, localName, m);
        }
        return m;
    }

    FunctionMapper create() {
        return this.memento_;
    }

}
