package com.nature.jet.converter;
import org.springframework.core.convert.converter.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringToIntegerArray implements Converter<String, Integer[]>
{
    @Override
    public Integer[] convert(String params)
    {
        if (params == null || params.equals(""))
        {
            return null;
        }
        else
        {
            String tempStr[]=params.split(",");
            Integer tempInt[]=new Integer[tempStr.length];
            for(int i=0;i<tempStr.length;i++)
            {
                tempInt[i]=Integer.parseInt(tempStr[i]);
            }
            return tempInt;
        }
    }
}
