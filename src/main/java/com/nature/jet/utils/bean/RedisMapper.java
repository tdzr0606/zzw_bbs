package com.nature.jet.utils.bean;

import org.springframework.data.redis.core.RedisTemplate;

import java.util.List;

/**
 * zzw_bbs
 * RedisMapper
 *
 * @Author: 竺志伟
 * @Date: 2019-01-25 10:29
 */
public class RedisMapper
{
    private RedisTemplate<String, Object> redisTemplate;

    public RedisMapper(RedisTemplate<String, Object> template)
    {
        this.redisTemplate = template;
    }


    public void setStringValue(String key, String value)
    {
        redisTemplate.opsForValue().set(key, value);
    }

    public String getStringValue(String key)
    {
        return (null != redisTemplate.opsForValue().get(key)) ? redisTemplate.opsForValue().get(key).toString() : "";
    }

    public void clearByKey(String key)
    {
        redisTemplate.delete(key);
    }


    public void setListValue(String key, List value)
    {
        redisTemplate.opsForList().leftPushAll(key, value);
    }

    public List getListValue(String key)
    {
        return redisTemplate.opsForList().range(key, 0, -1);
    }


}
