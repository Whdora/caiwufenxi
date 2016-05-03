package com.post.pageModel;

import java.io.Serializable;
import java.sql.Timestamp;

import com.post.model.Tuser;

public class Announce implements Serializable {

	private String cid;
	private String userId;
	private String userName;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;
	private String ctitle;
	private String ccontent;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Timestamp getCcreatedate() {
		return ccreatedate;
	}
	public void setCcreatedate(Timestamp ccreatedate) {
		this.ccreatedate = ccreatedate;
	}
	public Timestamp getCmodifydate() {
		return cmodifydate;
	}
	public void setCmodifydate(Timestamp cmodifydate) {
		this.cmodifydate = cmodifydate;
	}
	public String getCtitle() {
		return ctitle;
	}
	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
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
