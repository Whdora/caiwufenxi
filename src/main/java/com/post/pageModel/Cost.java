package com.post.pageModel;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class Cost implements Serializable {

	private String cid;
	private String ids;
	private String cbh;
	private String clzfs;
	private String cshiyou;
	private Double camount;
	private Double csj;
	private String cxz;
	private String crzsx;
	private String cpzh;
	private Date cdate;
	private int cprogress;
	private Integer ciszd;
	private String cfx;
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private String deptId;
	private String deptName;
	private String subjectId;
	private String subjectName;
	private String userId;
	private String userName;
	private String kindId;
	private String kindName;
	private String zrzxId;
	private String zrzxName;
	private String shangpinId;
	private String shangpinName;
	private String projectId;
	private String projectName;
	private String budgetId;
	private String fileId;
	private String fileName;
	private String fileNumber;
	private String filePath;
	private String cmonth;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;
	private Date startdate;
	private Date enddate;
	private Date createStartDate;
	private Date createEndDate;
	
	
	
	
	
	public String getShangpinId() {
		return shangpinId;
	}

	public void setShangpinId(String shangpinId) {
		this.shangpinId = shangpinId;
	}

	public String getShangpinName() {
		return shangpinName;
	}

	public void setShangpinName(String shangpinName) {
		this.shangpinName = shangpinName;
	}

	public String getCmonth() {
		return cmonth;
	}

	public void setCmonth(String cmonth) {
		this.cmonth = cmonth;
	}

	public String getCbh() {
		return cbh;
	}

	public void setCbh(String cbh) {
		this.cbh = cbh;
	}

	public String getCfx() {
		return cfx;
	}

	public void setCfx(String cfx) {
		this.cfx = cfx;
	}

	public Integer getCiszd() {
		return ciszd;
	}

	public void setCiszd(Integer ciszd) {
		this.ciszd = ciszd;
	}

	public int getCprogress() {
		return cprogress;
	}

	public void setCprogress(int cprogress) {
		this.cprogress = cprogress;
	}

	public String getCpzh() {
		return cpzh;
	}

	public void setCpzh(String cpzh) {
		this.cpzh = cpzh;
	}

	public Date getCdate() {
		return cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	public String getBudgetId() {
		return budgetId;
	}

	public void setBudgetId(String budgetId) {
		this.budgetId = budgetId;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public Double getCsj() {
		return csj;
	}

	public void setCsj(Double csj) {
		this.csj = csj;
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

	public String getFileNumber() {
		return fileNumber;
	}

	public void setFileNumber(String fileNumber) {
		this.fileNumber = fileNumber;
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

	public String getClzfs() {
		return clzfs;
	}

	public void setClzfs(String clzfs) {
		this.clzfs = clzfs;
	}

	public String getCshiyou() {
		return cshiyou;
	}

	public void setCshiyou(String cshiyou) {
		this.cshiyou = cshiyou;
	}

	public Double getCamount() {
		return camount;
	}

	public void setCamount(Double camount) {
		this.camount = camount;
	}

	public String getCxz() {
		return cxz;
	}

	public void setCxz(String cxz) {
		this.cxz = cxz;
	}

	public String getCrzsx() {
		return crzsx;
	}

	public void setCrzsx(String crzsx) {
		this.crzsx = crzsx;
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

	public String getKindId() {
		return kindId;
	}

	public void setKindId(String kindId) {
		this.kindId = kindId;
	}

	public String getKindName() {
		return kindName;
	}

	public void setKindName(String kindName) {
		this.kindName = kindName;
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

}
