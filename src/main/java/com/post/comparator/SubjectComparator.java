package com.post.comparator;

import java.util.Comparator;

import com.post.model.Tsubject;

public class SubjectComparator  implements Comparator<Tsubject> {

	@Override
	public int compare(Tsubject o1, Tsubject o2) {
		int i1 = o1.getCseq() != null ? o1.getCseq().intValue() : -1;
		int i2 = o2.getCseq() != null ? o2.getCseq().intValue() : -1;
		return i1 - i2;
	}

}
