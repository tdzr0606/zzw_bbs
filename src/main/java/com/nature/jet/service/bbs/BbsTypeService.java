package com.nature.jet.service.bbs;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.bbs.BbsTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.bbs.BbsType;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

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
    @Cacheable(value = "bbstype")
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
    @CacheEvict(value = "bbstype", allEntries = true)
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
    @CacheEvict(value = "bbstype", allEntries = true)
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
    @CacheEvict(value = "bbstype", allEntries = true)
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

    @CacheEvict(value = "bbstype", allEntries = true)
    public boolean use(String[] ids)
    {
        return bbsTypeMapper.use(ids) > 0;
    }

    @CacheEvict(value = "bbstype", allEntries = true)
    public boolean updatePostNum(int id, String lastPoster)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("lastPoster", lastPoster);
        map.put("lastPostDate", new Timestamp(System.currentTimeMillis()));
        return bbsTypeMapper.updatePostNum(map) == 1;
    }
}
