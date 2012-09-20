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
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

/**
 * @author Jacob Hookom [jacob/hookom.net]
 *
 */
abstract class ELResolver {
    
    static String message(ELContext context, String name, List props) {
        String locale = context.getLocale();
        if (locale == null) {
            locale = "en_US"; //TODO(henri): until Dart has Locale concept
        }
        LocalStrings bundle = new LocalStrings(locale);
        String template = bundle.getString(name);
        if (props != null) {
            template = MessageFormat.format(template, props);
        }
        return template;
    }

    static final String RESOLVABLE_AT_DESIGN_TIME = "resolvableAtDesignTime";
    
    static final String TYPE = "type";
    
    abstract Object getValue(ELContext context, Object base, Object property);
    
    abstract ClassMirror getType(ELContext context, Object base, Object property);
    
    abstract void setValue(ELContext context, Object base, Object property, Object value);

    abstract bool isReadOnly(ELContext context, Object base, Object property);
        
    abstract ClassMirror getCommonPropertyType(ELContext context, Object base);
    
    /**
     * @since EL 2.2
     */
    abstract Object invoke(ELContext context, Object base, Object method, List params);
}
