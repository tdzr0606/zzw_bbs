package com.nature.jet.controller.test;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.controller.system.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.concurrent.TimeUnit;

/**
 * zzw_bbs
 * TestController
 *
 * @Author: 竺志伟
 * @Date: 2019-01-24 16:47
 */
@Controller
public class TestController extends BaseController
{
    @Autowired
    StringRedisTemplate stringRedisTemplate;

    @RequestMapping(value = "/test/redis1")
    @ResponseBody
    public CommonResult test()
    {
        stringRedisTemplate.opsForValue().set("a","a",10, TimeUnit.SECONDS);
        return resultSuccessWrapper("aa",stringRedisTemplate.opsForValue().get("a"));
    }
}
