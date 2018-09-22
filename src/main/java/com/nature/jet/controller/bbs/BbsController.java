package com.nature.jet.controller.bbs;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.service.bbs.BbsUserService;
import com.nature.jet.service.web.NoticeService;
import com.nature.jet.utils.Tools;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;

/**
 * zzw_bbs
 * BbsIndexController
 *
 * @Author: 竺志伟
 * @Date: 2018-09-20 14:49
 */
@Controller
public class BbsController extends BaseController
{
    @Autowired
    NoticeService noticeService;
    @Autowired
    BbsBbsService bbsBbsService;
    @Autowired
    BbsUserService bbsUserService;

    /**
     * 系统通知 明细页面
     * Show notice detail string.
     *
     * @param id the id
     * @return the string
     * @author:竺志伟
     * @date :2018-09-20 21:30:36
     */
    @RequestMapping(value = "/showNoticeDetail/{id}")
    public String showNoticeDetail(@PathVariable(value = "id") String id)
    {
        if(Tools.isInteger(id))
        {
            request.setAttribute("notice", noticeService.getInfoById(Integer.parseInt(id)));
        }
        // 热议榜
        request.setAttribute("hotbbs", bbsBbsService.listHotBbs());
        return "/bbs/noticeDetail_jsp";
    }


    /**
     * 进入登录页面
     * To login page string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-21 21:48:57
     */
    @RequestMapping(value = "/toLogin")
    public String toLoginPage()
    {
        return "/bbs/login_jsp";
    }

    /**
     * 登录
     * Login common result.
     *
     * @param loginName the login name
     * @param loginPass the login pass
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-21 22:57:23
     */
    @RequestMapping(value = "/login")
    @ResponseBody
    @MethodLog(description = "bbs端登录")
    public CommonResult login(@RequestParam(value = "loginName", required = true, defaultValue = "") String loginName,
                              @RequestParam(value = "loginPass", required = true, defaultValue = "") String loginPass)
    {
        BbsUser bbsUser = bbsUserService.login(loginName, DigestUtils.md5Hex(loginPass));
        if(null == bbsUser)
        {
            return resultFailsWrapper("用户名密码错误", null);
        }
        super.saveBbsLogin(bbsUser);
        bbsUserService.updateLogin(bbsUser.getId(), super.getRequestIP(), new Timestamp(System.currentTimeMillis()));
        return resultSuccessWrapper("登录成功", null);
    }

    /**
     * 进入注册页面
     * To regist page string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-21 22:55:50
     */
    @RequestMapping(value = "/toRegist")
    public String toRegistPage()
    {
        return "/bbs/regist_jsp";
    }

    /**
     * 注册
     * Regist common result.
     *
     * @param userName  the user name
     * @param loginName the login name
     * @param loginPass the login pass
     * @param mobile    the mobile
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-22 10:01:54
     */
    @RequestMapping(value = "/regist")
    @ResponseBody
    @MethodLog(description = "bbs端注册")
    public CommonResult regist(@RequestParam(value = "userName", required = true, defaultValue = "") String userName,
                               @RequestParam(value = "loginName", required = true, defaultValue = "") String loginName,
                               @RequestParam(value = "loginPass", required = true, defaultValue = "") String loginPass,
                               @RequestParam(value = "mobile", required = false, defaultValue = "") String mobile)
    {
        if(!bbsUserService.checkUserName(userName))
        {
            return resultFailsWrapper("当前昵称已经存在", null);
        }
        if(!bbsUserService.checkLoginName(loginName))
        {
            return resultFailsWrapper("当前登录名称已经存在", null);
        }

        BbsUser bbsUser = new BbsUser();
        bbsUser.setUserName(userName);
        bbsUser.setLoginName(loginName);
        bbsUser.setLoginPass(DigestUtils.md5Hex(loginPass));
        bbsUser.setMobile(mobile);
        bbsUser.setRegisterDate(new Timestamp(System.currentTimeMillis()));
        bbsUser.setPostNum(0);
        bbsUser.setBackNum(0);
        bbsUser.setIsUse(true);
        boolean pd = bbsUserService.addNew(bbsUser);
        if(pd)
        {
            bbsUser = bbsUserService.login(loginName, DigestUtils.md5Hex(loginPass));
            if(null != bbsUser)
            {
                super.saveBbsLogin(bbsUser);
                bbsUserService.updateLogin(bbsUser.getId(), super.getRequestIP(), new Timestamp(System.currentTimeMillis()));
            }
        }
        return resultBoolWrapper(pd, "用户注册成功", "用户注册失败", bbsUser);
    }

}
