package com.nature.jet.mapper.bbs;

import com.nature.jet.utils.MyMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

import com.nature.jet.pojo.bbs.BbsBbs;

/**
 * BbsBbs 数据持久化
 * BbsBbs
 * Author:竺志伟
 * Date:2018-09-20 13:45:48
 */
public interface BbsBbsMapper extends MyMapper<BbsBbs>
{
    /**
     * 查询楼主帖子数据
     *
     * @return
     **/
    public List<BbsBbs> list(@Param(value = "key") String key);

    /**
     * 添加数据
     *
     * @param obj
     **/
    public int add(BbsBbs obj);

    /**
     * 更新数据
     *
     * @param obj
     **/
    public int modify(BbsBbs obj);

    /**
     * 根据id查询数据
     *
     * @param id
     * @return
     **/
    public BbsBbs findById(@Param(value = "id") Integer id);

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

    public List<BbsBbs> listHotBbs();

    public List<BbsBbs> listByTypeId(@Param(value = "typeId") Integer typeId);

}
