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
import com.post.model.Tbudget;
import com.post.pageModel.Cost;
import com.post.pageModel.CostPrint;
import com.post.pageModel.Json;
import com.post.service.BudgetServiceI;
import com.post.service.CostServiceI;

/**
 * 成本
 */
@Action(value = "costAction", results = {
		@Result(name = "costManager", location = "/busi/cost/costManager.jsp"),
		@Result(name = "costAdd", location = "/busi/cost/costAdd.jsp"),
		@Result(name = "costEdit", location = "/busi/cost/costEdit.jsp"),
		@Result(name = "costView", location = "/busi/cost/costView.jsp"),
		@Result(name = "costPrint", location = "/busi/cost/costPrint.jsp"),
		@Result(name = "normalCostManager", location = "/busi/cost/normalCostManager.jsp"),
		@Result(name = "normalCostAdd", location = "/busi/cost/normalCostAdd.jsp"),
		@Result(name = "normalCostEdit", location = "/busi/cost/normalCostEdit.jsp"),
		@Result(name = "normalCostPrint", location = "/busi/cost/normalCostPrint.jsp"),
		@Result(name = "normalCostView", location = "/busi/cost/normalCostView.jsp")})
public class CostAction extends BaseAction implements ModelDriven<Cost> {

	private Cost cost = new Cost();
	private CostServiceI costService;
	private BudgetServiceI budgetService;

	public BudgetServiceI getBudgetService() {
		return budgetService;
	}

	@Autowired
	public void setBudgetService(BudgetServiceI budgetService) {
		this.budgetService = budgetService;
	}

	public CostServiceI getCostService() {
		return costService;
	}

	@Autowired
	public void setCostService(CostServiceI costService) {
		this.costService = costService;
	}

	@Override
	public Cost getModel() {
		return cost;
	}

	public String costManager() {
		return "costManager";
	}

	public String costAdd() {
		return "costAdd";
	}

	public String costEdit() {
		return "costEdit";
	}

	public String costView() {
		return "costView";
	}

	public String normalCostManager() {
		return "normalCostManager";
	}

	public String normalCostAdd() {
		return "normalCostAdd";
	}

	public String normalCostEdit() {
		return "normalCostEdit";
	}

	public String normalCostView() {
		return "normalCostView";
	}

	public String normalCostPrint(){
		CostPrint cp = costService.printData(cost);
		ServletActionContext.getRequest().getSession().setAttribute("costs", cp);
		return "normalCostPrint";
	}
	
	public String costPrint(){
		CostPrint cpdatas = costService.printData(cost);
		ServletActionContext.getRequest().getSession().setAttribute("datas", cpdatas);
		return "costPrint";
	}
	
	public void do_datagrid() {
		super.writeJsonDate(costService.datagrid(cost));
	}

	public void add() {
		Json j = new Json();
		try {
			costService.add(cost);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}
	
	public void addPzh() {
		Json j = new Json();
		try {
			costService.addPzh(cost);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}


	public void edit() {
		Json j = new Json();
		try {
			costService.edit(cost);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		super.writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		costService.delete(cost);
		j.setSuccess(true);
		j.setMsg("删除成功！");
		super.writeJson(j);
	}

	public void do_totalCost() {
		Json j = new Json();
		j.setSuccess(true);
		j.setObj(costService.totalCost(cost));
		super.writeJson(j);
	}

	public void do_sumyt() {
		Json j = new Json();
		j.setSuccess(true);
		Object o = costService.sumyt(cost);
		if (o != null) {
			j.setObj(o);
		} else {
			j.setObj(0);
		}
		super.writeJson(j);
	}

	public void do_check() {
		Json j = new Json();
		double totalBudget;
		double totalAmount = costService.sumyt(cost);;
		Tbudget t = budgetService.get(cost.getBudgetId());
		if (t.getCsjfy()== null){
			totalBudget = t.getCyjfy();
			if ((cost.getCamount()+totalAmount)>totalBudget*0.7) {
				j.setSuccess(true);
			} else {
				j.setSuccess(false);
			}
		}else{
					totalBudget = t.getCsjfy();
					if ((cost.getCamount()+totalAmount)>totalBudget) {
						j.setSuccess(true);
					} else {
						j.setSuccess(false);
					}	
			}
		super.writeJson(j);
	}
	
	public void exportExcel() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String title;
		String[] hearders;
		String[] fields;
		int[]  columnwidths;
		TableData td ;
		response.setContentType("application/msexcel;charset=GBK");
        List<Cost> list=costService.excelData(cost);
        if (cost.getCiszd()==2){
	        title = cost.getDeptName()+"重点业务成本费用详情表";
	        hearders = new String[] {"单位","归属文件号","归属文件名称", "事由（摘要）","单证编号", "列支方式","借贷方向", "金额","税金","科目编号", "会计科目", "性质","归类","责任中心","归属项目","入账时间"};//表头数组
	        fields = new String[] {"deptName", "fileNumber","fileName","cshiyou","cbh", "clzfs", "cfx","camount","csj", "subjectId","subjectName", "cxz","kindName","zrzxName","projectName","cdate"};//对象属性数组
	        columnwidths = new int[]{10,22,30,40,14,12,12,14,12,18,20,10,14,14,20,12};//每列宽度
	        td = ExcelUtils.createTableData(list, getTableHeader(hearders),fields);
        }
        else
        {
        	title = cost.getDeptName()+"正常成本费用详情表";
 	        hearders = new String[] {"单位", "事由（摘要）", "单证编号","列支方式","借贷方向", "金额", "科目编号","会计科目", "性质","责任中心","入账时间"};//表头数组
 	        fields = new String[] {"deptName", "cshiyou","cbh", "clzfs","cfx", "camount", "subjectId","subjectName", "cxz","zrzxName","cdate"};//对象属性数组
 	        columnwidths = new int[]{10,40,14,12,12,14,18,20,10,14,12};//每列宽度
 	        td = ExcelUtils.createTableData(list, getTableHeader(hearders),fields);
        }
        td.compute();
        JsGridReportBase report = new JsGridReportBase(request, response);
        report.exportToExcel(title, "admin",columnwidths, td);
	}
	
	private TableHeaderMetaData getTableHeader(String[] hearders){
	    int spanCount = 3;//需要合并的列数。从第1列开始到指定列。
	    if (!cost.getCxz().trim().equals("重点")){
	    	spanCount = 1;
	    }
	    //创建表头对象
		TableHeaderMetaData headMeta = new TableHeaderMetaData();
		for(int i=0;i<hearders.length;i++){
			TableColumn tc = new TableColumn();
			tc.setDisplay(hearders[i]);
			//设置按指定列统计
			if(i==0)//按第1列单位进行小计
				tc.setDisplaySummary(true);
			if (cost.getCiszd()==2){
				if(i==7)//进行求和
					tc.setAggregateRule("sum");
				if(i==8)//进行求和
					tc.setAggregateRule("sum");
			}
			else
			{
				if (i==5)  tc.setAggregateRule("sum");
			}
			
			if(i<spanCount)//前3列行合并
				tc.setGrouped(true);
			headMeta.addColumn(tc);
		}
		return headMeta;
	}
}