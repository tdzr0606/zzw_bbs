package com.nature.jet.utils.bean;

import org.springframework.data.redis.core.StringRedisTemplate;

/**
 * zzw_bbs
 * RedisMapper
 *
 * @Author: 竺志伟
 * @Date: 2019-01-25 09:05
 */
public class StringRedisMapper
{
    private StringRedisTemplate stringRedisTemplate;

    public StringRedisMapper(StringRedisTemplate template)
    {
        stringRedisTemplate = template;
    }

    public String getValue(String key)
    {
        return stringRedisTemplate.opsForValue().get(key);
    }

    public void setValue(String key, String value)
    {
        stringRedisTemplate.opsForValue().set(key, value);
    }

    public void clearByKey(String key)
    {
        stringRedisTemplate.delete(key);
    }

}
