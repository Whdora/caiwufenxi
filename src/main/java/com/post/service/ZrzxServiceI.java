package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.Zrzx;

public interface ZrzxServiceI {

	public void add(Zrzx zrzx);

	public void edit(Zrzx zrzx);

	public void delete(Zrzx zrzx);

	public DataGrid datagrid(Zrzx zrzx);
	
	public List<Zrzx> combobox();
}
