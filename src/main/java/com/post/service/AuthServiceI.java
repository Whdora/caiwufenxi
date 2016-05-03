package com.post.service;

import java.util.List;

import com.post.pageModel.Auth;
import com.post.pageModel.TreeNode;



public interface AuthServiceI {
	
	public void delete(Auth auth);

	public void add(Auth auth);

	public void edit(Auth auth);

	public List<Auth> treegrid(Auth auth, boolean b);

}
