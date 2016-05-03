package com.post.service;

import java.util.List;

import com.post.model.Tbudget;
import com.post.pageModel.Budget;
import com.post.pageModel.DataGrid;

public interface BudgetServiceI {

	public void add(Budget budget);

	public void edit(Budget budget);
	
	public void auditEdit(Budget budget);

	public void delete(Budget budget);

	public DataGrid datagrid(Budget budget);

	public void audit(Budget budget);
	
	public void submit(Budget budget);
	
	public void notAudit(Budget budget);
	
	public Tbudget get(String budgetId);
	
	public Double totalBudget(String budgetId);
	
	public List<Budget> excelData(Budget budget);
	
	public List<Budget> excelAudit(Budget budget);
	
}