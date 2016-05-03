package com.post.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.excelTools.ExcelUtils;
import com.post.excelTools.JsGridReportBase;
import com.post.excelTools.TableColumn;
import com.post.excelTools.TableData;
import com.post.excelTools.TableHeaderMetaData;
import com.post.pageModel.Budget;
import com.post.pageModel.Json;
import com.post.service.BudgetServiceI;

/**
 * 预算
 */
@Action(value = "budgetAction", results = {
		@Result(name = "budgetManager", location = "/busi/budget/budgetManager.jsp"),
		@Result(name = "budgetAdd", location = "/busi/budget/budgetAdd.jsp"),
		@Result(name = "budgetEdit", location = "/busi/budget/budgetEdit.jsp"),
		@Result(name = "budgetView", location = "/busi/budget/budgetView.jsp"),
		@Result(name = "budgetAddPzh", location = "/busi/budget/budgetAddPzh.jsp"),
		@Result(name = "budgetAudit", location = "/busi/budget/budgetAudit.jsp")})
public class BudgetAction extends BaseAction implements ModelDriven<Budget> {

	private Budget budget = new Budget();
	private BudgetServiceI budgetService;

	public BudgetServiceI getBudgetService() {
		return budgetService;
	}

	@Autowired
	public void setBudgetService(BudgetServiceI budgetService) {
		this.budgetService = budgetService;
	}

	@Override
	public Budget getModel() {
		return budget;
	}

	public String budgetManager() {
		return "budgetManager";
	}

	public String budgetAdd() {
		return "budgetAdd";
	}

	public String budgetEdit() {
		return "budgetEdit";
	}
	
	public String budgetView() {
		return "budgetView";
	}
	
	public String budgetAddPzh() {
		return "budgetAddPzh";
	}
	
	public String budgetAudit() {
		return "budgetAudit";
	}

	public void do_datagrid() {
		super.writeJsonDate(budgetService.datagrid(budget));
	}

	public void add() {
		Json j = new Json();
		try {
			budgetService.add(budget);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}

	public void edit() {
		Json j = new Json();
		try {
			budgetService.edit(budget);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		budgetService.delete(budget);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}
	
	public void audit() {
		Json j = new Json();
		budgetService.audit(budget);
		j.setSuccess(true);
		j.setMsg("审核成功！");
		super.writeJson(j);
	}
	
	public void notAudit() {
		Json j = new Json();
		budgetService.notAudit(budget);
		j.setSuccess(true);
		j.setMsg("操作成功！");
		super.writeJson(j);
	}
	
	public void submit() {
		Json j = new Json();
		budgetService.submit(budget);
		j.setSuccess(true);
		j.setMsg("提交审核成功！");
		super.writeJson(j);
	}
	
	public void do_totalBudget(){
		Json j = new Json();
		j.setSuccess(true);
		j.setObj(budgetService.totalBudget(budget.getFileId()));
		super.writeJson(j);
	}
	
	public void exportExcel() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("application/msexcel;charset=GBK");
        List<Budget> list=budgetService.excelData(budget);
        String title = budget.getDeptName()+"成本费用预算表";
        String[] hearders = new String[] {"单位","文件制定日期", "文件字号", "文件名称", "考核开始日期", "考核结束日期", "所属专业","所属项目","预计业务量收","预计费用（不含税）","预计利润","预计清算时间","已用费用(不含税)","实际清算时间","实际清算（不含税）","清算与预计差异","税金","总成本费用"};//表头数组
        String[] fields = new String[] {"deptName","fileDate", "fileNumber", "fileName", "startdate", "enddate", "zrzxName","projectName","cyjywls","cyjfy","cyjlr","cyjqssj","cyt","csjqssj","csjfy","cfycy","csj","ctotal"};//对象属性数组
        int[]  columnwidths = new int[]{16,12,22,40,12,12,20,20,14,16,14,12,12,16,14,10,10,16};
        TableData td = ExcelUtils.createTableData(list, ExcelUtils.createTableHeader(hearders),fields);
        JsGridReportBase report = new JsGridReportBase(request, response);
        report.exportToExcel(title, "admin",columnwidths, td);
	}
	
	private TableHeaderMetaData getTableHeader(String[] hearders){
	    int spanCount = 4;//需要合并的列数。从第1列开始到指定列。
	    //创建表头对象
		TableHeaderMetaData headMeta = new TableHeaderMetaData();
		for(int i=0;i<hearders.length;i++){
			TableColumn tc = new TableColumn();
			tc.setDisplay(hearders[i]);
			//设置按指定列统计
			if(i==2)//按第2列文件字号进行小计
				tc.setDisplaySummary(true);
			
			if(i>7 && i<11)//进行求和
				tc.setAggregateRule("sum");
			
			if(i<spanCount)//前3列行合并
				tc.setGrouped(true);
			headMeta.addColumn(tc);
		}
		return headMeta;
	}
}