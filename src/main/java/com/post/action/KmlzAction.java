package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Kmlz;
import com.post.pageModel.Json;
import com.post.service.KmlzServiceI;

/**
 * 凭证号
 */
@Action(value = "kmlzAction", results = {
		@Result(name = "kmlzPzhView", location = "/busi/kmlz/kmlzPzhView.jsp"),
		@Result(name = "kmlzPzhEdit", location = "/busi/kmlz/kmlzPzhEdit.jsp"),
		@Result(name = "kmlzAdd", location = "/busi/kmlz/kmlzAdd.jsp"),
		@Result(name = "kmlzPzhAdd", location = "/busi/kmlz/kmlzPzhAdd.jsp") })
public class KmlzAction extends BaseAction implements ModelDriven<Kmlz> {

	private Kmlz kmlz = new Kmlz();
	private KmlzServiceI kmlzService;

	public KmlzServiceI getKmlzService() {
		return kmlzService;
	}

	@Autowired
	public void setKmlzService(KmlzServiceI kmlzService) {
		this.kmlzService = kmlzService;
	}

	@Override
	public Kmlz getModel() {
		return kmlz;
	}


	public String kmlzPzhView() {
		return "kmlzPzhView";
	}

	public String kmlzPzhAdd() {
		return "kmlzPzhAdd";
	}

	public String kmlzAdd() {
		return "kmlzAdd";
	}
	
	public String kmlzPzhEdit() {
		return "kmlzPzhEdit";
	}
	

	public void addPzh() {
		Json j = new Json();
		try {
			kmlzService.addPzh(kmlz);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setSuccess(false);
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}
	
	public void addKmlzs() {
		Json j = new Json();
		int count = 0;
		try {
			count = kmlzService.addKmlzs(kmlz);
			if (count > 0) {
				j.setSuccess(true);
				j.setMsg("上传成功，新增" + count + "条科目列账明细！");
				
			} else {
				j.setMsg("添加失败！");
			}
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}

	public void edit() {
		Json j = new Json();
		try {
			kmlzService.edit(kmlz);
			j.setSuccess(true);
			j.setMsg("编辑成功!");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		writeJson(j);
	}

	public void delete() {
		Json j = new Json();
		try {
			kmlzService.delete(kmlz);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(kmlz.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

	public void do_datagrid() {
		super.writeJsonDate(kmlzService.datagrid(kmlz));
	}
	
}
