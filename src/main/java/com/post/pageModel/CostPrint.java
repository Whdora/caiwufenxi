package com.post.pageModel;

import java.util.List;

public class CostPrint implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<Cost> rows;
	private int total;
	private Double amount;
	private String deptName;
	private String lzfs;
	private String upperNumber;
	private String dzbh;
	
	
	
	
	
	
	
	public String getDzbh() {
		return dzbh;
	}
	public void setDzbh(String dzbh) {
		this.dzbh = dzbh;
	}
	public String getUpperNumber() {
		return upperNumber;
	}
	public void setUpperNumber(String upperNumber) {
		this.upperNumber = upperNumber;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getLzfs() {
		return lzfs;
	}
	public void setLzfs(String lzfs) {
		this.lzfs = lzfs;
	}
	public List<Cost> getRows() {
		return rows;
	}
	public void setRows(List<Cost> rows) {
		this.rows = rows;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public Double getAmount() {
		return amount;
	}
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	
	
}
