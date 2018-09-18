package com.nature.jet.service.web;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.web.FriendMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.web.Friend;

/**
 * 
 * FriendService
 * Author:竺志伟
 * Date:2018-09-18 20:06:47
 */
@Service
public class FriendService
{
    @Autowired
    FriendMapper friendMapper;

    /**
     * 获取分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<Friend> listPage(int cusPage, int pageSize, String key)
    {
			return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
			{
				@Override
				public void doSelect(){ friendMapper.list(key);}
			}));
    }

    /**
     * 创建数据
     *
     * @param friend
     * @return
     */
    public boolean addNew(Friend friend)
    {
        return friendMapper.add(friend) == 1;
    }

    /**
     * 修改数据
     *
     * @param friend
     * @return
     */
    public boolean modify(Friend friend)
    {
        return friendMapper.modify(friend) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        friendMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public Friend getInfoById(int id)
    {
        return (Friend) friendMapper.findById(id);
    }
}
