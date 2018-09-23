package com.nature.jet.service.bbs;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.bbs.BbsBbsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.bbs.BbsBbs;

import java.util.List;

/**
 * BbsBbsService
 * Author:竺志伟
 * Date:2018-09-20 13:45:48
 */
@Service
public class BbsBbsService
{
    @Autowired
    BbsBbsMapper bbsBbsMapper;

    /**
     * 获取楼主帖子分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<BbsBbs> listPage(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsBbsMapper.list(key);
            }
        }));
    }

    /**
     * 创建数据
     *
     * @param bbsBbs
     * @return
     */
    public boolean addNew(BbsBbs bbsBbs)
    {
        return bbsBbsMapper.add(bbsBbs) == 1;
    }

    /**
     * 修改数据
     *
     * @param bbsBbs
     * @return
     */
    public boolean modify(BbsBbs bbsBbs)
    {
        return bbsBbsMapper.modify(bbsBbs) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        bbsBbsMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public BbsBbs getInfoById(int id)
    {
        return (BbsBbs) bbsBbsMapper.findById(id);
    }

    public boolean use(String[] ids)
    {
        return bbsBbsMapper.use(ids) > 0;
    }


    /**
     * 热议帖子
     * List week list.
     *
     * @return the list
     * @author:竺志伟
     * @date :2018-09-20 15:05:48
     */
    public List<BbsBbs> listHotBbs()
    {
        return bbsBbsMapper.listHotBbs();
    }


    /**
     * 根据 主题类型 获取 帖子 分页信息
     * List page by type id page.
     *
     * @param cusPage  the cus page
     * @param pageSize the page size
     * @param typeId   the type id
     * @return the page
     * @author:竺志伟
     * @date :2018-09-22 15:51:01
     */
    public Page<BbsBbs> listPageByTypeId(int cusPage, int pageSize, int typeId)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsBbsMapper.listByTypeId(typeId);
            }
        }));
    }

    /**
     * 根据 帖子Id 获取 回帖列表
     * List reply by bbs id page.
     *
     * @param cusPage  the cus page
     * @param pageSize the page size
     * @param bbsId    the bbs id
     * @return the page
     * @author:竺志伟
     * @date :2018-09-23 10:36:37
     */
    public Page<BbsBbs> listReplyByBbsId(int cusPage, int pageSize, int bbsId)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsBbsMapper.listReplyByBbsId(bbsId);
            }
        }));
    }

    /**
     * 更新 回帖数量
     * Update reply num by id boolean.
     *
     * @param id the id
     * @return the boolean
     * @author:竺志伟
     * @date :2018-09-23 13:33:21
     */
    public boolean updateReplyNumById(int id)
    {
        return bbsBbsMapper.updateReplyNumById(id) == 1;
    }


    /**
     * 根据用户Id 获取主帖
     * List main by user id page.
     *
     * @param cusPage  the cus page
     * @param pageSize the page size
     * @param userId   the user id
     * @return the page
     * @author:竺志伟
     * @date :2018-09-23 15:53:29
     */
    public Page<BbsBbs> listMainByUserId(int cusPage, int pageSize, int userId)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsBbsMapper.listMainByUserId(userId);
            }
        }));
    }

    /**
     * 获取 最新 12条回复信息
     * List 12 sub by user id list.
     *
     * @param userId the user id
     * @return the list
     * @author:竺志伟
     * @date :2018-09-23 16:45:02
     */
    public List<BbsBbs> list12SubByUserId(int userId)
    {
        return bbsBbsMapper.list12SubByUserId(userId);
    }


    /**
     * 根据主贴Id 获取 回帖 时间轴
     * List sub time by bbs id list.
     *
     * @param bbsId the bbs id
     * @return the list
     * @author:竺志伟
     * @date :2018-09-23 17:20:41
     */
    public List<BbsBbs> listSubTimeByBbsId(int bbsId)
    {
        return bbsBbsMapper.listSubTimeByBbsId(bbsId);
    }
}
