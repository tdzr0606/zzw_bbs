package com.nature.jet.controller.system;

import com.nature.jet.component.system.Page;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.service.bbs.BbsUserService;
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
    @Autowired
    BbsUserService bbsUserService;


    /**
     * 所有错误,无权页面返回的信息.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-06-06 11:28:42
     */
    @RequestMapping(value = "/popular/error")
    public String error()
    {
        return "/popular/error_jsp";
    }


    /**
     * 进入 版主选择页面
     * To master select page string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-19 11:07:36
     */
    @RequestMapping(value = "/popular/toMasterSelectPage")
    public String toMasterSelectPage()
    {
        return "/popular/masterSelectPage_jsp";
    }

    /**
     * 展示 版本信息
     * List master page.
     *
     * @param page  the page
     * @param limit the limit
     * @param key   the key
     * @return the page
     * @author:竺志伟
     * @date :2018-09-19 20:24:43
     */
    @RequestMapping(value = "/popular/master/listMaster")
    @ResponseBody
    public Page<BbsUser> listMaster(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                                    @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                                    @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return bbsUserService.listMaster(page, limit, key);
    }
}
