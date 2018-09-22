package com.nature.jet.interceptor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PopularInterceptor extends org.springframework.web.servlet.handler.HandlerInterceptorAdapter
{
    Logger logger = LoggerFactory.getLogger(PopularInterceptor.class);

    //配置权限拦截
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {
        String uri = request.getRequestURI();
        logger.info(String.format("%s,用户访问验证", uri));
        if("/popular/error".equals(uri))
        {
            return true;
        }
        return true;
    }

}
