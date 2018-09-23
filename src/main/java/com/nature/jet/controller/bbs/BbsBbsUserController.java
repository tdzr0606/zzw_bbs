package com.nature.jet.controller.bbs;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.component.system.Page;
import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.pojo.bbs.BbsBbs;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.service.bbs.BbsBbsService;
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
    @Autowired
    BbsBbsService bbsBbsService;

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


    /**
     * 进入用户中心
     * To user center string.
     *
     * @param page  the page
     * @param limit the limit
     * @return the string
     * @author:竺志伟
     * @date :2018-09-23 15:33:06
     */
    @RequestMapping(value = "/bbs/toUserCenter")
    public String toUserCenter(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                               @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit)
    {
        BbsUser bbsUser = super.getBbsLogin();
        Page<BbsBbs> bbsPage = bbsBbsService.listMainByUserId(page, limit, bbsUser.getId());
        request.setAttribute("bbsPage", bbsPage);
        request.setAttribute("count", bbsPage.getCount());
        request.setAttribute("nowPage", bbsPage.getPage());
        request.setAttribute("totalPage", bbsPage.getTotalPage());
        return "/bbs/userCenter_jsp";
    }


    /**
     * 进入 用户中心
     * To user info string.
     *
     * @param id the id
     * @return the string
     * @author:竺志伟
     * @date :2018-09-23 16:17:40
     */
    @RequestMapping(value = "/toUserInfo")
    public String toUserInfo(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        request.setAttribute("bbsUser", bbsUserService.getInfoById(id));
        request.setAttribute("mainBbsPage", bbsBbsService.listMainByUserId(1, 12, id));
        request.setAttribute("subBbs", bbsBbsService.list12SubByUserId(id));
        return "/bbs/userInfo_jsp";
    }
}
