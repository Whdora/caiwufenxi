package com.post.action;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

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
import com.post.pageModel.Cost;
import com.post.pageModel.TjNormal;
import com.post.pageModel.TjProject;
import com.post.pageModel.TjSubject;
import com.post.pageModel.Zrzx;
import com.post.service.CostServiceI;
import com.post.service.KjkmServiceI;
import com.post.service.ZrzxServiceI;
import com.post.util.MyUtil;

/**
 * 分析
 */
@Action(value = "analysisAction", results = {
		@Result(name = "subject", location = "/analysis/subject.jsp"),
		@Result(name = "project", location = "/analysis/project.jsp"),
		@Result(name = "normal", location = "/analysis/normal.jsp"),
		@Result(name = "funds", location = "/analysis/funds.jsp")
})
public class AnalysisAction extends BaseAction implements ModelDriven<Cost>  {
	
	private Cost cost = new Cost();
	private CostServiceI costService;
	private KjkmServiceI subjectService;
	private ZrzxServiceI zrzxService;
	
	
	

	public ZrzxServiceI getZrzxService() {
		return zrzxService;
	}

	@Autowired
	public void setZrzxService(ZrzxServiceI zrzxService) {
		this.zrzxService = zrzxService;
	}

	public CostServiceI getCostService() {
		return costService;
	}

	@Autowired
	public void setCostService(CostServiceI costService) {
		this.costService = costService;
	}

	public KjkmServiceI getSubjectService() {
		return subjectService;
	}

	@Autowired
	public void setSubjectService(KjkmServiceI subjectService) {
		this.subjectService = subjectService;
	}

	public String subject() {
		return "subject";
	}
	
	public String project() {
		return "project";
	}
	
	public String normal() {
		return "normal";
	}
	
	public String funds() {
		List<Zrzx> zrzxs = zrzxService.combobox();
		int i = zrzxs.size()+1;
		String[] f=new String[i];
		f[0]="deptname";
		String[] c=new String[i];
		c[0] = "单位";
		int k = 0;
		for (Zrzx zrzx:zrzxs){
			k++;
			f[k]=zrzx.getCid();
			c[k]=zrzx.getCname();
		}
		String fields = MyUtil.arrayToDatagrid(c, f);
		ServletActionContext.getRequest().getSession().setAttribute("fields",fields);
		return "funds";
	}
	
	public void tjsubject(){
		super.writeJsonDate(costService.tjSubject(cost));
	}

	public void tjproject(){
		super.writeJsonDate(costService.tjProject(cost));
	}
	
	public void tjnormal(){
		super.writeJsonDate(costService.tjNormal(cost));
	}
	
	public void tjfunds(){
		super.writeJsonDate(costService.tjFunds(cost));
	}
	
	
	@Override
	public Cost getModel() {
		return cost;
	}
	
	public void exportTjSubject() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy年MM月dd");
		String title;
		String[] hearders;
		String[] fields;
		int[]  columnwidths;
		TableData td ;
		response.setContentType("application/msexcel;charset=GBK");
        List<TjSubject> list=costService.exportTjSubject(cost);
        if (cost.getCiszd()==2){
	        title = "重点业务科目余额表("+formatter.format(cost.getStartdate())+"-"+formatter.format(cost.getEnddate())+")";
        }
        else
        {
        	if(cost.getCiszd()==1){
        		title = "正常成本科目余额表("+formatter.format(cost.getStartdate())+"-"+formatter.format(cost.getEnddate())+")";
        	}
        	else{
        		title = "科目余额表("+formatter.format(cost.getStartdate())+"-"+formatter.format(cost.getEnddate())+")";
        	}
        }
        hearders = new String[] {"单位","科目编号","会计科目名称","上期余额", "本期发生额（借）","本期发生额（贷）", "本期余额"};//表头数组
        fields = new String[] {"deptName","subjectId", "subjectName","sqye","bqyej","bqyed", "bqye"};//对象属性数组
        columnwidths = new int[]{14,16,26,14,18,18,14};//每列宽度
        td = ExcelUtils.createTableData(list, ExcelUtils.createTableHeader(hearders),fields);
        JsGridReportBase report = new JsGridReportBase(request, response);
        report.exportToExcel(title, "admin",columnwidths, td);
	}
	
	public void exportTjzrzx() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String title;
		String[] hearders;
		String[] fields;
		int[]  columnwidths;
		TableData td ;
		response.setContentType("application/msexcel;charset=GBK");
        List<TjProject> list=costService.exportTjProject(cost);
        title = "业务成本费用列支情况总表("+cost.getCmonth()+")";
        hearders = new String[] {"单位名称","专业名称","本年累计","本年支付内部","本年支付外部","本月累计","本月支付内部","本月支付外部"};//表头数组
        fields = new String[] { "deptName","cname","bntotal","bnnb","bnwb", "bytotal","bynb","bywb"};//对象属性数组
        columnwidths = new int[]{14,14,14,18,18,14,18,18};//每列宽度
        td = ExcelUtils.createTableData(list, getTableHeader(hearders),fields);
        td.compute();
        JsGridReportBase report = new JsGridReportBase(request, response);
        report.exportToExcel(title, "admin",columnwidths, td);
	}
	
	public void exportTjNormal() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String title;
		String[] hearders;
		String[] fields;
		int[]  columnwidths;
		TableData td ;
		response.setContentType("application/msexcel;charset=GBK");
        List<TjNormal> list=costService.exportTjNormal(cost);
        title = "成本费用列支情况表("+cost.getCmonth()+")";
        hearders = new String[] {"单位名称","项目名称","本年累计","本月累计"};//表头数组
        fields = new String[] { "deptName","cname","bntotal", "bytotal"};//对象属性数组
        columnwidths = new int[]{22,22,22,22};//每列宽度
        td = ExcelUtils.createTableData(list, getTableHeader(hearders),fields);
        td.compute();
        JsGridReportBase report = new JsGridReportBase(request, response);
        report.exportToExcel(title, "admin",columnwidths, td);
	}
	
	public void exportTjFund() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response=ServletActionContext.getResponse();
		String title;
		List<Zrzx> zrzxs = zrzxService.combobox();
		int i = zrzxs.size()+1;
		String[] fields=new String[i];
		int[]  columnwidths = new int[i];
		String[] hearders=new String[i];
		fields[0]="deptname";
		columnwidths[0]=18;
		hearders[0] = "单位";
		int k = 0;
		for (Zrzx zrzx:zrzxs){
			k++;
			fields[k]=zrzx.getCid();
			hearders[k]=zrzx.getCname();
			columnwidths[k]=12;
		}
		
		TableData td ;
		response.setContentType("application/msexcel;charset=GBK");
        List<Map<String,String>> list=costService.tjFunds(cost);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        title = "资金使用情况表("+sdf.format(cost.getStartdate())+"-"+sdf.format(cost.getEnddate())+")";
        td = ExcelUtils.createTableData(list, ExcelUtils.createTableHeader(hearders),fields);
        JsGridReportBase report = new JsGridReportBase(request, response);
        report.exportToExcel(title, "admin",columnwidths, td);
	}
	
	private TableHeaderMetaData getTableHeader(String[] hearders){
	    int spanCount = 1;//需要合并的列数。从第1列开始到指定列。
	    //创建表头对象
		TableHeaderMetaData headMeta = new TableHeaderMetaData();
		for(int i=0;i<hearders.length;i++){
			TableColumn tc = new TableColumn();
			tc.setDisplay(hearders[i]);
			//设置按指定列统计
			if(i==0)//按第1列单位进行小计
				tc.setDisplaySummary(true);
			if(i>1)//进行求和
				tc.setAggregateRule("sum");
			if(i<spanCount)//前3列行合并
				tc.setGrouped(true);
			headMeta.addColumn(tc);
		}
		return headMeta;
	}
}