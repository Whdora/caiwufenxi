package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Shangpin;
import com.post.service.ShangpinServiceI;

/**
 * 商品
 */
@Action(value = "shangpinAction", results = {
		@Result(name = "shangpinManager", location = "/busi/shangpin/shangpinManager.jsp"),
		@Result(name = "shangpinAdd", location = "/busi/shangpin/shangpinAdd.jsp"),
		@Result(name = "shangpinEdit", location = "/busi/shangpin/shangpinEdit.jsp") })
public class ShangpinAction extends BaseAction implements ModelDriven<Shangpin> {

	private Shangpin shangpin = new Shangpin();
	private ShangpinServiceI shangpinService;

	public ShangpinServiceI getShangpinService() {
		return shangpinService;
	}

	@Autowired
	public void setShangpinService(ShangpinServiceI shangpinService) {
		this.shangpinService = shangpinService;
	}

	@Override
	public Shangpin getModel() {
		return shangpin;
	}

	public String shangpinManager() {
		return "shangpinManager";
	}

	public String shangpinAdd() {
		return "shangpinAdd";
	}

	public String shangpinEdit() {
		return "shangpinEdit";
	}

	public void do_datagrid() {
		super.writeJson(shangpinService.datagrid(shangpin));
	}

	public void add() {
		Json j = new Json();
		try {
			shangpinService.add(shangpin);
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
			shangpinService.edit(shangpin);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		shangpinService.delete(shangpin);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	public void do_combobox() {
		super.writeJson(shangpinService.combobox());
	}

}