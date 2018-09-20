package com.nature.jet.controller.web;

import javax.servlet.http.HttpServletRequest;

import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.component.system.CommonResult;
import com.nature.jet.component.system.Page;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.nature.jet.service.bbs.BbsUserService;
import com.nature.jet.pojo.bbs.BbsUser;

import java.util.Date;

/**
 * BbsUser控制
 * BbsUserController
 * Author:竺志伟
 * Date:2018-09-18 20:57:03
 */
@Controller
public class BbsUserController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    BbsUserService bbsUserService;

    /**
     * 进入页面
     *
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsUser/toPage")
    public String toPage()
    {
        return "/webAdmin/bbsUser_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsUser/list")
    @ResponseBody
    public Page<BbsUser> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                                  @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                                  @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return bbsUserService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param bbsUser
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsUser/new")
    @ResponseBody
    @MethodLog(description = "BBS用户数据添加")
    public CommonResult add(BbsUser bbsUser)
    {
        if(!bbsUserService.checkLoginName(bbsUser.getLoginName()))
        {
            return resultFailsWrapper("当前登录名已经存在", null);
        }
        bbsUser.setBackNum(0);
        bbsUser.setIsUse(false);
        bbsUser.setLoginPass(DigestUtils.md5Hex(bbsUser.getLoginPass()));
        bbsUser.setPostNum(0);
        bbsUser.setRegisterDate(new Date());
        return resultBoolWrapper(bbsUserService.addNew(bbsUser), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param bbsUser
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsUser/modify")
    @ResponseBody
    @MethodLog(description = "BBS用户数据修改")
    public CommonResult modify(BbsUser bbsUser)
    {
        BbsUser oldUser = bbsUserService.getInfoById(bbsUser.getId());
        if(!(DigestUtils.md5Hex(bbsUser.getLoginPass()).equals(oldUser.getLoginPass()) ||
                bbsUser.getLoginPass().equals(oldUser.getLoginPass())))
        {
            bbsUser.setLoginPass(DigestUtils.md5Hex(bbsUser.getLoginPass()));
        }
        return resultBoolWrapper(bbsUserService.modify(bbsUser), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsUser/delete")
    @ResponseBody
    @MethodLog(description = "BBS用户数据删除")
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
        bbsUserService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功,已经启用的数据禁止删除", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsUser/info")
    @ResponseBody
    public CommonResult getBbsUserById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", bbsUserService.getInfoById(id));
    }

    /**
     * Use common result.
     *
     * @param ids the ids
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-18 22:43:04
     */
    @RequestMapping(value = "/webAdmin/bbsUser/use")
    @ResponseBody
    @MethodLog(description = "BBS用户启用/禁用")
    public CommonResult use(@RequestParam(value = "ids", required = true, defaultValue = "") String ids)
    {
        return resultBoolWrapper(bbsUserService.use(ids.split(",")), "信息启用/禁用完成", "信息启用/禁用完成", null);
    }
}
