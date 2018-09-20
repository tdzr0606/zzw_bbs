package com.nature.jet.mapper.bbs;

import com.nature.jet.utils.MyMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

import com.nature.jet.pojo.bbs.BbsType;

/**
 * BbsType 数据持久化
 * BbsType
 * Author:竺志伟
 * Date:2018-09-19 09:57:51
 */
public interface BbsTypeMapper extends MyMapper<BbsType>
{
    /**
     * 查询数据
     *
     * @return
     **/
    public List<BbsType> list(@Param(value = "key") String key);

    /**
     * 添加数据
     *
     * @param obj
     **/
    public int add(BbsType obj);

    /**
     * 更新数据
     *
     * @param obj
     **/
    public int modify(BbsType obj);

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     **/
    public BbsType findById(@Param(value = "id") Integer id);

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

    public int use(@Param(value = "ids") String[] ids);

}
