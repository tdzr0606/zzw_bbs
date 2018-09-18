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
import com.nature.jet.service.web.UserService;
import com.nature.jet.pojo.web.User;

/**
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
    @RequestMapping(value = "/webAdmin/user/toPage")
    public String toPage()
    {
        return "/webAdmin/user_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/user/list")
    @ResponseBody
    public Page<User> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
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
    @RequestMapping(value = "/webAdmin/user/new")
    @ResponseBody
    @MethodLog(description = "管理员添加")
    public CommonResult add(User user)
    {
        if(userService.checkLoginName(user.getLoginName()))
        {
            user.setLoginPass(DigestUtils.md5Hex(user.getLoginPass()));
            return resultBoolWrapper(userService.addNew(user), "信息创建成功", "信息创建失败", null);
        }
        return resultFailsWrapper("当前登录名已经存在!", null);
    }

    /**
     * 修改信息
     *
     * @param user
     * @return
     */
    @RequestMapping(value = "/webAdmin/user/modify")
    @ResponseBody
    @MethodLog(description = "管理员修改")
    public CommonResult modify(User user)
    {
        User oldUser = userService.getInfoById(user.getId());
        String nowPass = user.getLoginPass();
        // 密码改变
        if(!(oldUser.getLoginPass().equals(nowPass) || oldUser.getLoginPass().equals(DigestUtils.md5Hex(nowPass))))
        {
            user.setLoginPass(DigestUtils.md5Hex(nowPass));
        }
        return resultBoolWrapper(userService.modify(user), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/user/delete")
    @ResponseBody
    @MethodLog(description = "管理员删除")
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
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
    @RequestMapping(value = "/webAdmin/user/info")
    @ResponseBody
    public CommonResult getUserById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", userService.getInfoById(id));
    }

    /**
     * 启用/禁用
     * Use common result.
     *
     * @param ids the ids
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-18 10:24:46
     */
    @RequestMapping(value = "/webAdmin/user/use")
    @ResponseBody
    @MethodLog(description = "管理员启用/禁用")
    public CommonResult use(@RequestParam(value = "ids", required = true, defaultValue = "") String ids)
    {
        return resultBoolWrapper(userService.use(ids.split(",")), "信息启用/禁用完成", "信息启用/禁用完成", null);
    }

    /**
     * 密码修改
     * Pass modify common result.
     *
     * @param loginPass  the login pass
     * @param loginPassN the login pass n
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-18 08:53:56
     */
    @RequestMapping(value = "/webAdmin/user/passModify")
    @ResponseBody
    @MethodLog(description = "管理员密码修改")
    public CommonResult passModify(@RequestParam(value = "loginPass", required = true, defaultValue = "") String loginPass,
                                   @RequestParam(value = "loginPassN", required = true, defaultValue = "") String loginPassN)
    {
        User user = super.getWebLogin();
        if(!DigestUtils.md5Hex(loginPass).equals(user.getLoginPass()))
        {
            return resultFailsWrapper("原始密码不匹配", null);
        }
        return resultBoolWrapper(userService.modifyPass(user.getId(), DigestUtils.md5Hex(loginPassN)), "密码修改成功,请重新登录", "密码修改失败",
                null);
    }
}
