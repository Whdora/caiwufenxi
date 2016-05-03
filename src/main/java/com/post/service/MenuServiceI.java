package com.post.service;

import java.util.List;

import com.post.pageModel.Menu;
import com.post.pageModel.TreeNode;



public interface MenuServiceI {
	public List<TreeNode> tree(Menu menu, Boolean b);

	/**
	 * 获得菜单treegrid
	 * 
	 * @param menu
	 * @return
	 */
	public List<Menu> treegrid(Menu menu);

	/**
	 * 删除菜单
	 * 
	 * @param menu
	 */
	public void delete(Menu menu);

	/**
	 * 添加菜单
	 * 
	 * @param menu
	 */
	public void add(Menu menu);

	public void edit(Menu menu);

	public List<Menu> tgrid(Menu menu, boolean b);

	public List<TreeNode> getUserMenus(Menu menu);

}
