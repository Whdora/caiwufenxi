package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.Dept;

public interface DeptServiceI {

	public void addDept(Dept dept);

	public DataGrid datagrid(Dept dept);

	public List<Dept> listDept();

	public List<Dept> treeDept(Dept dept);

	public void add(Dept dept);

	public void edit(Dept dept);

	public void delete(Dept dept);
}
