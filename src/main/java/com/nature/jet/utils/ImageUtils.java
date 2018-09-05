package com.nature.jet.utils;

import org.apache.commons.codec.binary.Base64;

import java.io.*;

/**
 * 图片转换 utils
 * km_jobs
 * ImageUtils
 *
 * @Author: 竺志伟
 * @Date: 2017-11-02 22:08
 */
public class ImageUtils
{
    /**
     * 根据图片路径,把图片转换为字符串
     *
     * @param imgFilePath
     * @return
     */
    public static String changeImage2String(String imgFilePath)
    {
        File imgFile = new File(imgFilePath);
        if(!imgFile.exists())
        {
            return "";
        }
        byte[] data = new byte[]{};
        try
        {
            InputStream in = new FileInputStream(imgFilePath);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
        return Base64.encodeBase64String(data);// 返回Base64编码过的字节数组字符串
    }


    /**
     * 根据字符串 生成指定路径的图片
     *
     * @param imgStr
     * @param imgFilePath
     * @return
     */
    public static boolean changeString2Image(String imgStr, String imgFilePath)
    {
        if(imgStr == null || imgStr.trim().length() == 0) // 图像数据为空
            return false;
        try
        {
            byte[] bytes = Base64.decodeBase64(imgStr);
            for(int i = 0; i < bytes.length; ++i)
            {
                if(bytes[i] < 0)
                {
                    bytes[i] += 256;
                }
            }
            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(bytes);
            out.flush();
            out.close();
            return true;
        }
        catch(Exception e)
        {
            return false;
        }
    }


    public static void main(String args[])
    {
        String imgPath = "/Users/apple/Desktop/大课堂.jpeg";
        String imgStr = ImageUtils.changeImage2String(imgPath);
        System.out.println(imgStr);
        String outImgPath = "/Users/apple/Desktop/11.jpeg";
        System.out.println(ImageUtils.changeString2Image(imgStr, outImgPath));
    }
}
