package com.post.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;


@Action(value="downAction",results = {
		@Result(name = "download", type = "stream", params = {  
        "contentType", "application/octet-stream",  
        "inputName", "inputStream", "contentDisposition",  
        "attachment;filename=\"${downloadFileName}\"", "bufferSize",  
        "4096" })})  
public class DownAction extends BaseAction {
	
	private String filename;
	private String filepath;
	
	



	public String getFilepath() {
		return filepath;
	}





	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}





	public String getFilename() {
		return filename;
	}





	public void setFilename(String filename) throws UnsupportedEncodingException {
		 String agent = ServletActionContext. getRequest().getHeader("User-agent"); 
		 if(agent.contains("MSIE")){  
	          this.filename = URLEncoder.encode(filename, "UTF-8");  
	        }else{  
	           this.filename =new String(filename.getBytes(),"ISO-8859-1");    
	        }  
	    }  





	public String download(){
		return "download";
	}
	
	public String getDownloadFileName(){
		return filename;
	}
	
	 public InputStream getInputStream() throws Exception { 
		 String savePath = ServletActionContext.getServletContext().getRealPath(filepath); 
		 return new FileInputStream(new File(savePath));  
}  
	
}
