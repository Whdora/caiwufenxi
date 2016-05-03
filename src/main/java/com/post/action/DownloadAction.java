package com.post.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Download;
import com.post.pageModel.Json;
import com.post.service.DownloadServiceI;

/**
 * 下载
 */
@Action(value = "downloadAction", results = {
		@Result(name = "downloadManager", location = "/admin/download/downloadManager.jsp"),
		@Result(name = "downloadAdd", location = "/admin/download/downloadAdd.jsp"),
		@Result(name = "downloadEdit", location = "/admin/download/downloadEdit.jsp"),
		@Result(name = "showDownload", location = "/layout/portal/download.jsp")})
public class DownloadAction extends BaseAction implements ModelDriven<Download> {

	private Download download = new Download();
	private DownloadServiceI downloadService;
	private List<Download> alist;
	
	

	public List<Download> getAlist() {
		return alist;
	}

	public void setAlist(List<Download> alist) {
		this.alist = alist;
	}

	public DownloadServiceI getDownloadService() {
		return downloadService;
	}

	@Autowired
	public void setDownloadService(DownloadServiceI downloadService) {
		this.downloadService = downloadService;
	}

	@Override
	public Download getModel() {
		return download;
	}


	public String downloadManager() {
		return "downloadManager";
	}
	public String uploader() {
		return "uploader";
	}
	
	public String do_listDownload() {
		alist = downloadService.listDownload();
		return "showDownload";
	}

	public String downloadEdit() {
		return "downloadEdit";
	}

	public String downloadAdd() {
		return "downloadAdd";
	}

	
	public void do_showDownload(){
		super.writeJson(downloadService.listDownload());
	}
	
	public void do_datagrid() {
		super.writeJson(downloadService.datagrid(download));
	}
	
	public void add() {
		Json j = new Json();
		try {
			downloadService.add(download);
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
			downloadService.edit(download);
			j.setSuccess(true);
			j.setMsg("编辑成功!");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		try {
			downloadService.delete(download);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(download.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

}
