package com.nature.jet.controller.web;

import javax.servlet.http.HttpServletRequest;

import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.component.system.CommonResult;
import com.nature.jet.component.system.Page;
import com.nature.jet.pojo.web.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.nature.jet.service.web.NoticeService;
import com.nature.jet.pojo.web.Notice;

import java.sql.Timestamp;

/**
 * Notice控制
 * NoticeController
 * Author:竺志伟
 * Date:2018-09-18 15:54:02
 */
@Controller
public class NoticeController extends BaseController
{
    @Autowired
    HttpServletRequest request;
    @Autowired
    NoticeService noticeService;

    /**
     * 进入页面
     *
     * @return
     */
    @RequestMapping(value = "/webAdmin/notice/toPage")
    public String toPage()
    {
        return "/webAdmin/notice_jsp";
    }

    /**
     * 获取分页信息
     *
     * @param page
     * @param limit
     * @param key
     * @return
     */
    @RequestMapping(value = "/webAdmin/notice/list")
    @ResponseBody
    public Page<Notice> listPage(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                                 @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                                 @RequestParam(value = "key", required = false, defaultValue = "") String key)
    {
        return noticeService.listPage(page, limit, key);
    }

    /**
     * 添加信息
     *
     * @param notice
     * @return
     */
    @RequestMapping(value = "/webAdmin/notice/new")
    @ResponseBody
    @MethodLog(description = "系统通知数据添加")
    public CommonResult add(Notice notice)
    {
        User user = super.getWebLogin();
        notice.setCreateName(user.getLoginName());
        notice.setCreateDate(new Timestamp(System.currentTimeMillis()));
        notice.setIsPublic(false);
        return resultBoolWrapper(noticeService.addNew(notice), "信息创建成功", "信息创建失败", null);
    }

    /**
     * 修改信息
     *
     * @param notice
     * @return
     */
    @RequestMapping(value = "/webAdmin/notice/modify")
    @ResponseBody
    @MethodLog(description = "系统通知数据修改")
    public CommonResult modify(Notice notice)
    {
        return resultBoolWrapper(noticeService.modify(notice), "信息修改成功", "信息修改失败", null);
    }

    /**
     * 删除信息
     *
     * @param ids
     * @return
     */
    @RequestMapping(value = "/webAdmin/notice/delete")
    @ResponseBody
    @MethodLog(description = "系统通知数据删除")
    public CommonResult delete(@RequestParam(value = "ids", required = true, defaultValue = "0") String ids)
    {
        noticeService.deleteByIds(ids.split(","));
        return resultSuccessWrapper("信息删除成功,已经发布的数据无法删除", null);
    }

    /**
     * 根据id 获取信息
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/webAdmin/notice/info")
    @ResponseBody
    public CommonResult getNoticeById(@RequestParam(value = "id", required = true, defaultValue = "0") Integer id)
    {
        return resultBoolWrapper(true, "信息装载成功", "信息装载失败", noticeService.getInfoById(id));
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
    @RequestMapping(value = "/webAdmin/notice/use")
    @ResponseBody
    @MethodLog(description = "系统通知启用/禁用")
    public CommonResult use(@RequestParam(value = "ids", required = true, defaultValue = "") String ids)
    {
        return resultBoolWrapper(noticeService.use(ids.split(",")), "信息启用/禁用完成", "信息启用/禁用完成", null);
    }
}
