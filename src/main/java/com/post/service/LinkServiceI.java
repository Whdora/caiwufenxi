package com.post.service;

import java.util.List;

import com.post.pageModel.Link;
import com.post.pageModel.DataGrid;

public interface LinkServiceI {

	public void add(Link link);

	public void edit(Link link);

	public void delete(Link link);

	public DataGrid datagrid(Link link);
	
	public List<Link> listLink();
	
}