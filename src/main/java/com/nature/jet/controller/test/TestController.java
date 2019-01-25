package com.nature.jet.controller.test;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.controller.system.BaseController;
import com.nature.jet.utils.bean.RedisMapper;
import com.nature.jet.utils.bean.StringRedisMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;


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
    StringRedisMapper stringRedisMapper;
    @Autowired
    RedisMapper redisMapper;

    @RequestMapping(value = "/test/redis1")
    @ResponseBody
    public CommonResult test()
    {
        stringRedisMapper.setValue("aa", "aaaa");
        return resultSuccessWrapper("aa", null);
    }


    @RequestMapping(value = "/test/redis2")
    @ResponseBody
    public CommonResult test2()
    {
        return resultSuccessWrapper(stringRedisMapper.getValue("aa"), null);
    }

    @RequestMapping(value = "/test/redis3")
    @ResponseBody
    public CommonResult test3()
    {
        stringRedisMapper.clearByKey("aa");
        return resultSuccessWrapper(stringRedisMapper.getValue("aa"), null);
    }


    @RequestMapping(value = "/test/redis11")
    @ResponseBody
    public CommonResult test11()
    {
        redisMapper.setStringValue("aa", "bb");
        return resultSuccessWrapper("aa", null);
    }

    @RequestMapping(value = "/test/redis22")
    @ResponseBody
    public CommonResult test22()
    {
        return resultSuccessWrapper(redisMapper.getStringValue("aa"), null);
    }

    @RequestMapping(value = "/test/redis33")
    @ResponseBody
    public CommonResult test33()
    {
        redisMapper.clearByKey("aa");
        return resultSuccessWrapper(redisMapper.getStringValue("aa"), null);
    }


    @RequestMapping(value = "/test/redis111")
    @ResponseBody
    public CommonResult test111()
    {
        List<String> list = new ArrayList<>();
        list.add("a");
        list.add("1");
        redisMapper.setListValue("aaa", list);
        return resultSuccessWrapper(",,", null);
    }


    @RequestMapping(value = "/test/redis222")
    @ResponseBody
    public CommonResult test222()
    {
        List<String> aa = redisMapper.getListValue("aaa");
        for(String a : aa)
        {
            logger.info("aa:{}", a);
        }
        return resultSuccessWrapper("", null);
    }

}
