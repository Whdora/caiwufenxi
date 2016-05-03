package com.post.service;

import java.util.List;

import com.post.pageModel.Download;
import com.post.pageModel.DataGrid;

public interface DownloadServiceI {

	public void add(Download download);

	public void edit(Download download);

	public void delete(Download download);

	public DataGrid datagrid(Download download);
	
	public List<Download> listDownload();
	
}
