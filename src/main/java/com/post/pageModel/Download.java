package com.post.pageModel;

import java.io.Serializable;
import java.sql.Timestamp;


public class Download implements Serializable {

	private String cid;
	private String cfilename;
	private String cfilepath;
	private Timestamp cuploaddate;
	private Integer ccount;
	private String userName;
	private String userId;
	private String ids;
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getCfilename() {
		return cfilename;
	}
	public void setCfilename(String cfilename) {
		this.cfilename = cfilename;
	}
	public String getCfilepath() {
		return cfilepath;
	}
	public void setCfilepath(String cfilepath) {
		this.cfilepath = cfilepath;
	}
	public Timestamp getCuploaddate() {
		return cuploaddate;
	}
	public void setCuploaddate(Timestamp cuploaddate) {
		this.cuploaddate = cuploaddate;
	}
	public Integer getCcount() {
		return ccount;
	}
	public void setCcount(Integer ccount) {
		this.ccount = ccount;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	
	
}
