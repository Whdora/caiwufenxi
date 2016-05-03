package com.post.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ModelDriven;
import com.post.pageModel.Json;
import com.post.pageModel.Menu;
import com.post.service.MenuServiceI;

/**
 * 菜单
 */
@Action(value = "menuAction", results = { @Result(name = "menuManager", location = "/admin/menu/menuManager.jsp"), @Result(name = "menuAdd", location = "/admin/menu/menuAdd.jsp"), @Result(name = "menuEdit", location = "/admin/menu/menuEdit.jsp") })
public class MenuAction extends BaseAction implements ModelDriven<Menu> {


	private MenuServiceI menuService;

	
	
	public MenuServiceI getMenuService() {
		return menuService;
	}

	@Autowired
	public void setMenuService(MenuServiceI menuService) {
		this.menuService = menuService;
	}

	private Menu menu = new Menu();

	public Menu getModel() {
		return menu;
	}

	/**
	 * 首页获得菜单树
	 */
	public void do_tree() {
		super.writeJson(menuService.tree(menu, false));
	}

	public void do_treeRecursive() {
		super.writeJson(menuService.tree(menu, true));
	}

	public String menuManager() {
		return "menuManager";
	}

	/**
	 * 获得菜单treegrid
	 */
	public void do_treegrid() {
		super.writeJson(menuService.tgrid(menu, true));
		//super.writeJson(menuService.treegrid(menu));
	}

	/**
	 * 删除一个菜单
	 */
	public void delete() {
		Json j = new Json();
		try {
			menuService.delete(menu);
			j.setSuccess(true);
			j.setMsg("删除成功！");
			j.setObj(menu.getCid());
		} catch (Exception e) {
			j.setMsg("删除失败！");
		}
		super.writeJson(j);
	}

	public String menuAdd() {
		return "menuAdd";
	}

	public void add() {
		Json j = new Json();
		try {
			menuService.add(menu);
			j.setSuccess(true);
			j.setMsg("添加成功！");
		} catch (Exception e) {
			j.setMsg("添加失败！");
		}
		super.writeJson(j);
	}

	public String menuEdit() {
		return "menuEdit";
	}

	/**
	 * 编辑菜单
	 */
	public void edit() {
		Json j = new Json();
		try {
			menuService.edit(menu);
			j.setSuccess(true);
			j.setMsg("编辑成功!");
		} catch (Exception e) {
			j.setMsg("编辑失败！");
		}
		writeJson(j);
	}
	
	public void do_UserMenus(){
		super.writeJson(menuService.getUserMenus(menu));
	}

}
