package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Auth;
import com.post.pageModel.Json;
import com.post.service.AuthServiceI;

/**
 * 权限
 */
@Action(value = "authAction", results = {
		@Result(name = "authManager", location = "/admin/auth/authManager.jsp"),
		@Result(name = "authAdd", location = "/admin/auth/authAdd.jsp"),
		@Result(name = "authEdit", location = "/admin/auth/authEdit.jsp") })
public class AuthAction extends BaseAction implements ModelDriven<Auth> {

	private Auth auth = new Auth();
	private AuthServiceI authService;

	public AuthServiceI getAuthService() {
		return authService;
	}

	@Autowired
	public void setAuthService(AuthServiceI authService) {
		this.authService = authService;
	}

	@Override
	public Auth getModel() {
		return auth;
	}

	public String authManager() {
		return "authManager";
	}
	
	public String authAdd(){
		return "authAdd";
	}
	
	public String authEdit(){
		return "authEdit";
	}

	public void do_treegrid() {
		super.writeJson(authService.treegrid(auth, true));
	}
	
	public void add(){
		Json j = new Json();
		try {
			authService.add(auth);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}
	
	public void edit(){
		Json j = new Json();
		try {
			authService.edit(auth);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}
	
	public void delete(){
		Json j = new Json();
		try {
			authService.delete(auth);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(auth.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}
}
