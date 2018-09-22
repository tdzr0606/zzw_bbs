package com.nature.jet.controller.bbs;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.service.bbs.BbsUserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * zzw_bbs
 * BbsBbsUserController
 *
 * @Author: 竺志伟
 * @Date: 2018-09-22 10:50
 */
@Controller
public class BbsBbsUserController extends BaseController
{

    @Autowired
    BbsUserService bbsUserService;

    /**
     * 进入 用户设置页面
     * To user set string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-22 10:52:19
     */
    @RequestMapping(value = "/bbs/toUserSet")
    public String toUserSet()
    {
        return "/bbs/userSet_jsp";
    }


    /**
     * 基本信息 修改
     * User info update common result.
     *
     * @param mobile the mobile
     * @param note   the note
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-22 11:41:32
     */
    @RequestMapping(value = "/bbs/userInfoUpdate")
    @ResponseBody
    @MethodLog(description = "bbs用户基本信息修改")
    public CommonResult userInfoUpdate(@RequestParam(value = "mobile", required = true, defaultValue = "") String mobile,
                                       @RequestParam(value = "note", required = false, defaultValue = "") String note)
    {
        BbsUser bbsUser = super.getBbsLogin();
        bbsUser = bbsUserService.getInfoById(bbsUser.getId());
        bbsUser.setMobile(mobile);
        bbsUser.setNote(note);
        boolean pd = bbsUserService.modify(bbsUser);
        super.saveBbsLogin(bbsUser);
        return resultBoolWrapper(pd, "基本信息修改成功", "基本信息修改失败", bbsUser);
    }


    /**
     * 用户头像 修改
     * User img upload common result.
     *
     * @param imgUrl the img url
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-22 14:14:07
     */
    @RequestMapping(value = "/bbs/userImgUpdate")
    @ResponseBody
    @MethodLog(description = "bbs用户头像信息修改")
    public CommonResult userImgUpload(@RequestParam(value = "imgUrl", required = true, defaultValue = "") String imgUrl)
    {
        BbsUser bbsUser = super.getBbsLogin();
        bbsUser = bbsUserService.getInfoById(bbsUser.getId());
        if(null == bbsUser.getImgUrl() || (null != bbsUser.getImgUrl() && !bbsUser.getImgUrl().equals(imgUrl)))
        {
            bbsUser.setImgUrl(imgUrl);
            boolean pd = bbsUserService.modify(bbsUser);
            super.saveBbsLogin(bbsUser);
            return resultBoolWrapper(pd, "头像修改成功", "头像修改失败", bbsUser);
        }
        return resultSuccessWrapper("", bbsUser);
    }


    /**
     * bbs用户密码修改
     * User pass update common result.
     *
     * @param newPass the new pass
     * @param nowPass the now pass
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-22 14:51:21
     */
    @RequestMapping(value = "/bbs/userPassUpdate")
    @ResponseBody
    @MethodLog(description = "bbs用户密码修改")
    public CommonResult userPassUpdate(@RequestParam(value = "newPass", required = true, defaultValue = "") String newPass,
                                       @RequestParam(value = "nowPass", required = true, defaultValue = "") String nowPass)
    {
        BbsUser bbsUser = super.getBbsLogin();
        bbsUser = bbsUserService.getInfoById(bbsUser.getId());
        if(!bbsUser.getLoginPass().equals(DigestUtils.md5Hex(nowPass)))
        {
            return resultFailsWrapper("原始密码不匹配", null);
        }

        bbsUser.setLoginPass(DigestUtils.md5Hex(newPass));
        boolean pd = bbsUserService.modify(bbsUser);
        super.saveBbsLogin(bbsUser);
        return resultBoolWrapper(pd, "密码修改成功", "密码修改失败", bbsUser);
    }
}
