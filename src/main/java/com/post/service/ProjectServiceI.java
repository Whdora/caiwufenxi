package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.Project;

public interface ProjectServiceI {

	public void add(Project project);

	public void edit(Project project);

	public void delete(Project project);

	public DataGrid datagrid(Project project);
	
	public List<Project> combobox();
}
