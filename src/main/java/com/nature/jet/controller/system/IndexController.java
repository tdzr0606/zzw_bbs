package com.nature.jet.controller.system;

import com.nature.jet.utils.Fields;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * web
 * IndexController
 *
 * @Author: 竺志伟
 * @Date: 2017-09-27 16:28
 */
@Controller
public class IndexController extends BaseController
{
    @Autowired
    HttpServletRequest request;

    @RequestMapping(value = "/")
    public String defaultPage()
    {
        return "login_jsp";
    }

    /**
     * Login string. 用户登录界面
     *
     * @return the string
     * @author:罗年庆
     * @date :2017-12-25 12:24:37
     */
    @RequestMapping(value = "/webAdmin")
    public String toLogin()
    {
        return "login_jsp";
    }




    /**
     * 管理 系统 退出
     * To login out string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-06-04 15:52:17
     */
    @RequestMapping(value = "/webAdmin/logOut")
    public String toLoginOut()
    {
        request.getSession().removeAttribute(Fields.SESSION_LOGIN);
        return "redirect:/";
    }

}

