package com.post.action;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.SessionInfo;
import com.post.pageModel.User;
import com.post.service.UserServiceI;
import com.post.util.IpUtil;
import com.post.util.ResourceUtil;

/**
 * 用户
 */
@Namespace("/")
@Action(value = "userAction", results = {
		@Result(name = "userManager", location = "/admin/user/userManager.jsp"),
		@Result(name = "userAdd", location = "/admin/user/userAdd.jsp"),
		@Result(name = "userEdit", location = "/admin/user/userEdit.jsp"),
		@Result(name = "userChangePwd", location = "/admin/user/userChangePwd.jsp"),
		@Result(name = "lockWindow", location = "/admin/user/lockWindow.jsp")})
public class UserAction extends BaseAction implements ModelDriven<User> {

	private UserServiceI userService;
	private User user = new User();

	public UserServiceI getUserService() {
		return userService;
	}

	@Autowired
	public void setUserService(UserServiceI userService) {
		this.userService = userService;
	}

	@Override
	public User getModel() {
		return user;
	}

	public void do_login() {
		Json j = new Json();
		User u = userService.login(user);
		if (u != null) {
			SessionInfo sessionInfo = new SessionInfo();
			sessionInfo.setUserId(u.getCid());
			sessionInfo.setLoginName(user.getCusername());
			sessionInfo.setIpAddress(IpUtil.getIpAddr(ServletActionContext.getRequest()));
			ServletActionContext.getRequest().getSession().setAttribute(ResourceUtil.getSessionInfoName(),sessionInfo);
			sessionInfo.setAuthIds(u.getAuthIds());
			sessionInfo.setAuthNames(u.getAuthNames());
			sessionInfo.setRoleIds(u.getRoleIds());
			sessionInfo.setRoleNames(u.getRoleNames());
			sessionInfo.setAuthUrls(u.getAuthUrls());
			sessionInfo.setDeptName(u.getCdeptname());
			sessionInfo.setDeptId(u.getCdepartment());
			sessionInfo.setLock(false);
			j.setSuccess(true);
			j.setMsg("登陆成功");
		} else {
			j.setMsg("登陆失败，用户名或密码错误!");
		}
		super.writeJson(j);
	}
	
	public void doNotNeedAuth_unlock(){
		Json j = new Json();
		boolean b = userService.unlock(user);
		if (b) {
			j.setSuccess(true);
			j.setMsg("解锁成功！");
			SessionInfo si=(SessionInfo)ServletActionContext.getRequest().getSession().getAttribute("sessionInfo");
			if (si!=null ){
				si.setLock(false);
			}
		}else{
			j.setSuccess(false);
			j.setMsg("密码错误!");
		}
		super.writeJson(j);
	}

	public String userManager() {
		return "userManager";
	}
	
	public String doNotNeedAuth_lock(){
		SessionInfo si=(SessionInfo)ServletActionContext.getRequest().getSession().getAttribute("sessionInfo");
		if (si!=null ){
			si.setLock(true);
		}
		return "lockWindow";
	}

	public String userAdd() {
		return "userAdd";
	}

	public String userEdit() {
		return "userEdit";
	}

	public String doNotNeedAuth_userChangePwd() {
		return "userChangePwd";
	}

	public void do_dataGrid() {
		super.writeJson(userService.datagrid(user));
	}

	public void add() {
		Json j = new Json();
		try {
			userService.addUser(user);
			j.setMsg("添加成功！");
			j.setSuccess(true);
		} catch (Exception e) {
			j.setMsg("添加失败，用户名已存在！");
			j.setSuccess(false);
		}
		super.writeJson(j);
	}

	public void edit() {
		Json j = new Json();
		try {
			userService.update(user);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		try {
			userService.del(user.getIds());
			j.setSuccess(true);
			j.setMsg("删除用户成功！");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

	public void doNotNeedAuth_editPwd() {
		Json j = new Json();
		try {
			Boolean b = userService.editPwd(user);
			if (b) {
				j.setSuccess(true);
				j.setMsg("密码修改成功！");
			} else {
				j.setSuccess(false);
				j.setMsg("密码修改失败，原密码错误！");
			}
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("密码修改失败！");
		}
		super.writeJson(j);
	}
	
	public void do_logout(){
		ServletActionContext.getRequest().getSession().invalidate();
		Json j = new Json();
		j.setSuccess(true);
		super.writeJson(j);
	}
}
