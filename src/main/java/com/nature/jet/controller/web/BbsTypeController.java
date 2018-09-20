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
import com.nature.jet.service.bbs.BbsTypeService;
import com.nature.jet.pojo.bbs.BbsType;

import java.sql.Timestamp;

/**
 * BbsType控制
 * BbsTypeController
 * Author:竺志伟
 * Date:2018-09-19 09:57:51
 */
@Controller
public class BbsTypeController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    BbsTypeService bbsTypeService;

    /**
     * 进入页面
     *
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsType/toPage")
    public String toPage()
    {
        return "/webAdmin/bbsType_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsType/list")
    @ResponseBody
    public Page<BbsType> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                                  @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                                  @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return bbsTypeService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param bbsType
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsType/new")
    @ResponseBody
    @MethodLog(description = "BBS主题数据添加")
    public CommonResult add(BbsType bbsType)
    {
        bbsType.setCreateDate(new Timestamp(System.currentTimeMillis()));
        bbsType.setIsUse(false);
        return resultBoolWrapper(bbsTypeService.addNew(bbsType), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param bbsType
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsType/modify")
    @ResponseBody
    @MethodLog(description = "BBS主题数据修改")
    public CommonResult modify(BbsType bbsType)
    {
        return resultBoolWrapper(bbsTypeService.modify(bbsType), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsType/delete")
    @ResponseBody
    @MethodLog(description = "BBS主题数据删除")
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
        bbsTypeService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/webAdmin/bbsType/info")
    @ResponseBody
    public CommonResult getBbsTypeById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", bbsTypeService.getInfoById(id));
    }

    /**
     * Use common result.
     *
     * @param ids the ids
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-18 22:43:04
     */
    @RequestMapping(value = "/webAdmin/bbsType/use")
    @ResponseBody
    @MethodLog(description = "BBS主题启用/禁用")
    public CommonResult use(@RequestParam(value = "ids", required = true, defaultValue = "") String ids)
    {
        return resultBoolWrapper(bbsTypeService.use(ids.split(",")), "信息启用/禁用完成", "信息启用/禁用完成", null);
    }
}
