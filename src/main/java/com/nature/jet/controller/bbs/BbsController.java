package com.nature.jet.controller.bbs;

import com.nature.jet.controller.system.BaseController;
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.service.web.NoticeService;
import com.nature.jet.utils.Tools;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * zzw_bbs
 * BbsIndexController
 *
 * @Author: 竺志伟
 * @Date: 2018-09-20 14:49
 */
@Controller
public class BbsController extends BaseController
{
    @Autowired
    NoticeService noticeService;
    @Autowired
    BbsBbsService bbsBbsService;

    /**
     * 系统通知 明细页面
     * Show notice detail string.
     *
     * @param id the id
     * @return the string
     * @author:竺志伟
     * @date :2018-09-20 21:30:36
     */
    @RequestMapping(value = "/showNoticeDetail/{id}")
    public String showNoticeDetail(@PathVariable(value = "id") String id)
    {
        if(Tools.isInteger(id))
        {
            request.setAttribute("notice", noticeService.getInfoById(Integer.parseInt(id)));
        }
        // 热议榜
        request.setAttribute("hotbbs", bbsBbsService.listHotBbs());
        return "/bbs/noticeDetail_jsp";
    }
}
