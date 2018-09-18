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
import com.nature.jet.service.web.LogsService;
import com.nature.jet.pojo.web.Logs;

/**
 * Logs控制
 * LogsController
 * Author:竺志伟
 * Date:2018-09-18 10:30:23
 */
@Controller
public class LogsController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    LogsService logsService;

    /**
     * 进入页面
     *
     * @return
     */
    @RequestMapping(value = "/webAdmin/logs/toPage")
    public String toPage()
    {
        return "/webAdmin/logs_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/logs/list")
    @ResponseBody
    public Page<Logs> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                               @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                               @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return logsService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param logs
     * @return
     */
    @RequestMapping(value = "/webAdmin/logs/new")
    @ResponseBody
    public CommonResult add(Logs logs)
    {
        return resultBoolWrapper(logsService.addNew(logs), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param logs
     * @return
     */
    @RequestMapping(value = "/webAdmin/logs/modify")
    @ResponseBody
    public CommonResult modify(Logs logs)
    {
        return resultBoolWrapper(logsService.modify(logs), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/logs/delete")
    @ResponseBody
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
        logsService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/webAdmin/logs/info")
    @ResponseBody
    public CommonResult getLogsById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", logsService.getInfoById(id));
    }
}
