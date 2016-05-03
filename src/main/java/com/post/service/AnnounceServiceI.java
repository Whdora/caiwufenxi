package com.post.service;

import java.util.List;

import com.post.pageModel.Announce;
import com.post.pageModel.DataGrid;

public interface AnnounceServiceI {

	public void add(Announce announce);

	public void edit(Announce announce);

	public void delete(Announce announce);

	public DataGrid datagrid(Announce announce);
	
	public List<Announce> listAnnounce();
	
	public String getContentById(String cid);
}
