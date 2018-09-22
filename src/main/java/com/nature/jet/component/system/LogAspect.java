package com.nature.jet.component.system;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.nature.jet.controller.system.IndexController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.pojo.web.Logs;
import com.nature.jet.pojo.web.User;
import com.nature.jet.service.web.LogsService;
import com.nature.jet.utils.Fields;
import com.nature.jet.utils.JsonUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * LogAspect
 *
 * @author:竺志伟
 * @date :2018-09-18 10:36:30
 */
@Component
@Aspect
public class LogAspect
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    LogsService logsService;

    /**
     * 方法完成 切面
     * Method after returning.
     *
     * @param joinPoint the join point
     * @param methodLog the method log
     * @param result    the result
     * @throws Throwable the throwable
     * @author:竺志伟
     * @date :2018-07-04 11:19:56
     */
    @AfterReturning(value = "execution(* com.nature.jet.controller..*(..)) && @annotation(methodLog)",
            argNames = "joinPoint, " + "methodLog,result", returning = "result")
    public void methodAfterReturning(JoinPoint joinPoint, MethodLog methodLog, Object result) throws Throwable
    {
        Logs log = new Logs();
        //返回目标对象
        Object target = joinPoint.getTarget();
        Class targetClass = Class.forName(target.getClass().getName());
        //返回当前连接点签名  调用的方法名称
        String methodName = joinPoint.getSignature().getName();

        MethodLog methodLogTemp = null;
        Method[] methods = targetClass.getMethods();
        for(Method method : methods)
        {
            if(method.getName().equals(methodName))
            {
                methodLogTemp = method.getAnnotation(MethodLog.class);
                break;
            }
        }

        // 参数
        String param = this.getParam();

        log.setIp(this.getRequestIP());
        log.setClassName(target.getClass().getName());
        log.setMethodName(methodName);
        log.setParamStr(param);
        log.setResultStr(JsonUtils.toJson(result, JsonInclude.Include.ALWAYS));
        log.setCreateTime(new Timestamp(System.currentTimeMillis()));
        log.setNote((null != methodLogTemp) ? methodLogTemp.description() : "");

        User user = (User) request.getSession().getAttribute(Fields.SESSION_WEB_LOGIN);
        BbsUser bbsUser = (BbsUser) request.getSession().getAttribute(Fields.SESSION_BBS_LOGIN);
        if(null != user)
        {
            log.setLoginName(user.getLoginName());
            log.setLogsType("管理端日志");
        }
        else if(null != bbsUser)
        {
            log.setLoginName(bbsUser.getLoginName());
            log.setLogsType("BBS端日志");
        }
        else
        {
            log.setLoginName("");
            log.setLogsType("未知");
        }
        logsService.addNew(log);
    }

    /**
     * Gets request ip.
     *
     * @return the request ip
     * @author:竺志伟
     * @date :2018-07-04 09:51:13
     */
    private String getRequestIP()
    {
        String ip = null;
        if(request.getHeader("x-forwarded-for") == null)
        {
            ip = request.getRemoteAddr();
        }
        else
        {
            ip = request.getHeader("x-forwarded-for");
        }
        return ip;
    }


    /**
     * Gets param.
     *
     * @return the param
     * @author:竺志伟
     * @date :2018-07-04 09:57:10
     */
    private String getParam()
    {
        Map properties = request.getParameterMap();
        Map returnMap = new HashMap();
        Iterator entries = properties.entrySet().iterator();
        Map.Entry entry;
        String name = "";
        String value = "";
        while(entries.hasNext())
        {
            entry = (Map.Entry) entries.next();
            name = (String) entry.getKey();
            Object valueObj = entry.getValue();
            value = null;
            if(null == valueObj)
            {
                value = "";
            }
            else if(valueObj instanceof String[])
            {
                String[] values = (String[]) valueObj;
                for(int i = 0; i < values.length; i++)
                {
                    if(value == null)
                    {
                        value = (values[i] == null ? "" : values[i]);
                    }
                    else
                    {
                        value += "," + (values[i] == null ? "" : values[i]);
                    }
                }
            }
            else
            {
                value = valueObj.toString();
            }
            returnMap.put(name, value);
        }
        return JsonUtils.toJson(returnMap, JsonInclude.Include.ALWAYS);
    }
}
