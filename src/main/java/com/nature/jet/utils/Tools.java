package com.nature.jet.utils;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.RandomStringUtils;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by luo on 2015/8/13.
 */
public class Tools
{
    public static final String YYYY_MM_DD = "yyyy-MM-dd";
    public static final String YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss";
    public static final String YYYY = "yyyy";
    public static final String YMDSTRING = "yyyy年MM月dd日";
    private static final String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式
    private static final String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式
    private static final String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
    private static final String regEx_space = "\\s*|\t|\r|\n";//定义空格回车换行符


    private static final String[] digits = new String[]{"零", "一", "二", "三", "四", "五", "六", "七", "八", "九"};
    private static final String[] radices = new String[]{"", "十", "百", "千"};
    private static final String[] bigRadices = new String[]{"", "万", "亿", "万"};


    /**
     * 获取用户真实IP地址，不使用request.getRemoteAddr();的原因是有可能用户使用了代理软件方式避免真实IP地址,
     * <p>
     * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值，究竟哪个才是真正的用户端的真实IP呢？
     * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。
     * <p>
     * 如：X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130,
     * 192.168.1.100
     * <p>
     * 用户真实IP为： 192.168.1.110
     *
     * @param request
     * @return
     */
    public static String getIpAddress(HttpServletRequest request)
    {
        String ip = request.getHeader("x-forwarded-for");
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * 得到文件转换后的Html文件名
     *
     * @param name
     * @return
     */
    public static String getHtmlName(String name)
    {
        String fileExtension = FilenameUtils.getExtension(name);//得到扩展名
        return name.substring(0, name.length() - fileExtension.length()) + "htm";
    }

    /**
     * 将文本文件中的内容读入到buffer中
     *
     * @param buffer   buffer
     * @param filePath 文件路径
     * @throws IOException 异常
     */
    public static void readToBuffer(StringBuffer buffer, String filePath)
    {
        InputStream is = null;
        String line; // 用来保存每行读取的内容
        try
        {
            is = new FileInputStream(filePath);
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            line = reader.readLine(); // 读取第一行
            while(line != null)
            { // 如果 line 为空说明读完了
                buffer.append(line); // 将读到的内容添加到 buffer 中
                line = reader.readLine(); // 读取下一行
            }
            reader.close();
            is.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    /**
     * 删除单个文件
     *
     * @param sPath 被删除文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public static boolean deleteFile(String sPath)
    {
        boolean flag = false;
        File file = new File(sPath);
        // 路径为文件且不为空则进行删除
        if(file.isFile() && file.exists())
        {
            file.delete();
            flag = true;
        }
        return flag;
    }

    /**
     * 得到完整日期
     *
     * @return
     */
    public static String getSystemDate()
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        return cal.get(Calendar.YEAR) + "年" + (cal.get(Calendar.MONTH) + 1) + "月" + cal.get(Calendar.DAY_OF_MONTH) + "日 " +
                getIntToWeekString(cal.get(Calendar.DAY_OF_WEEK));
    }

    /**
     * 得到完整日期
     *
     * @return
     */
    public static String getSystemDateYMD()
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        return cal.get(Calendar.YEAR) + "年" + (cal.get(Calendar.MONTH) + 1) + "月" + cal.get(Calendar.DAY_OF_MONTH) + "日";
    }

    /**
     * 得到现在的年份
     *
     * @return
     */
    public static Integer getNowYear()
    {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        return cal.get(Calendar.YEAR);
    }

    /**
     * 通过日期得到星期几
     *
     * @param a
     * @return
     */
    public static String getIntToWeekString(int a)
    {
        switch(a % 7)
        {
            case 1:
                return "星期天";
            case 2:
                return "星期一";
            case 3:
                return "星期二";
            case 4:
                return "星期三";
            case 5:
                return "星期四";
            case 6:
                return "星期五";
            case 0:
                return "星期六";
            default:
                return "未知";
        }
    }

    /**
     * 天数转年数
     *
     * @param day 天数
     * @return
     */
    public static Integer day2year(Integer day)
    {
        Integer year = getNowYear();
        if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
            return day / 366;
        else
            return day / 365;
    }

    /**
     * 罗年庆
     * 得到两个日期间的真实年月日
     *
     * @param startDate
     * @param endDate
     * @return
     */
    public static String getBetweenYearMonthDay(Date startDate, Date endDate)
    {
        if(startDate.compareTo(endDate) > 0)
        {
            return "结束时间必须大于开始时间";
        }
        else
        {
            Calendar start = Calendar.getInstance();
            start.setTime(startDate);
            Calendar end = Calendar.getInstance();
            end.setTime(endDate);
            end.add(Calendar.DAY_OF_MONTH, 1);
            end.add(Calendar.DAY_OF_MONTH, -start.get(Calendar.DAY_OF_MONTH));
            end.add(Calendar.MONTH, -start.get(Calendar.MONTH));
            if(end.get(Calendar.YEAR) == start.get(Calendar.YEAR))
            {
                return "0年" + (end.get(Calendar.MONTH)) + "个月" + end.get(Calendar.DAY_OF_MONTH) + "天";
            }
            else
            {
                end.add(Calendar.YEAR, -start.get(Calendar.YEAR));
                return (end.get(Calendar.YEAR)) + "年" + (end.get(Calendar.MONTH)) + "个月" + end.get(Calendar.DAY_OF_MONTH) +
                        "天";
            }
        }

    }

    /**
     * 天数转年月日
     *
     * @param day 天数
     * @return 返回年月日的字符串
     */
    public static String day2ymrStr(Integer day)
    {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, -(calendar.get(Calendar.DAY_OF_MONTH) - 1));
        calendar.add(Calendar.MONTH, -calendar.get(Calendar.MONTH));
        calendar.add(Calendar.YEAR, -calendar.get(Calendar.YEAR));
        calendar.add(Calendar.DAY_OF_MONTH, day - 1);
        if(day > 365)
        {
            return (calendar.get(Calendar.YEAR)) + "年" + (calendar.get(Calendar.MONTH)) + "个月" +
                    calendar.get(Calendar.DAY_OF_MONTH) + "天";
        }
        else
        {
            return (calendar.get(Calendar.YEAR) - 1) + "年" + (calendar.get(Calendar.MONTH)) + "个月" +
                    calendar.get(Calendar.DAY_OF_MONTH) + "天";
        }

    }

    /**
     * 方法描述：日期转换成字符串
     * 创建作者：李兴武
     * 创建日期：2017-05-09 19:17:56
     *
     * @param date   the str
     * @param format the format
     * @return the date
     */
    public static String getFormatDate(Date date, String format)
    {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        if(date == null)
        {
            return "";
        }
        else
        {
            return sdf.format(date);
        }
    }

    /**
     * 方法描述：字符串转换成日期
     * 创建作者：李兴武
     * 创建日期：2017-05-09 19:17:56
     *
     * @param str    the str
     * @param format the format
     * @return the date
     */
    public static Date StrToDate(String str, String format)
    {
        SimpleDateFormat fm = new SimpleDateFormat(format);
        Date date = null;
        try
        {
            date = fm.parse(str);
        }
        catch(ParseException e)
        {
            e.printStackTrace();
        }
        return date;
    }

    public static String getDatetimeToString(Date date)
    {
        return getFormatDate(date, "yyyy-MM-dd HH:ss");
    }

    public static String getMonthDay(Date date)
    {
        return getFormatDate(date, "MM-dd");
    }

    /**
     * 计算两个日期之间相差的天数
     *
     * @param smdate 较小的时间
     * @param bdate  较大的时间
     * @return 相差天数
     * @throws ParseException
     */
    public static int daysBetween(Date smdate, Date bdate)
    {
        if(smdate == null || bdate == null)
        {
            return 0;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try
        {
            smdate = sdf.parse(sdf.format(smdate));
            bdate = sdf.parse(sdf.format(bdate));
            Calendar cal = Calendar.getInstance();
            cal.setTime(smdate);
            long time1 = cal.getTimeInMillis();
            cal.setTime(bdate);
            long time2 = cal.getTimeInMillis();
            long between_days = ((time2 - time1) / (1000 * 3600 * 24)) + 1;
            return Integer.parseInt(String.valueOf(between_days));
        }
        catch(ParseException ignored)
        {
            System.out.println(Tools.class + " daysBetween(Date smdate, Date bdate) ---> error!");
        }
        return 0;
    }

    /**
     * 方法描述：判断当前时间是否在指定时间段内
     * 创建作者：李兴武
     * 创建日期：2017-05-16 18:58:47
     *
     * @param stDate  the 开始 date
     * @param endDate the 结束 date
     * @return the boolean
     */
    public static boolean isBetween(Date stDate, Date endDate)
    {
        Long now = new Date().getTime();
        Long st = stDate.getTime();
        Long end = endDate.getTime();
        return now > st && now <= end;
    }

    /**
     * 得到16位的随机数.此随机数只有大写字母和数字
     *
     * @return
     */
    public static String get16BitRandom()
    {
        return RandomStringUtils.random(16, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
    }

    /**
     * 获取6位随机数字
     *
     * @return the 6 sms code author:袁瑜骏  date: 2018-01-02 10:10:56
     */
    public static String get6Number()
    {
        return RandomStringUtils.random(6, "1234567890");
    }

    public static String get4Mark()
    {
        return RandomStringUtils.random(4, "~!@#$%^&*()_+{}:<>?,./;'[]=-");
    }

    public static String timeFileName()
    {
        SimpleDateFormat sdf = new SimpleDateFormat("dd_HHmmss_S");
        return sdf.format(new Date());
    }

    public static String timePath()
    {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
        return "/" + sdf.format(new Date()) + "/";
    }

    /**
     * 复制文件
     *
     * @param srcFile
     * @param destFile
     * @return
     */
    public static Boolean copyFile(File srcFile, File destFile)
    {
        try
        {
            FileUtils.copyFile(srcFile, destFile, true);
            return destFile.exists();
        }
        catch(IOException e)
        {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * <p> 方法描述：复制文件到当前目录，文件名重新命名. </p>
     * <p> 创建时间：2018-02-02 11:39:01 </p>
     * <p> 创建作者：李兴武 </p>
     *
     * @param rootPath   程序根目录
     * @param srcFileUrl 要复制文件的路径
     * @return 返回复制的文件的名字
     * @author "lixingwu"
     */
    public static String copyFile(String rootPath, String srcFileUrl)
    {
        String oldFilePath = FilenameUtils.getFullPath(srcFileUrl);//原文件的文件夹路径
        String oldFileType = FilenameUtils.getExtension(srcFileUrl);//原文件的扩展名
        //拼接新文件目录：原文件的文件夹路径 + 原文件的文件名 + 时间戳 + 原文件的扩展名
        String newPath = oldFilePath + String.format("%s.%s", Tools.timeFileName(), oldFileType);
        File oldfile = new File(rootPath + srcFileUrl);//原文件
        File newfile = new File(rootPath + newPath);//新文件
        if(copyFile(oldfile, newfile))
        {
            return newPath;
        }
        return null;
    }

    public static Boolean makeSmallImage(File srcFile, File destFile, int width, int height)
    {
        if(srcFile.isFile())
        {
            try
            {
                BufferedImage src = ImageIO.read(srcFile);
                Image image = src.getScaledInstance(width, height, Image.SCALE_DEFAULT);
                BufferedImage desc = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);  //缩放图像
                Graphics g = desc.getGraphics();
                g.drawImage(image, 0, 0, null); // 绘制缩小后的图
                g.dispose();
                ByteArrayOutputStream bos = new ByteArrayOutputStream();
                ImageIO.write(desc, "JPEG", bos);
                FileOutputStream out = new FileOutputStream(destFile);
                out.write(bos.toByteArray());
                out.close();
                return true;
            }
            catch(FileNotFoundException e)
            {
                e.printStackTrace();
                return false;
            }
            catch(IOException e)
            {
                e.printStackTrace();
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    /**
     * @param htmlStr
     * @return 删除Html标签
     */
    public static String delHTMLTag(String htmlStr)
    {
        // 过滤script标签
        Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
        Matcher m_script = p_script.matcher(htmlStr);
        htmlStr = m_script.replaceAll("");
        // 过滤style标签
        Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
        Matcher m_style = p_style.matcher(htmlStr);
        htmlStr = m_style.replaceAll("");
        // 过滤html标签
        Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
        Matcher m_html = p_html.matcher(htmlStr);
        htmlStr = m_html.replaceAll("");
        // 过滤空格回车标签
        Pattern p_space = Pattern.compile(regEx_space, Pattern.CASE_INSENSITIVE);
        Matcher m_space = p_space.matcher(htmlStr);
        htmlStr = m_space.replaceAll("");
        return htmlStr.trim(); // 返回文本字符串
    }

    public static String getTextFromHtml(String htmlStr)
    {
        htmlStr = delHTMLTag(htmlStr);
        htmlStr = htmlStr.replaceAll("&nbsp;", "");
        return htmlStr;
    }

    /**
     * 方法描述：替换html的特殊字符
     * 替换的字符有: & || ♂ ♀ · " ' \r\n \n\r \n \r \t . 空格 ( )
     * 创建作者：李兴武
     * 创建日期：2017-06-22 15:07:37
     *
     * @param string the string
     * @return the string
     */
    public static String escapeHtml(String string)
    {
        if(string != null && string.length() > 0)
        {
            string = string.replaceAll(" |&|\\|\\||♂|♀|·", " ");
            string = string.replaceAll("\"", "”");
            string = string.replaceAll("\'", "’");
            string = string.replaceAll("\r\n|\n\r|\n|\r", "<br/>");
            string = string.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;");
            string = string.replaceAll("\\.", "。");
            string = string.replaceAll(" ", "&nbsp;");
            string = string.replaceAll("\\(", "（");
            string = string.replaceAll("\\)", "）");
            return string;
        }
        else
        {
            return "";
        }
    }

    /**
     * 方法描述：Escape str string.
     * 创建作者：李兴武
     * 创建日期：2017-07-25 17:55:27
     *
     * @param string the string
     * @return the string
     */
    public static String escapeStr(String string)
    {
        if(string != null && string.length() > 0)
        {
            string = string.replaceAll("\"", "”");
            string = string.replaceAll("\'", "’");
            string = string.replaceAll("\\(", "（");
            string = string.replaceAll("\\)", "）");
            return string;
        }
        else
        {
            return "";
        }
    }


    /**
     * 方法描述：自定义判断是否为空
     * 创建作者：李兴武
     * 创建日期：2017-06-22 19:50:01
     *
     * @param str the str
     * @return the boolean
     */
    public static Boolean isBlank(String str)
    {
        if(str != null)
            str = str.replaceAll("\r\n|\n\r|\n|\r|\f|\t", "");
        if(str == null)
            return true;
        else if(str.equals(""))
            return true;
        else if(str.equals("null"))
            return true;
        else if(str.equals("NULL"))
            return true;
        else if(str.equals("(null)"))
            return true;
        else if(str.equals("(NULL)"))
            return true;
        else if(str.trim().length() == 0)
            return true;
        return false;
    }

    /**
     * 方法描述：判断obj是否为空
     * 创建作者：李兴武
     * 创建日期：2017-06-22 19:50:01
     *
     * @param obj the 判断的对象
     * @return the boolean
     */
    public static Boolean isBlank(Object obj)
    {
        if(obj != null)
        {
            return isBlank(String.valueOf(obj));
        }
        return true;
    }

    /**
     * 随机指定范围内N个不重复的数
     * 利用HashSet的特征，只能存放不同的值
     *
     * @param min          指定范围最小值
     * @param max          指定范围最大值
     * @param n            随机数个数
     * @param set<Integer> set 随机数结果集
     */
    public static void randomSet(int min, int max, int n, Set<Integer> set)
    {
        if(n > (max - min + 1) || max < min)
        {
            return;
        }
        for(int i = 0; i < n; i++)
        {
            // 调用Math.random()方法
            int num = (int) (Math.random() * (max - min)) + min;
            set.add(num);// 将不同的数存入HashSet中
        }
        int setSize = set.size();
        // 如果存入的数小于指定生成的个数，则调用递归再生成剩余个数的随机数，如此循环，直到达到指定大小
        if(setSize < n)
        {
            randomSet(min, max, n - setSize, set);// 递归
        }
    }

    /**
     * 方法描述：比较字符串形式的数组
     * 创建作者：李兴武
     * 创建日期：2017-07-13 17:30:26
     *
     * @param arrStr1 字符串数组1
     * @param arrStr2 字符串数组1
     * @param regex   组合分隔符
     * @return true:相同
     */
    public static boolean equalsArrStr(String arrStr1, String arrStr2, String regex)
    {
        if(arrStr1.trim().length() > 0 && arrStr2.trim().length() > 0)
        {
            String[] arr1 = arrStr1.split(regex);
            String[] arr2 = arrStr2.split(regex);
            Arrays.sort(arr1);
            Arrays.sort(arr2);
            return Arrays.equals(arr1, arr2);
        }
        return false;
    }

    /**
     * 根据字数  获取 证书打印的 css样式
     *
     * @param num
     * @return
     */
    public static String getCerNoPrintCSS(int num)
    {
        String css = "charset-m";
        if(num > 12 && num <= 20)
        {
            css = "charset-s";
        }
        else if(num > 20)
        {
            css = "charset-ss";
        }
        return css;
    }

    /**
     * 补齐流水号
     *
     * @param num
     * @return
     */
    public static String createMaxLiushuihao(Integer num)
    {
        StringBuffer resultSB = new StringBuffer();
        for(int i = 4, len = num.toString().length(); i > len; i--)
        {
            resultSB.append("0");
        }
        resultSB.append(num);
        return resultSB.toString();
    }

    /**
     * 方法描述: 根据reportId和当前时间生成文件名.
     * 创建日期: 2017-06-37 20:37:55
     * 创建作者: 李兴武
     *
     * @param reportId 申报表id
     * @return 不带后缀的文件名
     */
    public static String getDataFileName(Integer reportId)
    {
        if(null == reportId)
            return "";
        StringBuilder str = new StringBuilder();
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        str.append(reportId.toString());
        str.append("_");
        str.append(cal.get(Calendar.YEAR));
        str.append("_");
        str.append(cal.get(Calendar.MONTH) + 1);
        str.append("_");
        str.append(cal.get(Calendar.DAY_OF_MONTH));
        str.append("_");
        str.append(cal.get(Calendar.HOUR_OF_DAY));
        str.append("_");
        str.append(cal.get(Calendar.MINUTE));
        str.append("_");
        str.append(cal.get(Calendar.SECOND));
        return str.toString();
    }

    /**
     * 文字UTF8转换
     *
     * @Author:竺志伟
     * @Date: 2017/9/12 下午5:54
     */
    public static String urlDecode(String value)
    {
        try
        {
            return URLDecoder.decode(value, "UTF-8");
        }
        catch(Exception e)
        {
            return "";
        }
    }


    /**
     * 格式化null字符串
     * Formate null string string.
     *
     * @param value the value
     * @return the string
     * @author:竺志伟
     * @date :2017-12-22 16:18:44
     */
    public static String formateNullString(String value)
    {
        return (null == value) ? "" : value;
    }


    /**
     * 根据年份获取申报批次
     * Gets report batch.
     *
     * @param year the year
     * @return the report batch
     * @author:竺志伟
     * @date :2017-12-28 10:00:02
     */
    public static String getReportBatch(int year)
    {
        return "第" + convertNum2Str((year - 2001) + "") + "批";
    }


    /**
     * 数字转中文
     * Convert num 2 str string.
     *
     * @param currencyDigits the currency digits
     * @return the string
     * @author:竺志伟
     * @date :2017-12-28 10:05:16
     */
    public static String convertNum2Str(String currencyDigits)
    {
        String integral = null;                // 整数部分
        String decimal = null;                    // 小数部分
        String outputCharacters = null;        // 最终转换输出结果
        String d = null;
        int zeroCount = 0, p = 0, quotient = 0, modulus = 0;
        currencyDigits = currencyDigits.replace("/,/g", "");    // 删除数字中的逗号,
        currencyDigits = currencyDigits.replace("/^0+/", "");    // 删除数字左边的0
        String[] parts = currencyDigits.split("\\.");            // 拆分数字中的整数与小数部分
        if(parts.length > 1)
        {
            integral = parts[0];
            decimal = parts[1];
            if(decimal.length() > 2)
            {                            // 如果小数部分长度大于2，四舍五入，保留两位小数
                long dd = Math.round(Double.parseDouble("0." + decimal) * 100);
                decimal = Long.toString(dd);
            }
        }
        else
        {
            integral = parts[0];
            decimal = "0";
        }
        outputCharacters = "";
        if(Double.parseDouble(integral) > 0)
        {
            zeroCount = 0;
            for(int i = 0; i < integral.length(); i++)
            {
                p = integral.length() - i - 1;
                d = integral.substring(i, i + 1);
                quotient = p / 4;
                modulus = p % 4;
                if(d.equals("0"))
                {
                    zeroCount++;
                }
                else
                {
                    if(zeroCount > 0)
                        outputCharacters += digits[0];
                    zeroCount = 0;
                    outputCharacters += digits[Integer.parseInt(d)] + radices[modulus];
                }
                if(modulus == 0 && zeroCount < 4)
                    outputCharacters += bigRadices[quotient];
            }
        }
        if(Double.parseDouble(decimal) > 0)
            for(int i = 0; i < decimal.length(); i++)
                d = decimal.substring(i, i + 1);
        return outputCharacters;
    }

    /**
     * 判断传入类型是否是图片
     *
     * @param type the type
     * @return the boolean author:袁瑜骏  date: 2018-02-06 16:22:47
     */
    public static boolean isImage(String type)
    {
        String[] strs = {"jpg", "gif", "png"};
        return Arrays.asList(strs).contains(type);
    }


    /**
     * 计算文件大小
     *
     * @param bytes the bytes
     * @return the string author:袁瑜骏  date: 2018-02-09 15:28:12
     */
    public static String bytesToSize(long bytes)
    {
        if(bytes == 0)
        {
            return "0 B";
        }
        String[] sizes = {"B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"};
        int b = (int) Math.floor(Math.log(bytes) / Math.log(1024));
        double c = bytes / Math.pow(1024, b);
        String d = String.format("%.2f", c) + " " + sizes[b];
        return d;
    }

    /**
     * 判断string是否是数字
     *
     * @param str
     * @return
     */
    public static boolean isInteger(String str)
    {
        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");
        return pattern.matcher(str).matches();
    }


    /**
     * Change integer to boolean boolean.
     *
     * @param value the value
     * @return the boolean
     * @author:竺志伟
     * @date :2018-06-26 11:33:31
     */
    public static boolean changeIntegerToBoolean(Integer value)
    {
        if(null == value || value.intValue() == 0)
        {
            return false;
        }
        return true;
    }
}
