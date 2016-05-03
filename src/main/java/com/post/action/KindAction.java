package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Kind;
import com.post.service.KindServiceI;

/**
 * 分类
 */
@Action(value="kindAction",results = { @Result(name = "kindManager", location = "/busi/kind/kindManager.jsp"), @Result(name = "kindAdd", location = "/busi/kind/kindAdd.jsp"), @Result(name = "kindEdit", location = "/busi/kind/kindEdit.jsp") })
public class KindAction extends BaseAction implements ModelDriven<Kind> {
	
	private Kind kind=new Kind();
	private KindServiceI kindService;
	
	

	public KindServiceI getKindService() {
		return kindService;
	}


	@Autowired
	public void setKindService(KindServiceI kindService) {
		this.kindService = kindService;
	}



	@Override
	public Kind getModel() {
		return kind;
	}

	public String kindManager(){
		return "kindManager";
	}
	
	public String kindAdd(){
		return "kindAdd";
	}
	
	public String kindEdit(){
		return "kindEdit";
	}
	
	public void add(){
		Json j = new Json();
		try {
			kindService.add(kind);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}
	
	public void do_treegrid(){
		super.writeJson(kindService.treegrid(kind));
	}
	
	public void delete(){
		Json j = new Json();
		try {
			kindService.delete(kind);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(kind.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}
	
	public void edit(){
		Json j = new Json();
		try {
			kindService.edit(kind);
			j.setSuccess(true);
			j.setMsg("编辑成功!");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		writeJson(j);
	}
}
