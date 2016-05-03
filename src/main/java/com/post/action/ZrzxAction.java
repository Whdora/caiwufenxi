package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Zrzx;
import com.post.service.ZrzxServiceI;

/**
 * 专业
 */
@Action(value = "zrzxAction", results = {
		@Result(name = "zrzxManager", location = "/busi/zrzx/zrzxManager.jsp"),
		@Result(name = "zrzxAdd", location = "/busi/zrzx/zrzxAdd.jsp"),
		@Result(name = "zrzxEdit", location = "/busi/zrzx/zrzxEdit.jsp") })
public class ZrzxAction extends BaseAction implements ModelDriven<Zrzx> {

	private Zrzx zrzx = new Zrzx();
	private ZrzxServiceI zrzxService;

	public ZrzxServiceI getZrzxService() {
		return zrzxService;
	}

	@Autowired
	public void setZrzxService(ZrzxServiceI zrzxService) {
		this.zrzxService = zrzxService;
	}

	@Override
	public Zrzx getModel() {
		return zrzx;
	}

	public String zrzxManager() {
		return "zrzxManager";
	}

	public String zrzxAdd() {
		return "zrzxAdd";
	}

	public String zrzxEdit() {
		return "zrzxEdit";
	}

	public void do_datagrid() {
		super.writeJson(zrzxService.datagrid(zrzx));
	}

	public void add() {
		Json j = new Json();
		try {
			zrzxService.add(zrzx);
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
			zrzxService.edit(zrzx);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		zrzxService.delete(zrzx);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	public void do_combobox() {
		super.writeJson(zrzxService.combobox());
	}

}