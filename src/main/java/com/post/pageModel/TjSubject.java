package com.post.pageModel;

import java.io.Serializable;

public class TjSubject implements Serializable{

	private String subjectId;
	private String subjectName;
	private Double sqye;
	private Double bqye;
	private Double bqyed;
	private Double bqyej;
	private String deptName;
	
	

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getSubjectId() {
		return subjectId;
	}

	public void setSubjectId(String subjectId) {
		this.subjectId = subjectId;
	}

	public String getSubjectName() {
		return subjectName;
	}

	public void setSubjectName(String subjectName) {
		this.subjectName = subjectName;
	}

	public Double getSqye() {
		return sqye;
	}

	public void setSqye(Double sqye) {
		this.sqye = sqye;
	}

	public Double getBqye() {
		return bqye;
	}

	public void setBqye(Double bqye) {
		this.bqye = bqye;
	}

	public Double getBqyed() {
		return bqyed;
	}

	public void setBqyed(Double bqyed) {
		this.bqyed = bqyed;
	}

	public Double getBqyej() {
		return bqyej;
	}

	public void setBqyej(Double bqyej) {
		this.bqyej = bqyej;
	}

}
