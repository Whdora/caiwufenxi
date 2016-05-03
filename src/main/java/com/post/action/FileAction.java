package com.post.action;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.File;
import com.post.pageModel.Json;
import com.post.service.FileServiceI;

/**
 * 文件
 */
@Action(value = "fileAction", results = {
		@Result(name = "fileManager", location = "/busi/file/fileManager.jsp"),
		@Result(name = "fileAdd", location = "/busi/file/fileAdd.jsp"),
		@Result(name = "fileEdit", location = "/busi/file/fileEdit.jsp"),
		@Result(name = "showContent", location = "/busi/file/showContent.jsp")})
public class FileAction extends BaseAction implements ModelDriven<File> {

	private File file = new File();
	private FileServiceI fileService;

	public FileServiceI getFileService() {
		return fileService;
	}

	@Autowired
	public void setFileService(FileServiceI fileService) {
		this.fileService = fileService;
	}

	@Override
	public File getModel() {
		return file;
	}

	public String fileManager() {
		return "fileManager";
	}

	public String fileAdd() {
		return "fileAdd";
	}

	public String fileEdit() {
		return "fileEdit";
	}

	public void do_datagrid() {
		super.writeJsonDate(fileService.datagrid(file));
	}

	public void add() {
		Json j = new Json();
		try {
			fileService.add(file);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}

	public void edit() {
		Json j = new Json();
		try {
			fileService.edit(file);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		fileService.delete(file);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	public void do_combobox() {
		super.writeJson(fileService.combobox());
	}
	

}