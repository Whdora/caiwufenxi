package com.post.service;

import java.util.List;

import com.post.pageModel.Kind;

public interface KindServiceI {

	public void add(Kind kind);

	public void edit(Kind kind);

	public void delete(Kind kind);

	public List<Kind> treegrid(Kind kind);
}
