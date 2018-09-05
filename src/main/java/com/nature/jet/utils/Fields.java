package com.nature.jet.utils;

/**
 * Created by taoyuandi on 8/9/14.
 * 定义静态的字符
 */
public class Fields
{

    public static final String STATIC_DATA_IMAGE_DIR = "/fileUpload/images";
    public static final String STATIC_DATA_FILE_DIR = "/fileUpload/files";
    public static final Long IMAGE_MAX_SIZE = 5242880l;
    public static final Integer IMAGE_MAX_WIDTH = 2048;//html上的图片保存的最大宽度
    public static final Integer IMAGE_MIN_WIDTH = 400;
    public static final Integer IMAGE_MIN_HEIGHT = 300;
    public static final Boolean IMAGE_PICK_MORE = true; //是否提取多张图片,如果多张,会用@@@@隔开
    public static final Boolean IMAGE_NEED_ZIP = true; //是否压缩,如果压缩,会生成带S的图片
    public static final Integer IMAGE_ZIP_WIDTH = 400;
    public static final Integer IMAGE_ZIP_HEIGHT = 300;

    public static final String NEW_LINE_CHAR = "\r";



    public static final String CODE_SESSION_LOGIN = "loginUserCode"; //后台管理session验证码存储名称
    public static final String SESSION_LOGIN = "loginUser"; //后台管理登录用户session存储名称
    public static final String SESSION_LOGIN_P_FUNCTION_LEFT = "loginUserPFunctionLeft"; //后台管理登录用户父级功能 session存贮名称
    public static final String SESSION_LOGIN_P_FUNCTION_TOP = "loginUserPFunctionTop";
    public static final String SESSION_LOGIN_S_FUNCTION = "loginUserSFunction"; //后台管理登录用户子级功能 session存贮名称

    public static final String SESSION_LOGIN_WX = "loginUserWx"; //微信小程序 登录用户 session存储名称



}
