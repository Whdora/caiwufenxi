package com.post.service;

import java.util.List;

import com.post.pageModel.DataGrid;
import com.post.pageModel.Role;

public interface RoleServiceI {

	public DataGrid datagrid(Role role);

	public void edit(Role role);

	public void delete(String ids);

	public List<Role> combobox();

	public void add(Role role);

}
