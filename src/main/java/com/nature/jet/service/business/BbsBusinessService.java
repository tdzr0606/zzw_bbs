package com.nature.jet.service.business;

import com.nature.jet.pojo.bbs.BbsBbs;
import com.nature.jet.pojo.bbs.BbsUser;
import com.nature.jet.service.bbs.BbsBbsService;
import com.nature.jet.service.bbs.BbsTypeService;
import com.nature.jet.service.bbs.BbsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

/**
 * zzw_bbs
 * BbsBusinessService
 *
 * @Author: 竺志伟
 * @Date: 2018-09-23 13:23
 */
@Service
public class BbsBusinessService
{

    @Autowired
    BbsBbsService bbsBbsService;
    @Autowired
    BbsUserService bbsUserService;
    @Autowired
    BbsTypeService bbsTypeService;


    /**
     * 发表新帖
     * Post bbs boolean.
     *
     * @param bbs the bbs
     * @return the boolean
     * @author:竺志伟
     * @date :2018-09-23 14:04:33
     */
    @Transactional
    public boolean postBbs(BbsBbs bbs)
    {
        boolean pd = false;
        try
        {
            pd = bbsBbsService.addNew(bbs) && bbsUserService.updatePostNum(bbs.getCreateId()) &&
                    bbsTypeService.updatePostNum(bbs.getTypeId(), bbs.getCreateName());
        }
        catch(Exception e)
        {
            e.printStackTrace();
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        finally
        {
            return pd;
        }
    }


    /**
     * 回帖
     * Reply bbs boolean.
     *
     * @param replyBbs the reply bbs
     * @return the boolean
     * @author:竺志伟
     * @date :2018-09-23 13:27:20
     */
    @Transactional
    public boolean replyBbs(BbsBbs replyBbs, BbsUser bbsUser)
    {
        boolean pd = false;
        try
        {
            if(null != bbsUser)
            {
                pd = bbsBbsService.addNew(replyBbs) && bbsBbsService.updateReplyNumById(replyBbs.getReplyId()) &&
                        bbsUserService.updateBackNum(bbsUser.getId());
            }
            else
            {
                pd = bbsBbsService.addNew(replyBbs) && bbsBbsService.updateReplyNumById(replyBbs.getReplyId());
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        }
        finally
        {
            return pd;
        }
    }
}
