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
import com.nature.jet.service.web.UserService;
import com.nature.jet.pojo.web.User;

/**
 * 
 * User控制
 * UserController
 * Author:竺志伟
 * Date:2018-09-14 22:01:25
 */
@Controller
public class UserController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    UserService userService;

    /**
      * 进入页面
      *
      * @return
      */
    @RequestMapping(value="/wbkj/user/toPage")
    public String toPage()
    {
       return "/wbkj/web/user_jsp";
    }
    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/wbkj/user/list")
    @ResponseBody
    public Page<User> listPage(
            @RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
            @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
            @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return userService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/wbkj/user/new")
    @ResponseBody
	  @MethodLog(description = "数据添加")
    public CommonResult add(User user)
    {
        return resultBoolWrapper(userService.addNew(user), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/wbkj/user/modify")
    @ResponseBody
	  @MethodLog(description = "数据修改")
    public CommonResult modify(User user)
    {
        return resultBoolWrapper(userService.modify(user), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/wbkj/user/delete")
    @ResponseBody
	  @MethodLog(description = "数据删除")
    public CommonResult delete(
            @RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
		    userService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/wbkj/user/info")
    @ResponseBody
    public CommonResult getUserById(
            @RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", userService.getInfoById(id));
    }
}
