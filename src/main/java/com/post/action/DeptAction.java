package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Dept;
import com.post.pageModel.Json;
import com.post.service.DeptServiceI;

/**
 * 单位
 */
@Action(value = "deptAction", results = {
		@Result(name = "deptManager", location = "/admin/dept/deptManager.jsp"),
		@Result(name = "deptAdd", location = "/admin/dept/deptAdd.jsp"),
		@Result(name = "deptEdit", location = "/admin/dept/deptEdit.jsp") })
public class DeptAction extends BaseAction implements ModelDriven<Dept> {

	private Dept dept = new Dept();
	private DeptServiceI deptService;

	public DeptServiceI getDeptService() {
		return deptService;
	}

	@Autowired
	public void setDeptService(DeptServiceI deptService) {
		this.deptService = deptService;
	}

	@Override
	public Dept getModel() {
		return dept;
	}

	public void do_showDept() {
		super.writeJson(deptService.treeDept(dept));
	}

	public String deptManager() {
		return "deptManager";
	}

	public String deptEdit() {
		return "deptEdit";
	}

	public String deptAdd() {
		return "deptAdd";
	}

	public void add() {
		Json j = new Json();
		try {
			deptService.add(dept);
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
			deptService.edit(dept);
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
			deptService.delete(dept);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(dept.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

}
