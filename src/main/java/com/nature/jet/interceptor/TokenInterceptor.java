package com.nature.jet.interceptor;
import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.UUID;

/**
 * km_leader
 * TokenInterceptor
 * 基本思路:当用户进行第一次提交的时候,这时候没有Token,可以进行提交.同时存入Token,那么如果用户是双击,第二次过来就有Token告诉他重复提交
 * 当用户第一次提交完成后.须进行页面刷新,把Token移除,(可以放在装入页面和List取JSON的时候)
 * @Author: 竺志伟
 * @Date: 2018-01-09 10:16
 */
public class TokenInterceptor extends HandlerInterceptorAdapter {
    Logger logger = Logger.getLogger(TokenInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        logger.info(String.format("token验证,%s", request.getRequestURI()));
        if (handler instanceof HandlerMethod) {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            Token token = method.getAnnotation(Token.class);
            if (null != token) {
                boolean needSaveSession = token.save();
                if (needSaveSession) {
                    boolean pd = (null == request.getSession(true).getAttribute("token"));

                    if (!pd) {
                        logger.warn(String.format("重复提交url:%s,来源Ip:%s", request.getRequestURI(),
                                request.getRemoteAddr()));
                        response.setContentType("application/json;charset=UTF-8");
                        response.getWriter().write("{\"code\":\"repeat\",\"msg\":\"请不要重复提交数据\",\"success\":false}");
                    }
                    else
                    {
                        request.getSession(true).setAttribute("token",UUID.randomUUID());
                    }
                    return pd;
                }
                boolean needRemoveSession = token.remove();
                if (needRemoveSession) {
                    request.getSession(true).removeAttribute("token");
                }
            }
            return true;
        } else {
            return super.preHandle(request, response, handler);
        }
    }
    /*@Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception
    {

        System.out.println(handler.toString());
        String contentType=response.getContentType();
        if("application/json;charset=UTF-8".equals(contentType))//表示返回的是JSON数据.那么就需要知道Json的数据是不是失败
        {
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            if(method.getReturnType().getName().equals("com.wbkj.jet.component.system.CommonResult")) //表示返回的是Result类
            {
                System.out.println(handlerMethod.getBean());
            }
            else
            {
                super.afterCompletion(request, response, handler, ex);
            }
        }
        else //是其它数据,就是跳转呀什么的.和Token无关
        {
            super.afterCompletion(request, response, handler, ex);
        }
    }*/
}
