package com.post.action;

import java.util.List;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Link;
import com.post.service.LinkServiceI;

/**
 * 链接
 */
@Action(value = "linkAction", results = {
		@Result(name = "linkManager", location = "/admin/link/linkManager.jsp"),
		@Result(name = "linkAdd", location = "/admin/link/linkAdd.jsp"),
		@Result(name = "linkEdit", location = "/admin/link/linkEdit.jsp"),
		@Result(name = "showLink", location = "/layout/portal/link.jsp")})
public class LinkAction extends BaseAction implements ModelDriven<Link> {

	private Link link = new Link();
	private LinkServiceI linkService;
	private List<Link> alist;
	
	

	public List<Link> getAlist() {
		return alist;
	}

	public void setAlist(List<Link> alist) {
		this.alist = alist;
	}

	public LinkServiceI getLinkService() {
		return linkService;
	}

	@Autowired
	public void setLinkService(LinkServiceI linkService) {
		this.linkService = linkService;
	}

	@Override
	public Link getModel() {
		return link;
	}


	public String linkManager() {
		return "linkManager";
	}
	public String uploader() {
		return "uploader";
	}
	
	public String do_listLink() {
		alist = linkService.listLink();
		return "showLink";
	}

	public String linkEdit() {
		return "linkEdit";
	}

	public String linkAdd() {
		return "linkAdd";
	}

	
	public void do_showLink(){
		super.writeJson(linkService.listLink());
	}
	
	public void do_datagrid() {
		super.writeJson(linkService.datagrid(link));
	}
	
	public void add() {
		Json j = new Json();
		try {
			linkService.add(link);
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
			linkService.edit(link);
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
			linkService.delete(link);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(link.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

}
