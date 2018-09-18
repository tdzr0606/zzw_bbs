package com.nature.jet.pojo.web;

import java.io.Serializable;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.nature.jet.converter.CustomDateChange;

import java.util.Date;

/**
 * BbsUser
 * Author:竺志伟
 * Date:2018-09-18 20:57:03
 */

public class BbsUser implements Serializable
{
    private Boolean isUse;
    private String note;
    private String mobile;
    private Integer postNum;
    private String userName;
    private String lastLoginIP;
    private String imgUrl;
    private String lastLoginTime;
    private Integer backNum;
    private String loginName;
    private String loginPass;
    private Integer id;
    @JsonSerialize(using = CustomDateChange.class)
    private Date registerDate;

    public Boolean getIsUse()
    {
        return isUse;
    }

    public void setIsUse(Boolean isUse)
    {
        this.isUse = isUse;
    }

    public String getNote()
    {
        return note;
    }

    public void setNote(String note)
    {
        this.note = note;
    }

    public String getMobile()
    {
        return mobile;
    }

    public void setMobile(String mobile)
    {
        this.mobile = mobile;
    }

    public Integer getPostNum()
    {
        return postNum;
    }

    public void setPostNum(Integer postNum)
    {
        this.postNum = postNum;
    }

    public String getUserName()
    {
        return userName;
    }

    public void setUserName(String userName)
    {
        this.userName = userName;
    }

    public String getLastLoginIP()
    {
        return lastLoginIP;
    }

    public void setLastLoginIP(String lastLoginIP)
    {
        this.lastLoginIP = lastLoginIP;
    }

    public String getImgUrl()
    {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl)
    {
        this.imgUrl = imgUrl;
    }

    public String getLastLoginTime()
    {
        return lastLoginTime;
    }

    public void setLastLoginTime(String lastLoginTime)
    {
        this.lastLoginTime = lastLoginTime;
    }

    public Integer getBackNum()
    {
        return backNum;
    }

    public void setBackNum(Integer backNum)
    {
        this.backNum = backNum;
    }

    public String getLoginName()
    {
        return loginName;
    }

    public void setLoginName(String loginName)
    {
        this.loginName = loginName;
    }

    public String getLoginPass()
    {
        return loginPass;
    }

    public void setLoginPass(String loginPass)
    {
        this.loginPass = loginPass;
    }

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public Date getRegisterDate()
    {
        return registerDate;
    }

    public void setRegisterDate(Date registerDate)
    {
        this.registerDate = registerDate;
    }

}
