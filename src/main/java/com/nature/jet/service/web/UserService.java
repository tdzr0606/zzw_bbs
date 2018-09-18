package com.nature.jet.service.web;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.web.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.web.User;

import java.util.HashMap;
import java.util.Map;

/**
 * UserService
 * Author:竺志伟
 * Date:2018-09-14 22:01:25
 */
@Service
public class UserService
{
    @Autowired
    UserMapper userMapper;

    /**
     * 获取分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<User> listPage(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                userMapper.list(key);
            }
        }));
    }

    /**
     * 创建数据
     *
     * @param user
     * @return
     */
    public boolean addNew(User user)
    {
        return userMapper.add(user) == 1;
    }

    /**
     * 修改数据
     *
     * @param user
     * @return
     */
    public boolean modify(User user)
    {
        return userMapper.modify(user) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        userMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public User getInfoById(int id)
    {
        return (User) userMapper.findById(id);
    }


    public User login(String loginName, String loginPass)
    {
        Map<String, String> map = new HashMap<>();
        map.put("loginName", loginName);
        map.put("loginPass", loginPass);
        return userMapper.login(map);
    }


    public boolean modifyPass(int id, String loginPass)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("loginPass", loginPass);
        return userMapper.modifyPass(map) == 1;
    }

    public boolean checkLoginName(String loginName)
    {
        return userMapper.checkLoginName(loginName) == 0;
    }

    public boolean use(String[] ids)
    {
        return userMapper.use(ids) > 0;
    }
}
