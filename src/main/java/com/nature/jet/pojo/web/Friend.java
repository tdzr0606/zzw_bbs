package com.nature.jet.pojo.web;

import java.io.Serializable;

/**
 * 
 * Friend
 * Author:竺志伟
 * Date:2018-09-18 20:06:47
 */ 

public class Friend implements Serializable 
{
    private String linkUrl;
    private Integer sortNum;
    private Integer id;
    private String title;

    public String getLinkUrl()
    {
      return linkUrl;
    }

    public void setLinkUrl( String linkUrl)
    {
      this.linkUrl = linkUrl;
    }

    public Integer getSortNum()
    {
      return sortNum;
    }

    public void setSortNum( Integer sortNum)
    {
      this.sortNum = sortNum;
    }

    public Integer getId()
    {
      return id;
    }

    public void setId( Integer id)
    {
      this.id = id;
    }

    public String getTitle()
    {
      return title;
    }

    public void setTitle( String title)
    {
      this.title = title;
    }

}
