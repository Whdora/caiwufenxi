package com.post.util;

import java.math.BigDecimal;

public class DoubleUtil {
	public static Double Keep2(Double d){
		BigDecimal bg = new BigDecimal(d);
		return bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
}
