package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Role;
import com.post.service.RoleServiceI;

/**
 * 角色
 */
@Action(value = "roleAction", results = {
		@Result(name = "roleManager", location = "/admin/role/roleManager.jsp"),
		@Result(name = "roleAdd", location = "/admin/role/roleAdd.jsp"),
		@Result(name = "roleEdit", location = "/admin/role/roleEdit.jsp") })
public class RoleAction extends BaseAction implements ModelDriven<Role> {

	private Role role = new Role();
	private RoleServiceI roleService;

	public RoleServiceI getRoleService() {
		return roleService;
	}
	
	@Autowired
	public void setRoleService(RoleServiceI roleService) {
		this.roleService = roleService;
	}

	@Override
	public Role getModel() {
		return role;
	}

	public String roleManager() {
		return "roleManager";
	}

	public String roleAdd() {
		return "roleAdd";
	}

	public String roleEdit() {
		return "roleEdit";
	}
	
	public void do_datagrid() {
		super.writeJson(roleService.datagrid(role));
	}
	
	public void add() {
		Json j = new Json();
		try {
			roleService.add(role);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}

	/**
	 * 编辑一个角色
	 */
	public void edit() {
		Json j = new Json();
		try {
			roleService.edit(role);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	/**
	 * 删除一个或多个角色
	 */
	public void delete() {
		Json j = new Json();
		roleService.delete(role.getIds());
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	/**
	 * 获得角色下拉列表
	 */
	public void do_combobox() {
		super.writeJson(roleService.combobox());
	}


}
