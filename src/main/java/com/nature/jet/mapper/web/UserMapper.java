package com.nature.jet.mapper.web;

import com.nature.jet.utils.MyMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

import com.nature.jet.pojo.web.User;

/**
 * User 数据持久化
 * User
 * Author:竺志伟
 * Date:2018-09-14 22:01:25
 */
public interface UserMapper extends MyMapper<User>
{
    /**
     * 查询数据
     *
     * @return
     **/
    public List<User> list(@Param(value = "key") String key);

    /**
     * 添加数据
     *
     * @param obj
     **/
    public int add(User obj);

    /**
     * 更新数据
     *
     * @param obj
     **/
    public int modify(User obj);

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     **/
    public User findById(@Param(value = "id") Integer id);

    /**
     * 批量删除数据
     *
     * @param ids
     **/
    public void deleteByIds(@Param(value = "ids") String[] ids);

    /**
     * 根据Id删除数据
     *
     * @param id
     * @return
     **/
    public int deleteById(@Param(value = "id") Integer id);

    public User login(Map<String, String> map);

    public int modifyPass(Map<String, Object> map);

    public int checkLoginName(String loginName);

    public int use(@Param(value = "ids") String[] ids);

}
