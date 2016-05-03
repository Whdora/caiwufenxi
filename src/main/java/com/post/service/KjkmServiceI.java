package com.post.service;

import java.util.List;

import com.post.model.Tsubject;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Subject;

public interface KjkmServiceI  {
	
	public void add(Subject subject);

	public void edit(Subject subject);

	public void delete(Subject subject);

	public DataGrid datagrid(Subject subject);
	
	public List<Subject> treegrid(Subject subject);
	

}
