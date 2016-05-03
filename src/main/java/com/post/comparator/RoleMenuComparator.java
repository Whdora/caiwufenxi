package com.post.comparator;

import java.util.Comparator;

import com.post.model.TroleTmenu;

public class RoleMenuComparator implements Comparator<TroleTmenu> {

	@Override
	public int compare(TroleTmenu o1, TroleTmenu o2) {
		int i1 = o1.getTmenu().getCseq() != null  ? o1.getTmenu().getCseq().intValue()	: -1;
		int i2 = o2.getTmenu().getCseq() != null ? o2.getTmenu().getCseq().intValue()	: -1;
		return i1-i2;
	}

}
