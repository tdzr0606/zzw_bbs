package com.nature.jet.pojo.web;

import java.io.Serializable;

/**
 * 
 * User
 * Author:竺志伟
 * Date:2018-09-14 22:01:25
 */ 

public class User implements Serializable 
{
    private Boolean isUse;
    private String note;
    private String loginName;
    private String mobile;
    private String loginPass;
    private Integer id;
    private String userName;

    public Boolean getIsUse()
    {
      return isUse;
    }

    public void setIsUse( Boolean isUse)
    {
      this.isUse = isUse;
    }

    public String getNote()
    {
      return note;
    }

    public void setNote( String note)
    {
      this.note = note;
    }

    public String getLoginName()
    {
      return loginName;
    }

    public void setLoginName( String loginName)
    {
      this.loginName = loginName;
    }

    public String getMobile()
    {
      return mobile;
    }

    public void setMobile( String mobile)
    {
      this.mobile = mobile;
    }

    public String getLoginPass()
    {
      return loginPass;
    }

    public void setLoginPass( String loginPass)
    {
      this.loginPass = loginPass;
    }

    public Integer getId()
    {
      return id;
    }

    public void setId( Integer id)
    {
      this.id = id;
    }

    public String getUserName()
    {
      return userName;
    }

    public void setUserName( String userName)
    {
      this.userName = userName;
    }

}
