package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.File;

public interface FileServiceI {

	public void add(File file);

	public void edit(File file);

	public void delete(File file);

	public DataGrid datagrid(File file);
	
	public List<File> combobox();
	
}
