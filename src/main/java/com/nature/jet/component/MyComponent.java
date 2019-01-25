package com.nature.jet.component;

import com.nature.jet.utils.bean.RedisMapper;
import com.nature.jet.utils.bean.StringRedisMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;

/**
 * 自定义 组件, 创建自定义bean
 * zzw_bbs
 * MyComponent
 *
 * @Author: 竺志伟
 * @Date: 2019-01-25 09:07
 */
@Configuration
public class MyComponent
{
    @Autowired
    StringRedisTemplate stringRedisTemplate;
    @Autowired
    RedisTemplate<String, Object> redisTemplate;

    @Bean
    public StringRedisMapper createStringRedisMapper()
    {
        return new StringRedisMapper(stringRedisTemplate);
    }


    @Bean
    public RedisMapper createRedisMapper()
    {
        return new RedisMapper(redisTemplate);
    }
}
