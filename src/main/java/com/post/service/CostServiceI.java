package com.post.service;

import java.util.List;
import java.util.Map;

import com.post.pageModel.Cost;
import com.post.pageModel.CostPrint;
import com.post.pageModel.DataGrid;
import com.post.pageModel.TjNormal;
import com.post.pageModel.TjProject;
import com.post.pageModel.TjSubject;

public interface CostServiceI {

	public void add(Cost cost);

	public void edit(Cost cost);

	public void delete(Cost cost);

	public DataGrid datagrid(Cost cost);

	public Double totalCost(Cost cost);
	
	public Double sumyt(Cost cost);
	
	public void addPzh(Cost cost);

	public List<Cost> excelData(Cost cost);
	
	public CostPrint printData(Cost cost);
	
	public DataGrid tjSubject(Cost cost);
	
	public List<TjSubject> exportTjSubject(Cost cost);
	
	public List<TjProject> exportTjProject(Cost cost);
	
	public DataGrid tjProject (Cost cost);
	
	public DataGrid tjNormal (Cost cost);
	
	public List<TjNormal> exportTjNormal(Cost cost);
	
	public List<Map<String,String>> tjFunds(Cost cost);
}
