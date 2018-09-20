package com.nature.jet.pojo.bbs;

import java.io.Serializable;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.nature.jet.converter.CustomDatetimeChange;
import java.sql.Timestamp;

/**
 * 
 * BbsBbs
 * Author:竺志伟
 * Date:2018-09-20 13:45:48
 */ 

public class BbsBbs implements Serializable 
{
    private Integer createId;
    private Integer replyId;
    private Integer replyNum;
    private Boolean isPublic;
    private Integer sortNum;
    private Integer typeId;
    private Integer id;
    private String typeTitle;
    private String title;
    private String content;
    private String createName;
   @JsonSerialize(using = CustomDatetimeChange.class)
    private Timestamp createDateTime;

    public Integer getCreateId()
    {
      return createId;
    }

    public void setCreateId( Integer createId)
    {
      this.createId = createId;
    }

    public Integer getReplyId()
    {
      return replyId;
    }

    public void setReplyId( Integer replyId)
    {
      this.replyId = replyId;
    }

    public Integer getReplyNum()
    {
      return replyNum;
    }

    public void setReplyNum( Integer replyNum)
    {
      this.replyNum = replyNum;
    }

    public Boolean getIsPublic()
    {
      return isPublic;
    }

    public void setIsPublic( Boolean isPublic)
    {
      this.isPublic = isPublic;
    }

    public Integer getSortNum()
    {
      return sortNum;
    }

    public void setSortNum( Integer sortNum)
    {
      this.sortNum = sortNum;
    }

    public Integer getTypeId()
    {
      return typeId;
    }

    public void setTypeId( Integer typeId)
    {
      this.typeId = typeId;
    }

    public Integer getId()
    {
      return id;
    }

    public void setId( Integer id)
    {
      this.id = id;
    }

    public String getTypeTitle()
    {
      return typeTitle;
    }

    public void setTypeTitle( String typeTitle)
    {
      this.typeTitle = typeTitle;
    }

    public String getTitle()
    {
      return title;
    }

    public void setTitle( String title)
    {
      this.title = title;
    }

    public String getContent()
    {
      return content;
    }

    public void setContent( String content)
    {
      this.content = content;
    }

    public String getCreateName()
    {
      return createName;
    }

    public void setCreateName( String createName)
    {
      this.createName = createName;
    }

    public Timestamp getCreateDateTime()
    {
      return createDateTime;
    }

    public void setCreateDateTime( Timestamp createDateTime)
    {
      this.createDateTime = createDateTime;
    }

}
