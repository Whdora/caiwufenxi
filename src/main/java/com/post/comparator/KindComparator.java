package com.post.comparator;

import java.util.Comparator;

import com.post.model.Tkind;

public class KindComparator  implements Comparator<Tkind> {

	@Override
	public int compare(Tkind o1, Tkind o2) {
		int i1 = o1.getCseq() != null ? o1.getCseq().intValue() : -1;
		int i2 = o2.getCseq() != null ? o2.getCseq().intValue() : -1;
		return i1 - i2;
	}

}
