package com.nature.jet.mapper.bbs;

import com.nature.jet.utils.MyMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

import com.nature.jet.pojo.bbs.BbsUser;

/**
 * BbsUser 数据持久化
 * BbsUser
 * Author:竺志伟
 * Date:2018-09-18 20:57:03
 */
public interface BbsUserMapper extends MyMapper<BbsUser>
{
    /**
     * 查询数据
     *
     * @return
     **/
    public List<BbsUser> list(@Param(value = "key") String key);

    /**
     * 添加数据
     *
     * @param obj
     **/
    public int add(BbsUser obj);

    /**
     * 更新数据
     *
     * @param obj
     **/
    public int modify(BbsUser obj);

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     **/
    public BbsUser findById(@Param(value = "id") Integer id);

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

    public int checkLoginName(@Param(value = "loginName") String loginName);

    public int use(@Param(value = "ids") String[] ids);

    public List<BbsUser> listMaster(@Param(value = "key") String key);

}
