package com.nature.jet.pojo.web;

import java.io.Serializable;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.nature.jet.converter.CustomDatetimeChange;

import java.sql.Timestamp;

/**
 * Logs
 * Author:竺志伟
 * Date:2018-09-18 10:30:23
 */

public class Logs implements Serializable
{
    private String note;
    @JsonSerialize(using = CustomDatetimeChange.class)
    private Timestamp createTime;
    private String paramStr;
    private String ip;
    private String loginName;
    private String methodName;
    private String className;
    private Integer id;
    private String resultStr;
    private String logsType;

    public String getLogsType()
    {
        return logsType;
    }

    public void setLogsType(String logsType)
    {
        this.logsType = logsType;
    }

    public String getNote()
    {
        return note;
    }

    public void setNote(String note)
    {
        this.note = note;
    }

    public Timestamp getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime)
    {
        this.createTime = createTime;
    }

    public String getParamStr()
    {
        return paramStr;
    }

    public void setParamStr(String paramStr)
    {
        this.paramStr = paramStr;
    }

    public String getIp()
    {
        return ip;
    }

    public void setIp(String ip)
    {
        this.ip = ip;
    }

    public String getLoginName()
    {
        return loginName;
    }

    public void setLoginName(String loginName)
    {
        this.loginName = loginName;
    }

    public String getMethodName()
    {
        return methodName;
    }

    public void setMethodName(String methodName)
    {
        this.methodName = methodName;
    }

    public String getClassName()
    {
        return className;
    }

    public void setClassName(String className)
    {
        this.className = className;
    }

    public Integer getId()
    {
        return id;
    }

    public void setId(Integer id)
    {
        this.id = id;
    }

    public String getResultStr()
    {
        return resultStr;
    }

    public void setResultStr(String resultStr)
    {
        this.resultStr = resultStr;
    }

}
