package com.nature.jet.interceptor;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * km_leader
 * Author: 竺志伟
 * Date:   2018-01-09 10:14
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Token
{
    boolean save() default false;
    boolean remove() default false;
}
