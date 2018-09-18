package com.nature.jet.mapper.web;

import com.nature.jet.utils.MyMapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import com.nature.jet.pojo.web.Logs;

/**
 * 
 * Logs 数据持久化
 * Logs
 * Author:竺志伟
 * Date:2018-09-18 10:30:23
 */
public interface LogsMapper extends MyMapper<Logs>
{
	/**
	  * 查询数据
	  *
	  * @return
	  **/
	public List<Logs> list(@Param(value = "key") String key);

	/**
	  * 添加数据
	  *
	  * @param obj
	  **/
	public int add(Logs obj);

	/**
	  * 更新数据
	  *
	  * @param obj
	  **/
	public int modify(Logs obj);

	/**
	  * 根据id查询数据
	  *
	  * @param id
	  * @return
	  **/
	public Logs findById(@Param(value = "id") Integer id);

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

}
