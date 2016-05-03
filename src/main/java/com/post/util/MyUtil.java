package com.post.util;

public class MyUtil {

	public static String arrayToSql(String[] str){
		String result ="";
		for (int i=0;i<str.length;i++){
			if (i!=str.length-1){
			result += "sum(t."+str[i]+"),";
			}else{
				result += "sum(t."+str[i]+")";
			}
		}
		return result;
	}
	public static String arrayToDatagrid(String[] a1,String[] a2){
		String result="";
		for (int i=0;i<a1.length;i++){
			result +=  "{title :\""+a1[i]+"\","+"field : \""+a2[i]+"\","+"align :\"center\","+" width : 80},";
                }
		return result.substring(0,result.length()-1);
		}
}
