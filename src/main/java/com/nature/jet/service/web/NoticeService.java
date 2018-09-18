package com.nature.jet.service.web;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.web.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.web.Notice;

/**
 * NoticeService
 * Author:竺志伟
 * Date:2018-09-18 15:54:02
 */
@Service
public class NoticeService
{
    @Autowired
    NoticeMapper noticeMapper;

    /**
     * 获取分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<Notice> listPage(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                noticeMapper.list(key);
            }
        }));
    }

    /**
     * 创建数据
     *
     * @param notice
     * @return
     */
    public boolean addNew(Notice notice)
    {
        return noticeMapper.add(notice) == 1;
    }

    /**
     * 修改数据
     *
     * @param notice
     * @return
     */
    public boolean modify(Notice notice)
    {
        return noticeMapper.modify(notice) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        noticeMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public Notice getInfoById(int id)
    {
        return (Notice) noticeMapper.findById(id);
    }

    public boolean use(String[] ids)
    {
        return noticeMapper.use(ids) > 0;
    }
}
