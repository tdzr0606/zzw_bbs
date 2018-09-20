package com.nature.jet.pojo.bbs;

import java.io.Serializable;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.nature.jet.converter.CustomDatetimeChange;

import java.sql.Timestamp;

/**
 * BbsType
 * Author:竺志伟
 * Date:2018-09-19 09:57:51
 */

public class BbsType implements Serializable
{
    private String imgUrl;
    private Boolean isUse;
    private String masterId;
    private String note;
    private Integer postNum;
    private String lastPoster;
    private Integer id;
    private String title;
    @JsonSerialize(using = CustomDatetimeChange.class)
    private Timestamp createDate;
    private String masterName;
    @JsonSerialize(using = CustomDatetimeChange.class)
    private Timestamp lastPostDate;
    private Integer sortNum;

    public Integer getSortNum()
    {
        return sortNum;
    }

    public void setSortNum(Integer sortNum)
    {
        this.sortNum = sortNum;
    }

    public String getImgUrl()
    {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl)
    {
        this.imgUrl = imgUrl;
    }

    public Boolean getIsUse()
    {
        return isUse;
    }

    public void setIsUse(Boolean isUse)
    {
        this.isUse = isUse;
    }

    public String getMasterId()
    {
        return masterId;
    }

    public void setMasterId(String masterId)
    {
        this.masterId = masterId;
    }

    public String getNote()
    {
        return note;
    }

    public void setNote(String note)
    {
        this.note = note;
    }

    public Integer getPostNum()
    {
        return postNum;
    }

    public void setPostNum(Integer postNum)
    {
        this.postNum = postNum;
    }

    public String getLastPoster()
    {
        return lastPoster;
    }

    public void setLastPoster(String lastPoster)
    {
        this.lastPoster = lastPoster;
    }

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public Timestamp getCreateDate()
    {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate)
    {
        this.createDate = createDate;
    }

    public String getMasterName()
    {
        return masterName;
    }

    public void setMasterName(String masterName)
    {
        this.masterName = masterName;
    }

    public Timestamp getLastPostDate()
    {
        return lastPostDate;
    }

    public void setLastPostDate(Timestamp lastPostDate)
    {
        this.lastPostDate = lastPostDate;
    }

}
