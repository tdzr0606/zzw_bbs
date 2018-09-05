package com.nature.jet.utils;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.MappingJsonFactory;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.StringWriter;
import java.util.*;

public class JsonUtils
{
    static Logger logger = LoggerFactory.getLogger(JsonUtils.class);
    public static final String JSON_NORMAL = "NORMAL";
    public static final String JSON_EXCEMPTY = "EXCEMPTY";
    public static final String JSON_EXCNULL = "EXCNULL";

    public static String toArrayJson(List list, String type)
    {
        String temp = "";
        if(list.size() < 1)
            return temp;
        switch(type)
        {
            case JsonUtils.JSON_NORMAL:
                return JsonUtils.toJson(list, null);
            case JsonUtils.JSON_EXCEMPTY:
                return JsonUtils.toJson(list, JsonInclude.Include.NON_EMPTY);
            case JsonUtils.JSON_EXCNULL:
                return JsonUtils.toJson(list, JsonInclude.Include.NON_NULL);
            default:
                return temp;
        }
    }

    public static String toJson(Object object, JsonInclude.Include includeType)
    {
        MappingJsonFactory f = new MappingJsonFactory();
        ObjectMapper mapper = f.getCodec();
        if(includeType != null)
        {
            mapper.setSerializationInclusion(includeType);
        }
        StringWriter sw = new StringWriter();
        try
        {
            JsonGenerator generator = f.createGenerator(sw);
            generator.writeObject(object);
            generator.close();
        }
        catch(Exception e)
        {
            logger.error("error", e);
            return "";
        }
        return sw.toString();
    }

    public static <T> T parseJson(String jsonString, Class<T> c)
    {
        if(StringUtils.isBlank(jsonString))
            return null;
        MappingJsonFactory f = new MappingJsonFactory();
        ObjectMapper mapper = f.getCodec();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        try
        {
            JsonParser parser = f.createParser(jsonString);
            return parser.readValueAs(c);
        }
        catch(Exception e)
        {
            logger.error("Error", e);
            return null;
        }
    }

    public static Map<String, Object> parseJSONMap(String jsonStr) throws IOException
    {
        if(StringUtils.isBlank(jsonStr))
            return null;
        ObjectMapper mapper = new ObjectMapper();
        Map map = mapper.readValue(jsonStr, Map.class);
        return map;
    }

    /**
     * 把JSON字符串转化为List
     *
     * @param jsonString 要转化的字符串
     * @param type       对应类的Class
     * @param <T>
     * @return
     */
    public static <T> List<T> JSONArray(String jsonString, Class<T> type)
    {
        MappingJsonFactory f = new MappingJsonFactory();
        ObjectMapper mapper = f.getCodec();
        JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, type);
        try
        {
            if(jsonString != null && jsonString.length() > 20)
            {
                return mapper.readValue(jsonString, javaType);
            }
            else
            {
                return new ArrayList<T>();
            }

        }
        catch(Exception e)
        {
            logger.error("Error", e);
            return new ArrayList<T>();
        }
    }

    public static void main(String args[]) throws IOException
    {

              /*User one = new User();
        User two = new User();
        List<User> li = new ArrayList<User>();
        one.setName("\"~!@#$%^&*()_+`1234567890-={}|:<>?[];',./'");
        li.add(one);
        li.add(two);*/
        /*System.out.println(JsonUtils.toJson(li,null));
        String str=JsonUtils.toJson(li,null);
        List<User> li2=JsonUtils.JSONArray(str,User.class);
        for(int i=0;i<li2.size();i++)
        {
            System.out.println(li2.get(i).getName());
        }*/

        //System.out.println(JsonUtils.toArrayJson(li, JsonUtils.JSON_NORMAL));
        //String jsonString = "[{\"id\":44,\"userId\":1,\"school\":\"告诉\",\"specialty\":\"撒大声地\",\"graDate\":1490716800000,\"culture\":\"硕士研究生\",\"degree\":\"硕士\",\"eduType\":\"全日制教育\",\"isDefault\":true,\"sort\":1.00},{\"id\":42,\"userId\":1,\"school\":\"0\",\"specialty\":\"0\",\"graDate\":1492531200000,\"culture\":\"本科\",\"degree\":\"硕士\",\"eduType\":\"在职教育\",\"isDefault\":true,\"sort\":1.00},{\"id\":41,\"userId\":1,\"school\":\"个\",\"specialty\":\"淘宝\",\"graDate\":1491321600000,\"culture\":\"硕士研究生\",\"degree\":\"硕士\",\"eduType\":\"全日制教育\",\"isDefault\":false,\"sort\":1.00},{\"id\":36,\"userId\":1,\"school\":\"阿斯顿发射点发生\",\"specialty\":\"发射点发生\",\"graDate\":1491926400000,\"culture\":\"硕士研究生\",\"degree\":\"硕士\",\"eduType\":\"在职教育\",\"isDefault\":false,\"sort\":1.00}]";
        /*List<UserEdu> l = JSON.parseArray(jsonString, UserEdu.class);
        for(UserEdu userEdu:l){
            System.out.println(userEdu.toString());
        }*/

        //System.out.println(JSONObject.toJSONString(li));
    }
}