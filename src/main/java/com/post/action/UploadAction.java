package com.post.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.aspectj.util.FileUtil;

import com.alibaba.fastjson.JSONObject;
import com.post.util.ConfigUtil;

@Action(value="uploadAction")
public class UploadAction extends BaseAction {
	private File imgFile;  
    /** 
     * 文件名称 
     */  
    private String imgFileFileName;  
  
    /** 
     * 图片宽度 
     */  
    private String imgWidth;  
  
    /** 
     * 图片高度 
     */  
    private String imgHeight;  
  
    /** 
     * 图片对齐方式 
     */  
    private String align;  
  
    /** 
     * 图片标题 
     */  
    private String imgTitle;  
  
    public File getImgFile() {  
        return imgFile;  
    }  
  
    public void setImgFile(File imgFile) {  
        this.imgFile = imgFile;  
    }  
  
    public String getImgFileFileName() {  
        return imgFileFileName;  
    }  
  
    public void setImgFileFileName(String imgFileFileName) {  
        this.imgFileFileName = imgFileFileName;  
    }  
  
    public String getImgWidth() {  
        return imgWidth;  
    }  
  
    public void setImgWidth(String imgWidth) {  
        this.imgWidth = imgWidth;  
    }  
  
    public String getImgHeight() {  
        return imgHeight;  
    }  
  
    public void setImgHeight(String imgHeight) {  
        this.imgHeight = imgHeight;  
    }  
  
    public String getAlign() {  
        return align;  
    }  
  
    public void setAlign(String align) {  
        this.align = align;  
    }  
  
    public String getImgTitle() {  
        return imgTitle;  
    }  
  
    public void setImgTitle(String imgTitle) {  
        this.imgTitle = imgTitle;  
    }  
  
    public String upload() {  
  
        ServletActionContext.getResponse().setContentType(  
                "text/html; charset=UTF-8");  
        // 文件保存目录路径  
        String savePath = ServletActionContext.getServletContext().getRealPath(  
                "/")  
                + "attached/";  
        // 文件保存目录URL  
        String saveUrl = ServletActionContext.getRequest().getContextPath()  
                + "/attached/";  
        // 定义允许上传的文件扩展名  
  
     // 定义允许上传的文件扩展名
     		HashMap<String, String> extMap = new HashMap<String, String>();
     		extMap.put("image", ConfigUtil.get("image"));
     		extMap.put("flash", ConfigUtil.get("flash"));
     		extMap.put("media", ConfigUtil.get("media"));
     		extMap.put("file", ConfigUtil.get("file"));

     		long maxSize = Long.parseLong(ConfigUtil.get("maxFileSize")); // 允许上传最大文件大小(字节)
        PrintWriter out = null;  
        try {  
            out = ServletActionContext.getResponse().getWriter();  
        } catch (IOException e1) {  
  
        }  
  
        if (imgFile == null) {  
            out.println(getError("请选择文件!"));  
            return null;  
        }  
  
        // 检查目录  
        File uploadDir = new File(savePath);  
        if (!uploadDir.isDirectory()) {  
        	uploadDir.mkdirs();
        }  
        // 检查目录写权限  
        if (!uploadDir.canWrite()) {  
            out.println(getError("上传目录没有写权限!"));  
            return null;  
        }  
        String dirName = ServletActionContext.getRequest().getParameter("dir");  
        if (dirName == null) {  
            dirName = "image";  
        }  
        if (!extMap.containsKey(dirName)) {  
            System.out.println(getError("目录名不正确!"));  
            return null;  
        }  
        // 创建文件夹  
        savePath += dirName + "/";  
        saveUrl += dirName + "/";  
        File saveDirFile = new File(savePath);  
        if (!saveDirFile.exists()) {  
  
            saveDirFile.mkdirs();  
        }  
  
        // 创建文件夹  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
        String ymd = sdf.format(new Date());  
        savePath += ymd + "/";  
        saveUrl += ymd + "/";  
        File dirFile = new File(savePath);  
        if (!dirFile.exists()) {  
            dirFile.mkdirs();  
        }  
        String fileExt = imgFileFileName.substring(  
                imgFileFileName.lastIndexOf(".") + 1).toLowerCase();  
        if (!Arrays.<String> asList(extMap.get(dirName).split(",")).contains(  
                fileExt)) {  
            System.out.println(getError("上传文件扩展名是不允许的扩展名。\n只允许"  
                    + extMap.get(dirName) + "格式。"));  
            return null;  
        }  
        if (imgFile.length() > maxSize) {  
            out.println(getError("[ " + imgFileFileName + " ]超过单个文件大小限制，文件大小[ "  
                    + imgFile.length() + " ]，限制为[ " + maxSize + " ] "));  
            return null;  
        }  
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
        String newFileName = imgFileFileName + "_"  
                + new Random().nextInt(1000) + "." + fileExt;  
        File uploadedFile = new File(savePath, newFileName);  
        try {  
            FileUtil.copyFile(imgFile, uploadedFile);  
            JSONObject obj = new JSONObject();  
            obj.put("error", 0);  
            obj.put("url", saveUrl + newFileName);  
  
            out.println(obj.toString());  
  
        } catch (IOException e) {  
  
        }  
        return null;  
    }  
  
    private String getError(String message) {  
        JSONObject obj = new JSONObject();  
        obj.put("error", 1);  
        obj.put("message", message);  
        return obj.toString();  
    }  
}