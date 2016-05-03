package com.post.pageModel;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class Budget implements Serializable {

	private String cid;
	private String ids;
	private Double cyjywls;
	private Double cyjfy;
	private Double cyjlr;
	private Date cyjqssj;
	private Date csjqssj;
	private Double csjfy;
	private Double cfycy;
	private Double cyt;
	private Double cytcy;
	private Double csj;
	private Double ctotal;
	private Integer cstate;
	private Date cdate;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private String deptId;
	private String deptName;
	private String userId;
	private String userName;
	private String zrzxId;
	private String zrzxName;
	private String projectId;
	private String projectName;
	private String fileId;
	private String fileName;
	private String fileNumber;
	private String filePath;
	private Date fileDate;
	private Date startdate;
	private Date enddate;
	private Date createStartDate;
	private Date createEndDate;
	private String cauditfilename;
	private String cauditfilepath;
	
	
	
	
	
	

	public String getCauditfilename() {
		return cauditfilename;
	}

	public void setCauditfilename(String cauditfilename) {
		this.cauditfilename = cauditfilename;
	}

	public String getCauditfilepath() {
		return cauditfilepath;
	}

	public void setCauditfilepath(String cauditfilepath) {
		this.cauditfilepath = cauditfilepath;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Date getFileDate() {
		return fileDate;
	}

	public void setFileDate(Date fileDate) {
		this.fileDate = fileDate;
	}

	public Date getCreateStartDate() {
		return createStartDate;
	}

	public void setCreateStartDate(Date createStartDate) {
		this.createStartDate = createStartDate;
	}

	public Date getCreateEndDate() {
		return createEndDate;
	}

	public void setCreateEndDate(Date createEndDate) {
		this.createEndDate = createEndDate;
	}

	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Double getCyjywls() {
		return cyjywls;
	}

	public void setCyjywls(Double cyjywls) {
		this.cyjywls = cyjywls;
	}

	public Double getCyjfy() {
		return cyjfy;
	}

	public void setCyjfy(Double cyjfy) {
		this.cyjfy = cyjfy;
	}

	public Double getCyjlr() {
		return cyjlr;
	}

	public void setCyjlr(Double cyjlr) {
		this.cyjlr = cyjlr;
	}

	public Date getCyjqssj() {
		return cyjqssj;
	}

	public void setCyjqssj(Date cyjqssj) {
		this.cyjqssj = cyjqssj;
	}

	public Date getCsjqssj() {
		return csjqssj;
	}

	public void setCsjqssj(Date csjqssj) {
		this.csjqssj = csjqssj;
	}

	public Double getCsjfy() {
		return csjfy;
	}

	public void setCsjfy(Double csjfy) {
		this.csjfy = csjfy;
	}

	public Double getCfycy() {
		return cfycy;
	}

	public void setCfycy(Double cfycy) {
		this.cfycy = cfycy;
	}

	public Double getCyt() {
		return cyt;
	}

	public void setCyt(Double cyt) {
		this.cyt = cyt;
	}

	public Double getCytcy() {
		return cytcy;
	}

	public void setCytcy(Double cytcy) {
		this.cytcy = cytcy;
	}

	public Double getCsj() {
		return csj;
	}

	public void setCsj(Double csj) {
		this.csj = csj;
	}

	public Double getCtotal() {
		return ctotal;
	}

	public void setCtotal(Double ctotal) {
		this.ctotal = ctotal;
	}

	public Integer getCstate() {
		return cstate;
	}

	public void setCstate(Integer cstate) {
		this.cstate = cstate;
	}

	public Date getCdate() {
		return cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
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

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
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

	public String getZrzxId() {
		return zrzxId;
	}

	public void setZrzxId(String zrzxId) {
		this.zrzxId = zrzxId;
	}

	public String getZrzxName() {
		return zrzxName;
	}

	public void setZrzxName(String zrzxName) {
		this.zrzxName = zrzxName;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileNumber() {
		return fileNumber;
	}

	public void setFileNumber(String fileNumber) {
		this.fileNumber = fileNumber;
	}

}
