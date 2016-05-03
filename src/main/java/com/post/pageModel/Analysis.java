package com.post.pageModel;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class Analysis implements Serializable {

	private String cid;
	private String deptName;
	private String fileNumber;
	private Double counter;
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getFileNumber() {
		return fileNumber;
	}
	public void setFileNumber(String fileNumber) {
		this.fileNumber = fileNumber;
	}
	public Double getCounter() {
		return counter;
	}
	public void setCounter(Double counter) {
		this.counter = counter;
	}
	public Analysis(String cid, String deptName, String fileNumber,
			Double counter) {
		super();
		this.cid = cid;
		this.deptName = deptName;
		this.fileNumber = fileNumber;
		this.counter = counter;
	}
	
	public Analysis() {
		super();
	}
	
	
	
}