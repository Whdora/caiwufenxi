package com.post.service;

import com.post.pageModel.DataGrid;
import com.post.pageModel.User;

public interface UserServiceI {
	

	public void addUser(User user);

	public User login(User user);

	public DataGrid datagrid(User user);

	public void update(User user);

	public int delete(User user);
	
	public void del(String ids);

	public boolean editPwd(User user);
	
	public boolean unlock(User user);
}
