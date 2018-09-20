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
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.pojo.bbs.BbsBbs;

/**
 * BbsBbs控制
 * BbsBbsController
 * Author:竺志伟
 * Date:2018-09-20 13:45:48
 */
@Controller
public class BbsBbsController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    BbsBbsService bbsBbsService;

    /**
     * 进入页面
     *
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/toPage")
    public String toPage()
    {
        return "/webAdmin/bbsBbs_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/list")
    @ResponseBody
    public Page<BbsBbs> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                                 @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                                 @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return bbsBbsService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param bbsBbs
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/new")
    @ResponseBody
    @MethodLog(description = "BBS帖子数据添加")
    public CommonResult add(BbsBbs bbsBbs)
    {
        return resultBoolWrapper(bbsBbsService.addNew(bbsBbs), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param bbsBbs
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/modify")
    @ResponseBody
    @MethodLog(description = "BBS帖子数据修改")
    public CommonResult modify(BbsBbs bbsBbs)
    {
        return resultBoolWrapper(bbsBbsService.modify(bbsBbs), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/delete")
    @ResponseBody
    @MethodLog(description = "BBS帖子数据删除")
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
        bbsBbsService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/info")
    @ResponseBody
    public CommonResult getBbsBbsById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", bbsBbsService.getInfoById(id));
    }

    /**
     * Use common result.
     *
     * @param ids the ids
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-20 14:28:38
     */
    @RequestMapping(value = "/webAdmin/bbsBbs/use")
    @ResponseBody
    @MethodLog(description = "BBS帖子启用/禁用")
    public CommonResult use(@RequestParam(value = "ids", required = true, defaultValue = "") String ids)
    {
        return resultBoolWrapper(bbsBbsService.use(ids.split(",")), "信息启用/禁用完成", "信息启用/禁用完成", null);
    }
}
