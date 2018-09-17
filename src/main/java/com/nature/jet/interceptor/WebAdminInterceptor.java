package com.nature.jet.interceptor;

import com.nature.jet.pojo.web.User;
import com.nature.jet.utils.Fields;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WebAdminInterceptor extends org.springframework.web.servlet.handler.HandlerInterceptorAdapter
{
    Logger logger = LoggerFactory.getLogger(WebAdminInterceptor.class);

    //配置权限拦截
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
    {
        String uri = request.getRequestURI();
        logger.info(String.format("%s,用户访问验证", uri));
        if("/webAdmin".equals(uri) || "/webAdmin/login".equals(uri) || "/webAdmin/logout".equals(uri))
        {
            return true;
        }
        User admin = (User) request.getSession().getAttribute(Fields.SESSION_WEB_LOGIN);
        if(admin == null)
        {
            request.getSession().removeAttribute(Fields.SESSION_WEB_LOGIN);
            request.setAttribute("errorInfo", "登录超时或未登录,请重新登录");
            request.setAttribute("uri", request.getRequestURI());
            request.getRequestDispatcher("/popular/error").forward(request, response);
            return false;
        }
        logger.info(String.format("%s,用户访问验证,%s", admin.getLoginName(), uri));
        return true;
    }

}
