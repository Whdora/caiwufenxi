package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Project;
import com.post.service.ProjectServiceI;

/**
 * 归属项目
 */
@Action(value = "projectAction", results = {
		@Result(name = "projectManager", location = "/busi/project/projectManager.jsp"),
		@Result(name = "projectAdd", location = "/busi/project/projectAdd.jsp"),
		@Result(name = "projectEdit", location = "/busi/project/projectEdit.jsp") })
public class ProjectAction extends BaseAction implements ModelDriven<Project> {

	private Project project = new Project();
	private ProjectServiceI projectService;

	public ProjectServiceI getProjectService() {
		return projectService;
	}

	@Autowired
	public void setProjectService(ProjectServiceI projectService) {
		this.projectService = projectService;
	}

	@Override
	public Project getModel() {
		return project;
	}

	public String projectManager() {
		return "projectManager";
	}

	public String projectAdd() {
		return "projectAdd";
	}

	public String projectEdit() {
		return "projectEdit";
	}

	public void do_datagrid() {
		super.writeJson(projectService.datagrid(project));
	}

	public void add() {
		Json j = new Json();
		try {
			projectService.add(project);
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
			projectService.edit(project);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		projectService.delete(project);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	public void do_combobox() {
		super.writeJson(projectService.combobox());
	}

}