package com.nature.jet.interceptor;

import com.nature.jet.utils.Fields;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * bbs端 拦截器
 * zzw_bbs
 * BbsInterceptor
 *
 * @Author: 竺志伟
 * @Date: 2018-09-22 11:51
 */
public class BbsInterceptor extends HandlerInterceptorAdapter
{

    Logger logger = LoggerFactory.getLogger(BbsInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {
        String uri = request.getRequestURI();
        logger.info(String.format("%s,用户访问验证", uri));

        if(null == request.getSession().getAttribute(Fields.SESSION_BBS_LOGIN))
        {
            request.getRequestDispatcher("/popular/error").forward(request, response);
            return false;
        }
        return true;
    }
}
