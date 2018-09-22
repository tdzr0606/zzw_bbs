package com.nature.jet.service.bbs;

import com.github.pagehelper.ISelect;
import com.github.pagehelper.PageHelper;
import com.nature.jet.component.system.Page;
import com.nature.jet.mapper.bbs.BbsUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nature.jet.pojo.bbs.BbsUser;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * BbsUserService
 * Author:竺志伟
 * Date:2018-09-18 20:57:03
 */
@Service
public class BbsUserService
{
    @Autowired
    BbsUserMapper bbsUserMapper;

    /**
     * 获取分页数据
     *
     * @param cusPage
     * @param pageSize
     * @param key
     * @return
     */
    public Page<BbsUser> listPage(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsUserMapper.list(key);
            }
        }));
    }

    /**
     * 创建数据
     *
     * @param bbsUser
     * @return
     */
    public boolean addNew(BbsUser bbsUser)
    {
        return bbsUserMapper.add(bbsUser) == 1;
    }

    /**
     * 修改数据
     *
     * @param bbsUser
     * @return
     */
    public boolean modify(BbsUser bbsUser)
    {
        return bbsUserMapper.modify(bbsUser) == 1;
    }

    /**
     * 删除数据
     *
     * @param ids
     * @return
     */
    public void deleteByIds(String[] ids)
    {
        bbsUserMapper.deleteByIds(ids);
    }

    /**
     * 获取单一数据
     *
     * @param id
     * @return
     */
    public BbsUser getInfoById(int id)
    {
        return (BbsUser) bbsUserMapper.findById(id);
    }

    public boolean checkLoginName(String loginName)
    {
        return bbsUserMapper.checkLoginName(loginName) == 0;
    }

    public boolean use(String[] ids)
    {
        return bbsUserMapper.use(ids) > 0;
    }


    /**
     * 主题 版主选择
     * List master page.
     *
     * @param cusPage  the cus page
     * @param pageSize the page size
     * @param key      the key
     * @return the page
     * @author:竺志伟
     * @date :2018-09-20 15:34:21
     */
    public Page<BbsUser> listMaster(int cusPage, int pageSize, String key)
    {
        return new Page<>(PageHelper.startPage(cusPage, pageSize).doSelectPageInfo(new ISelect()
        {
            @Override
            public void doSelect()
            {
                bbsUserMapper.listMaster(key);
            }
        }));
    }

    /**
     * 回帖榜
     * List back list.
     *
     * @return the list
     * @author:竺志伟
     * @date :2018-09-20 15:37:22
     */
    public List<BbsUser> listBack()
    {
        return bbsUserMapper.listBack();
    }

    /**
     * bbs 登录
     * Login bbs user.
     *
     * @param loginName the login name
     * @param loginPass the login pass
     * @return the bbs user
     * @author:竺志伟
     * @date :2018-09-21 23:26:03
     */
    public BbsUser login(String loginName, String loginPass)
    {
        Map<String, String> map = new HashMap<>();
        map.put("loginName", loginName);
        map.put("loginPass", loginPass);
        return bbsUserMapper.login(map);
    }


    /**
     * 更新登录状态
     * Update login.
     *
     * @param id            the id
     * @param lastLoginIP   the last login ip
     * @param lastLoginTime the last login time
     * @author:竺志伟
     * @date :2018-09-22 09:54:12
     */
    public void updateLogin(int id, String lastLoginIP, Timestamp lastLoginTime)
    {
        Map<String, Object> map = new HashMap<>();
        map.put("id", id);
        map.put("lastLoginIP", lastLoginIP);
        map.put("lastLoginTime", lastLoginTime);
        bbsUserMapper.updateLogin(map);
    }


    /**
     * 昵称验证
     * Check user name boolean.
     *
     * @param userName the user name
     * @return the boolean
     * @author:竺志伟
     * @date :2018-09-22 10:18:31
     */
    public boolean checkUserName(String userName)
    {
        return bbsUserMapper.checkUserName(userName) == 0;
    }
}
