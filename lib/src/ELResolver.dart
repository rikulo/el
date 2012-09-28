//Copyright (C) 2012 Potix Corporation. All Rights Reserved.
//History: Fri, Aug 24, 2012  02:08:31 PM
// Author: hernichen
//Port from Tomcat 7.0.x (java -> dart)

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

    Object getValue(ELContext context, Object base, Object property);

    ClassMirror getType(ELContext context, Object base, Object property);

    void setValue(ELContext context, Object base, Object property, Object value);

    bool isReadOnly(ELContext context, Object base, Object property);

    ClassMirror getCommonPropertyType(ELContext context, Object base);

    Object invoke(ELContext context, Object base, Object method,
                           List params, [Map<String, Object> namedArgs]);
}
