package com.nature.jet.controller.system;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.pojo.web.User;
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.service.bbs.BbsTypeService;
import com.nature.jet.service.bbs.BbsUserService;
import com.nature.jet.service.web.FriendService;
import com.nature.jet.service.web.NoticeService;
import com.nature.jet.service.web.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    UserService userService;


    /**
     * bbs首页
     */
    @Autowired
    BbsTypeService bbsTypeService;
    @Autowired
    FriendService friendService;
    @Autowired
    NoticeService noticeService;
    @Autowired
    BbsBbsService bbsBbsService;
    @Autowired
    BbsUserService bbsUserService;


    /**
     * bbs 首页
     * Bbs index string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-06 11:01:36
     */
    @RequestMapping(value = "/")
    public String bbsIndex()
    {
        // 系统通知
        request.setAttribute("notices", noticeService.listPage(1, 6, "").getData());
        // 主题列表
        request.setAttribute("bbstype", bbsTypeService.listForIndex());
        // 友情链接
        request.setAttribute("friends", friendService.listPage(1, 12, "").getData());
        // 热议榜
        request.setAttribute("hotbbs", bbsBbsService.listHotBbs());
        // 回帖榜
        request.setAttribute("backuser", bbsUserService.listBack());

        return "/bbs/index_jsp";
    }

    /**
     * bbs 退出
     * Bbs log out string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-06 11:01:39
     */
    @RequestMapping(value = "/logout")
    public String bbsLogOut()
    {
        super.removeBbsLogin();
        return "redirect:/";
    }


    /**
     * 后台管理 登录页面
     * Web index string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-06 10:31:29
     */
    @RequestMapping(value = {"/webAdmin", "/webAdmin/"})
    public String webAdmin()
    {
        return "/webAdmin/login_jsp";
    }


    /**
     * 后台管理 登录
     * Web admin login common result.
     *
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-14 22:25:39
     */
    @RequestMapping(value = "/webAdmin/login")
    @ResponseBody
    @MethodLog(description = "后台登录")
    public CommonResult webAdminLogin(@RequestParam(value = "loginName", required = true, defaultValue = "") String loginName,
                                      @RequestParam(value = "loginPass", required = true, defaultValue = "") String loginPass)
    {
        User user = userService.login(loginName, DigestUtils.md5Hex(loginPass));
        if(null == user)
        {
            return resultFailsWrapper("用户名密码错误", null);
        }
        super.saveWebLogin(user);
        return resultSuccessWrapper("登录成功", null);
    }


    /**
     * 后台管理 首页
     * Web admin index string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-14 22:27:08
     */
    @RequestMapping(value = "/webAdmin/index")
    public String webAdminIndex()
    {
        return "/webAdmin/index_jsp";
    }

    /**
     * 后台管理 登出
     * Web log out string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-06 10:31:49
     */
    @RequestMapping(value = "/webAdmin/logout")
    @MethodLog(description = "后台登出")
    public String webAdminLogOut()
    {
        super.removeWebLogin();
        return "redirect:/webAdmin";
    }

}

