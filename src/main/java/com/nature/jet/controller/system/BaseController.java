package com.nature.jet.controller.system;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.pojo.web.User;
import com.nature.jet.utils.Fields;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

public abstract class BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    CommonResult commonResult;
    protected Logger logger = LoggerFactory.getLogger(this.getClass());

    @ResponseBody
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public CommonResult missingParamterHandler(MissingServletRequestParameterException exception)
    {
        String paramsName = exception.getParameterName();
        return resultFailsWrapper(String.format("miss request params:%s", paramsName), null);
    }

    @ResponseBody
    @ExceptionHandler(Exception.class)
    public CommonResult serverExceptionHandler(Exception e) throws IOException
    {
        logger.error("Error:", e);
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        pw.close();
        sw.close();
        return resultWrapper(CommonResult.SERVER_ERROR, sw.getBuffer().toString(), null);
    }

    /**
     * 方法描述：只带数据对象的CommonResult
     * 创建作者：李兴武
     * 创建日期：2017-06-23 15:19:22
     *
     * @param obj 数据对象
     * @return 只带数据对象的CommonResult
     */
    protected CommonResult resultDataWrapper(Object obj)
    {
        return resultSuccessWrapper("success", obj);
    }


    /**
     * 方法描述：自定义状态码的CommonResult
     * 创建作者：李兴武
     * 创建日期：2017-06-23 15:21:05
     *
     * @param code    自定义代码
     * @param message 提示消息
     * @param obj     数据对象
     * @return CommonResult
     */
    protected CommonResult resultWrapper(int code, String message, Object obj)
    {
        commonResult.setMsg(message);
        commonResult.setData(obj);
        commonResult.setCode(code);
        return commonResult;
    }

    /**
     * 方法描述：返回成功和失败的CommonResult
     * 创建作者：李兴武
     * 创建日期：2017-06-23 15:04:03
     *
     * @param bool    状态:true成功,false失败
     * @param success true成功 提示消息
     * @param fails   false失败 提示消息
     * @param obj     需要传递的数据对象
     * @return CommonResult对象
     */
    protected CommonResult resultBoolWrapper(boolean bool, String success, String fails, Object obj)
    {
        if(bool)
        {
            return resultSuccessWrapper(success, obj);
        }
        return resultFailsWrapper(fails, obj);
    }

    /**
     * 方法描述：返回成功的CommonResult
     * 创建作者：罗
     * 创建日期：2017-06-23 15:01:58
     *
     * @param message 成功提示的消息
     * @param obj     需要传递的数据对象
     * @return CommonResul对象
     */
    protected CommonResult resultSuccessWrapper(String message, Object obj)
    {
        return resultWrapper(CommonResult.SUCCESS, message, obj);
    }

    /**
     * 方法描述：返回失败的CommonResult
     * 创建作者：罗
     * 创建日期：2017-06-23 15:01:58
     *
     * @param message 失败提示的消息
     * @param obj     需要传递的数据对象
     * @return CommonResul对象
     */
    protected CommonResult resultFailsWrapper(String message, Object obj)
    {
        return resultWrapper(CommonResult.FAILS, message, obj);
    }


    /**
     * 方法描述: 获取容器根目录.
     *
     * @return java.lang.String root path
     * @author:竺志伟
     * @date :2018-06-19 14:54:05
     */
    protected String getRootPath()
    {
        return ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
    }


    protected void removeBbsLogin()
    {
        request.getSession().removeAttribute(Fields.SESSION_BBS_LOGIN);
    }

    protected void removeWebLogin()
    {
        request.getSession().removeAttribute(Fields.SESSION_WEB_LOGIN);
    }

    protected void saveWebLogin(User user)
    {
        request.getSession().setAttribute(Fields.SESSION_WEB_LOGIN, user);
    }

    protected User getWebLogin()
    {
        return (User) request.getSession().getAttribute(Fields.SESSION_WEB_LOGIN);
    }

}
