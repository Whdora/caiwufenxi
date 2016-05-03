package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Subject;
import com.post.service.KjkmServiceI;

/**
 * 会计科目
 */
@Action(value = "kjkmAction", results = {
		@Result(name = "kjkmManager", location = "/busi/kjkm/kjkmManager.jsp"),
		@Result(name = "kjkmAdd", location = "/busi/kjkm/kjkmAdd.jsp"),
		@Result(name = "kjkmEdit", location = "/busi/kjkm/kjkmEdit.jsp") })
public class kjkmAction extends BaseAction implements ModelDriven<Subject> {

	private Subject subject = new Subject();
	private KjkmServiceI kjkmService;
	

	public KjkmServiceI getKjkmService() {
		return kjkmService;
	}

	@Autowired
	public void setKjkmService(KjkmServiceI kjkmService) {
		this.kjkmService = kjkmService;
	}

	@Override
	public Subject getModel() {
		return subject;
	}

	public String kjkmManager() {
		return "kjkmManager";
	}

	public String kjkmAdd() {
		return "kjkmAdd";
	}

	public String kjkmEdit() {
		return "kjkmEdit";
	}
	
	public void do_datagrid() {
		super.writeJson(kjkmService.datagrid(subject));
	}
	
	public void add() {
		Json j = new Json();
		try {
			kjkmService.add(subject);
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
			kjkmService.edit(subject);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		kjkmService.delete(subject);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	public void do_treegrid(){
		super.writeJson(kjkmService.treegrid(subject));
	}

}

