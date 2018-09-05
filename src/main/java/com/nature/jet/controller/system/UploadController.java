package com.nature.jet.controller.system;

import com.nature.jet.component.system.CommonResult;
import com.nature.jet.utils.Fields;
import com.nature.jet.utils.Tools;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;

/**
 * Created by taoyuandi on 10/5/14.
 * 文件上传
 */
@Controller
public class UploadController extends BaseController
{

    @Autowired
    HttpServletRequest request;

    Logger logger = LoggerFactory.getLogger(UploadController.class);
    private Set imgSet;
    private Set fileSet;


    public UploadController()
    {
        imgSet = new HashSet<String>();
        imgSet.add("png");
        imgSet.add("jpg");
        imgSet.add("gif");
        imgSet.add("swf");

        fileSet = new HashSet<String>();
        fileSet.add("exe");
        fileSet.add("js");
        fileSet.add("bat");
        fileSet.add("sh");
    }


    /**
     * 图片上传
     * Update img common result.
     *
     * @param imgFile     the img file
     * @param childFile   the child file
     * @param requestType the request type
     * @return the common result
     * @author:竺志伟
     * @date :2018-06-05 17:51:18
     */
    @RequestMapping(value = "/system/upload/img", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateImg(@RequestParam(value = "file", required = true) MultipartFile imgFile,
                                  @RequestParam(value = "childFile", required = true) String childFile,
                                  @RequestParam(value = "requestType", required = false) String requestType)
    {
        String rootPath = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
        String fileName = imgFile.getOriginalFilename();
        String fileExtension = FilenameUtils.getExtension(fileName);
        if(StringUtils.isBlank(requestType))//要求的文件类型为空,按系统要求的文件格式上传
        {
            if(StringUtils.isBlank(fileExtension) || !imgSet.contains(fileExtension.toLowerCase()))
            {
                return resultFailsWrapper("不支持该扩展名的文件,请上传扩展名为png,jpg,gif的图片文件", null);
            }
        }
        else
        {
            if(requestType.indexOf(fileExtension.toLowerCase()) < 0) //要求的文件类型中不包含该文件的扩展名
            {
                return resultFailsWrapper("不支持该扩展名的文件,请上传扩展名为" + requestType + "的文件", null);
            }
        }
        File imagePath = new File(Fields.STATIC_DATA_IMAGE_DIR, childFile);
        File imageFile = new File(imagePath + Tools.timePath(),
                String.format("%s.%s", Tools.timeFileName(), fileExtension.toLowerCase()));
        File imageRealFile = new File(rootPath, imageFile.getPath());
        if(!imageRealFile.getParentFile().exists())
        {
            imageRealFile.getParentFile().mkdirs();
        }
        try
        {
            //思路,如果图片过大,强制按比例压缩到指定宽度
            // 构造Image对象
            BufferedImage src = javax.imageio.ImageIO.read(imgFile.getInputStream());
            if(src.getWidth() > Fields.IMAGE_MAX_WIDTH)
            {
                int width = Fields.IMAGE_MAX_WIDTH;
                int height = src.getHeight() * Fields.IMAGE_MAX_WIDTH / src.getWidth();//按比例，将高度缩减
                BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
                tag.getGraphics().drawImage(src, 0, 0, width, height, null);
                FileOutputStream out = new FileOutputStream(imageRealFile);
                JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
                encoder.encode(tag);
                out.close();
            }
            else
            {
                imgFile.transferTo(imageRealFile);
            }
        }
        catch(IOException e)
        {
            logger.error("Error", e);
            return resultFailsWrapper("服务器异常", null);
        }
        Map data = new HashMap<String, Object>();
        data.put("fileName", fileName);
        data.put("size", imgFile.getSize());
        data.put("serverPath", imageFile.getPath().replaceAll("\\\\", "/"));
        return resultSuccessWrapper("success", data);
    }

    /**
     * 文件上传
     * Update file common result.
     *
     * @param file        the file
     * @param childFile   the child file
     * @param requestType the request type
     * @return the common result
     * @author:竺志伟
     * @date :2018-06-05 17:51:45
     */
    @RequestMapping(value = "/system/upload/file", method = RequestMethod.POST)
    @ResponseBody
    public CommonResult updateFile(@RequestParam(value = "file", required = true) MultipartFile file,
                                   @RequestParam(value = "childFile", required = true) String childFile,
                                   @RequestParam(value = "requestType", required = false) String requestType
    )
    {
        String rootPath = ContextLoader.getCurrentWebApplicationContext().getServletContext().getRealPath("/");
        String fileName = file.getOriginalFilename();
        String fileExtension = FilenameUtils.getExtension(fileName);
        if(StringUtils.isBlank(requestType))//要求的文件类型为空,按系统要求的文件格式上传
        {
            if(StringUtils.isBlank(fileExtension) || fileSet.contains(fileExtension.toLowerCase())) //系统默认的上传文件类型
            {
                return resultFailsWrapper("不支持该扩展名的文件", null);
            }
        }
        else
        {
            if(requestType.indexOf(fileExtension.toLowerCase()) < 0) //要求的文件类型中不包含该文件的扩展名
            {
                return resultFailsWrapper("不支持该扩展名的文件,请上传扩展名为" + requestType + "的文件", null);
            }
        }
        File filePath = new File(Fields.STATIC_DATA_FILE_DIR, childFile);
        File fileFile =
                new File(filePath + Tools.timePath(), String.format("%s.%s", Tools.timeFileName(), fileExtension));
        File fileRealFile = new File(rootPath, fileFile.getPath());
        if(!fileRealFile.getParentFile().exists())
        {
            fileRealFile.getParentFile().mkdirs();
        }
        try
        {
            file.transferTo(fileRealFile);
        }
        catch(IOException e)
        {
            logger.error("Error", e);
            return resultFailsWrapper("服务器异常", null);
        }

        Map data = new HashMap<String, Object>();
        data.put("fileName", fileName.substring(0, fileName.length() - fileExtension.length() - 1));
        data.put("extName", fileExtension);
        data.put("fileSize", file.getSize());
        data.put("serverPath", fileFile.getPath().replaceAll("\\\\", "/"));
        data.put("initName", fileName.replace("." + fileExtension, ""));
        return resultSuccessWrapper("success", data);
    }


}
