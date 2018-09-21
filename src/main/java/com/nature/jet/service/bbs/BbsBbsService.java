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
}
