package com.post.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.aspectj.util.FileUtil;

import com.post.util.ConfigUtil;


@Action(value="uploadFileAction")
public class UploadFileAction extends BaseAction {

	    private File file;
	    private String fileFileName;
	    private String fileContentType;
	    private String message = "文件上传成功！";

		public String getMessage() {
	        return message;
	    }

	    public void setMessage(String message) {
	        this.message = message;
	    }

	    public File getFile() {
	        return file;
	    }

	    public void setFile(File file) {
	        this.file = file;
	    }

	    public String getFileFileName() {
	        return fileFileName;
	    }

	    public void setFileFileName(String fileFileName) {
	        this.fileFileName = fileFileName;
	    }

	    
	    

	    public String getFileContentType() {
			return fileContentType;
		}

		public void setFileContentType(String fileContentType) {
			this.fileContentType = fileContentType;
		}

		public void upload() {
	    	
			Map<String,Object> m = new HashMap<String,Object>();
	    	boolean state = false;
	    	String msg = "文件上传失败！";
	    	
	    	ServletActionContext.getResponse().setContentType(  
	                "text/html; charset=UTF-8");  
	        // 文件保存目录路径  
	        String savePath = ServletActionContext.getServletContext().getRealPath(  
	                "/")  
	                + "attached\\upload\\";  
	        // 文件保存目录URL  
	        String saveUrl = "/attached/upload/";  
	        // 定义允许上传的文件扩展名  
	  
	     // 定义允许上传的文件扩展名
	     		HashMap<String, String> extMap = new HashMap<String, String>();
	     		extMap.put("image", ConfigUtil.get("image"));
	     		extMap.put("flash", ConfigUtil.get("flash"));
	     		extMap.put("media", ConfigUtil.get("media"));
	     		extMap.put("file", ConfigUtil.get("file"));

	     		long maxSize = Long.parseLong(ConfigUtil.get("maxFileSize")); // 允许上传最大文件大小(字节)
	     		
	     		if (file == null) {  
	                msg="请选择文件!"; 
	                state=false;
	                m.put("msg",msg);
	                m.put("state", state);
	                super.writeJson(m);
	                return ; 
	            }  
	      
	            // 检查目录  
	            File uploadDir = new File(savePath);  
	            if (!uploadDir.isDirectory()) {  
	            	uploadDir.mkdirs();
	            }  
	            // 检查目录写权限  
	            if (!uploadDir.canWrite()) {  
	            	 msg="上传失败，上传目录没有写权限!"; 
		                state=false;
		                m.put("msg",msg);
		                m.put("state", state);
		                super.writeJson(m);
		                return ;  
	            }  
	            String dirName = ServletActionContext.getRequest().getParameter("dir");  
	            if (dirName == null) {  
	                dirName = "file";  
	            }  
	            // 创建文件夹  
	            savePath += dirName + "\\";  
	            saveUrl += dirName + "/";  
	            File saveDirFile = new File(savePath);  
	            if (!saveDirFile.exists()) {  
	      
	                saveDirFile.mkdirs();  
	            }  
	      
	            // 创建文件夹  
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");  
	            String ymd = sdf.format(new Date());  
	            savePath += ymd + "\\";  
	            saveUrl += ymd + "/";  
	            File dirFile = new File(savePath);  
	            if (!dirFile.exists()) {  
	                dirFile.mkdirs();  
	            }  
	            String fileExt = fileFileName.substring(  
	                    fileFileName.lastIndexOf(".") + 1).toLowerCase();  
	            if (!Arrays.<String> asList(extMap.get(dirName).split(",")).contains(  
	                    fileExt)) {  
	            	    msg="上传失败，上传文件扩展名是不允许的扩展名!"; 
		                state=false;
		                m.put("msg",msg);
		                m.put("state", state);
		                super.writeJson(m);
		                return ;  
	            }  
	            if (file.length() > maxSize) { 
	            	 msg="上传失败，文件大小超过允许上传的最大值，最大为【"+ maxSize + " 】。 "; 
		                state=false;
		                m.put("msg",msg);
		                m.put("state", state);
		                super.writeJson(m);
		                return ; 
	            }  
	            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");  
	            String newFileName = df.format(new Date()) + "_"  
	                    + new Random().nextInt(10000) + "." + fileExt;  
	            File uploadedFile = new File(savePath, newFileName);  
	            try {  
	                FileUtil.copyFile(file, uploadedFile); 
	                state = true;
	                msg = "上传文件成功！";
	                m.put("msg",msg);
	                m.put("state", state);
	                m.put("filename", fileFileName);
	                m.put("cfilename", savePath+newFileName);
	                m.put("url", saveUrl+newFileName);
	                super.writeJson(m);
	                return ; 
	      
	            } catch (IOException e) {  
	            	 e.printStackTrace();
	            }  
	    }
}
