package com.nature.jet.interceptor;

import java.lang.annotation.*;

/**
 * yd_check_svn
 * Author: 竺志伟
 * Date:   2018-07-04 10:24
 */

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
@Documented
public @interface MethodLog
{
    // 说明
    String description() default "";

    // 方法的类型
    Class<?> clazz = null;
}
