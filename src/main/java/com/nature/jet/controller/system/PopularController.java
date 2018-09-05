package com.nature.jet.controller.system;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by luonianqing on 2013-12-01.
 * 公用查询窗口界面
 */
@Controller
public class PopularController extends BaseController
{

    @Autowired
    HttpServletRequest request;


    /**
     * 所有错误,无权页面返回的信息.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-06-06 11:28:42
     */
    @RequestMapping(value = "/popular/error", method = RequestMethod.GET)
    public String error()
    {
        return "/popular/error_jsp";
    }


}
