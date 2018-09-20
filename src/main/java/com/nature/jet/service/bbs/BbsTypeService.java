package com.nature.jet.service.bbs;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.bbs.BbsTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.bbs.BbsType;

/**
 * BbsTypeService
 * Author:竺志伟
 * Date:2018-09-19 09:57:51
 */
@Service
public class BbsTypeService
{
    @Autowired
    BbsTypeMapper bbsTypeMapper;

    /**
     * 获取分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<BbsType> listPage(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsTypeMapper.list(key);
            }
        }));
    }

    /**
     * 创建数据
     *
     * @param bbsType
     * @return
     */
    public boolean addNew(BbsType bbsType)
    {
        return bbsTypeMapper.add(bbsType) == 1;
    }

    /**
     * 修改数据
     *
     * @param bbsType
     * @return
     */
    public boolean modify(BbsType bbsType)
    {
        return bbsTypeMapper.modify(bbsType) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        bbsTypeMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public BbsType getInfoById(int id)
    {
        return (BbsType) bbsTypeMapper.findById(id);
    }

    public boolean use(String[] ids)
    {
        return bbsTypeMapper.use(ids) > 0;
    }
}
