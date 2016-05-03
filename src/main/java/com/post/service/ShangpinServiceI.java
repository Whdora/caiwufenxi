package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.Shangpin;

public interface ShangpinServiceI {


	public void add(Shangpin shangpin);

	public void edit(Shangpin shangpin);

	public void delete(Shangpin shangpin);

	public DataGrid datagrid(Shangpin shangpin);
	
	public List<Shangpin> combobox();
	
}
