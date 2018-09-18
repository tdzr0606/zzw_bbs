package com.nature.jet.service.web;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.web.LogsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.web.Logs;

/**
 * LogsService
 * Author:竺志伟
 * Date:2018-09-18 10:30:23
 */
@Service
public class LogsService
{
    @Autowired
    LogsMapper logsMapper;

    /**
     * 获取分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<Logs> listPage(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                logsMapper.list(key);
            }
        }));
    }

    /**
     * 创建数据
     *
     * @param logs
     * @return
     */
    public boolean addNew(Logs logs)
    {
        return logsMapper.add(logs) == 1;
    }

    /**
     * 修改数据
     *
     * @param logs
     * @return
     */
    public boolean modify(Logs logs)
    {
        return logsMapper.modify(logs) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        logsMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public Logs getInfoById(int id)
    {
        return (Logs) logsMapper.findById(id);
    }
}
