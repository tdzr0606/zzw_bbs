package com.nature.jet.controller.bbs;

import com.nature.jet.component.system.Page;
import com.nature.jet.controller.system.BaseController;
import com.nature.jet.pojo.bbs.BbsBbs;
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.service.web.FriendService;
import com.nature.jet.service.web.NoticeService;
import com.nature.jet.utils.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * zzw_bbs
 * BbsBbsController
 *
 * @Author: 竺志伟
 * @Date: 2018-09-22 15:21
 */
@Controller
public class BbsController extends BaseController
{

    @Autowired
    FriendService friendService;
    @Autowired
    BbsBbsService bbsBbsService;

    /**
     * 进入 bbs 列表页面
     * To bbs list string.
     *
     * @param typeId the type id
     * @return the string
     * @author:竺志伟
     * @date :2018-09-22 15:27:28
     */
    @RequestMapping(value = "/toBbsList")
    public String toBbsList(@RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                            @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit,
                            @RequestParam(value = "typeId", required = true, defaultValue = "") String typeId)
    {
        // 友情链接
        request.setAttribute("friends", friendService.listPage(1, 12, "").getData());
        // 热议榜
        request.setAttribute("hotbbs", bbsBbsService.listHotBbs());

        if(Tools.isInteger(typeId))
        {
            Page<BbsBbs> bbsPage = bbsBbsService.listPageByTypeId(page, limit, Integer.parseInt(typeId));
            request.setAttribute("bbsPage", bbsPage);
            request.setAttribute("count",bbsPage.getCount());
            request.setAttribute("typeId", typeId);
            request.setAttribute("nowPage", bbsPage.getPage());
            request.setAttribute("totalPage", bbsPage.getTotalPage());
        }
        return "/bbs/bbsList_jsp";
    }
}
