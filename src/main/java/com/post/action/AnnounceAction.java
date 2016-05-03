package com.post.action;

import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Announce;
import com.post.pageModel.Json;
import com.post.service.AnnounceServiceI;

/**
 * 通告
 */
@Action(value = "announceAction", results = {
		@Result(name = "announceManager", location = "/admin/announce/announceManager.jsp"),
		@Result(name = "announceAdd", location = "/admin/announce/announceAdd.jsp"),
		@Result(name = "announceEdit", location = "/admin/announce/announceEdit.jsp"),
		@Result(name = "showContent", location = "/admin/announce/showContent.jsp"),
		@Result(name = "showAnnounce", location = "/layout/portal/announce.jsp")})
public class AnnounceAction extends BaseAction implements ModelDriven<Announce> {

	private Announce announce = new Announce();
	private AnnounceServiceI announceService;
	private List<Announce> alist;
	
	

	public List<Announce> getAlist() {
		return alist;
	}

	public void setAlist(List<Announce> alist) {
		this.alist = alist;
	}

	public AnnounceServiceI getAnnounceService() {
		return announceService;
	}

	@Autowired
	public void setAnnounceService(AnnounceServiceI announceService) {
		this.announceService = announceService;
	}

	@Override
	public Announce getModel() {
		return announce;
	}


	public String announceManager() {
		return "announceManager";
	}
	
	public String do_listAnnounce() {
		alist = announceService.listAnnounce();
		return "showAnnounce";
	}

	public String announceEdit() {
		return "announceEdit";
	}

	public String announceAdd() {
		return "announceAdd";
	}

	public String do_showContent() {
		ServletActionContext.getRequest().setAttribute("content", announceService.getContentById(announce.getCid()));
		return "showContent";
	} 
	
	public void do_showAnnounce(){
		super.writeJson(announceService.listAnnounce());
	}
	
	public void do_datagrid() {
		super.writeJson(announceService.datagrid(announce));
	}
	
	public void add() {
		Json j = new Json();
		try {
			announceService.add(announce);
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
			announceService.edit(announce);
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
			announceService.delete(announce);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(announce.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

}
