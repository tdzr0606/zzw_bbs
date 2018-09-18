package com.nature.jet.controller.web;

import javax.servlet.http.HttpServletRequest;

import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.component.system.CommonResult;
import com.nature.jet.component.system.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.nature.jet.service.web.FriendService;
import com.nature.jet.pojo.web.Friend;

/**
 * Friend控制
 * FriendController
 * Author:竺志伟
 * Date:2018-09-18 20:06:47
 */
@Controller
public class FriendController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    FriendService friendService;

    /**
     * 进入页面
     *
     * @return
     */
    @RequestMapping(value = "/webAdmin/friend/toPage")
    public String toPage()
    {
        return "/webAdmin/friend_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/friend/list")
    @ResponseBody
    public Page<Friend> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                                 @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                                 @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return friendService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param friend
     * @return
     */
    @RequestMapping(value = "/webAdmin/friend/new")
    @ResponseBody
    @MethodLog(description = "友情链接数据添加")
    public CommonResult add(Friend friend)
    {
        return resultBoolWrapper(friendService.addNew(friend), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param friend
     * @return
     */
    @RequestMapping(value = "/webAdmin/friend/modify")
    @ResponseBody
    @MethodLog(description = "友情链接数据修改")
    public CommonResult modify(Friend friend)
    {
        return resultBoolWrapper(friendService.modify(friend), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/friend/delete")
    @ResponseBody
    @MethodLog(description = "友情链接数据删除")
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
        friendService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/webAdmin/friend/info")
    @ResponseBody
    public CommonResult getFriendById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", friendService.getInfoById(id));
    }
}
