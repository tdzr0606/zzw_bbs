package com.nature.jet.controller.bbs;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.component.system.Page;
import com.nature.jet.controller.system.BaseController;
import com.nature.jet.interceptor.MethodLog;
import com.nature.jet.pojo.bbs.BbsBbs;
import com.nature.jet.pojo.bbs.BbsType;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.service.bbs.BbsTypeService;
import com.nature.jet.service.business.BbsBusinessService;
import com.nature.jet.service.web.FriendService;
import com.nature.jet.utils.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;

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
    @Autowired
    BbsTypeService bbsTypeService;
    @Autowired
    BbsBusinessService bbsBusinessService;

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
                            @RequestParam(value = "typeId", required = true, defaultValue = "") Integer typeId)
    {
        // 友情链接
        request.setAttribute("friends", friendService.listPage(1, 12, "").getData());
        // 热议榜
        request.setAttribute("hotbbs", bbsBbsService.listHotBbs());
        request.setAttribute("bbsType", bbsTypeService.getInfoById(typeId));
        Page<BbsBbs> bbsPage = bbsBbsService.listPageByTypeId(page, limit, typeId);
        request.setAttribute("bbsPage", bbsPage);
        request.setAttribute("count", bbsPage.getCount());
        request.setAttribute("typeId", typeId);
        request.setAttribute("nowPage", bbsPage.getPage());
        request.setAttribute("totalPage", bbsPage.getTotalPage());
        return "/bbs/bbsList_jsp";
    }


    /**
     * 进入新帖发表页面
     * To new bbs string.
     *
     * @return the string
     * @author:竺志伟
     * @date :2018-09-22 16:46:20
     */
    @RequestMapping(value = "/bbs/toNewBbs")
    public String toNewBbs()
    {
        request.setAttribute("bbsType", bbsTypeService.listPage(1, 99, "").getData());
        return "/bbs/newBbs_jsp";
    }

    /**
     * 发表新帖
     * New bbs common result.
     *
     * @param bbs the bbs
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-22 17:21:25
     */
    @RequestMapping(value = "/bbs/newBbs")
    @ResponseBody
    @MethodLog(description = "bbs端发表新帖")
    public CommonResult newBbs(BbsBbs bbs)
    {
        BbsUser bbsUser = super.getBbsLogin();
        bbs.setCreateId(bbsUser.getId());
        bbs.setCreateName(bbsUser.getUserName());
        bbs.setCreateDateTime(new Timestamp(System.currentTimeMillis()));
        bbs.setIsPublic(true);
        bbs.setReplyId(0);
        bbs.setReplyNum(0);
        bbs.setCreateImgUrl(bbsUser.getImgUrl());
        bbs.setIsTop(false);
        return resultBoolWrapper(bbsBusinessService.postBbs(bbs), "新帖发表成功", "新帖发表失败", bbs);
    }

    /**
     * 进入 bbs 详情页面
     * To bbs deail string.
     *
     * @param bbsId the bbs id
     * @param page  the page
     * @param limit the limit
     * @return the string
     * @author:竺志伟
     * @date :2018-09-23 10:25:53
     */
    @RequestMapping(value = "/toBbsDetail")
    public String toBbsDeail(@RequestParam(value = "bbsId", required = true, defaultValue = "0") Integer bbsId,
                             @RequestParam(value = "page", required = true, defaultValue = "1") Integer page,
                             @RequestParam(value = "limit", required = true, defaultValue = "40") Integer limit)
    {
        request.setAttribute("bbsId", bbsId);

        // 主贴
        BbsBbs mainBbs = bbsBbsService.getInfoById(bbsId);
        request.setAttribute("mainBbs", mainBbs);

        BbsType bbsType = bbsTypeService.getInfoById(mainBbs.getTypeId());
        request.setAttribute("bbsType", bbsType);

        // 回帖列表
        Page<BbsBbs> bbsPage = bbsBbsService.listReplyByBbsId(page, 10, bbsId);
        request.setAttribute("subBbsPage", bbsPage);
        request.setAttribute("count", bbsPage.getCount());
        request.setAttribute("nowPage", bbsPage.getPage());
        request.setAttribute("totalPage", bbsPage.getTotalPage());
        // 友情链接
        request.setAttribute("friends", friendService.listPage(1, 12, "").getData());
        // 热议榜
        request.setAttribute("hotbbs", bbsBbsService.listHotBbs());
        return "/bbs/bbsDetail_jsp";
    }


    /**
     * 帖子回复
     * Reply bbs common result.
     *
     * @param bbsId   the bbs id
     * @param content the content
     * @return the common result
     * @author:竺志伟
     * @date :2018-09-23 13:06:01
     */
    @RequestMapping(value = "/replyBbs")
    @ResponseBody
    @MethodLog(description = "bbs端回帖")
    public CommonResult replyBbs(@RequestParam(value = "bbsId", required = true, defaultValue = "0") Integer bbsId,
                                 @RequestParam(value = "content", required = true, defaultValue = "") String content)
    {
        BbsBbs mainBbs = bbsBbsService.getInfoById(bbsId);
        BbsUser bbsUser = super.getBbsLogin();
        BbsBbs bbs = new BbsBbs();
        bbs.setReplyId(bbsId);
        bbs.setContent(content);
        bbs.setTitle("");
        bbs.setReplyNum(0);
        if(null == bbsUser)
        {
            bbs.setCreateName("游客");
        }
        else
        {
            bbs.setCreateId(bbsUser.getId());
            bbs.setCreateName(bbsUser.getUserName());
            bbs.setCreateImgUrl(bbsUser.getImgUrl());
        }
        bbs.setIsPublic(true);
        bbs.setCreateDateTime(new Timestamp(System.currentTimeMillis()));
        bbs.setTitle("回帖");
        bbs.setTypeId(mainBbs.getTypeId());
        bbs.setTypeTitle(mainBbs.getTypeTitle());
        return resultBoolWrapper(bbsBusinessService.replyBbs(bbs, bbsUser), "回帖成功", "回帖失败", bbs);
    }

}
