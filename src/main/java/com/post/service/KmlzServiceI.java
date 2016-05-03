package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.Kmlz;

public interface KmlzServiceI {

	public void add(Kmlz kmlz);
	
	public void addPzh(Kmlz kmlz);
	
	public int addKmlzs(Kmlz kmlz);

	public void edit(Kmlz kmlz);

	public void delete(Kmlz kmlz);

	public DataGrid datagrid(Kmlz kmlz);
	
}
