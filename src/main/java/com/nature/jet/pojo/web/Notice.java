package com.nature.jet.pojo.web;

import java.io.Serializable;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.nature.jet.converter.CustomDatetimeChange;
import java.sql.Timestamp;

/**
 * 
 * Notice
 * Author:竺志伟
 * Date:2018-09-18 15:54:02
 */ 

public class Notice implements Serializable 
{
    private Boolean isPublic;
    private Integer id;
    private String title;
    private String createName;
    private String content;
   @JsonSerialize(using = CustomDatetimeChange.class)
    private Timestamp createDate;

    public Boolean getIsPublic()
    {
      return isPublic;
    }

    public void setIsPublic( Boolean isPublic)
    {
      this.isPublic = isPublic;
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

    public String getCreateName()
    {
      return createName;
    }

    public void setCreateName( String createName)
    {
      this.createName = createName;
    }

    public String getContent()
    {
      return content;
    }

    public void setContent( String content)
    {
      this.content = content;
    }

    public Timestamp getCreateDate()
    {
      return createDate;
    }

    public void setCreateDate( Timestamp createDate)
    {
      this.createDate = createDate;
    }

}
