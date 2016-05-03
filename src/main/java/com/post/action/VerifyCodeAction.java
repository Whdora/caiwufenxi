package com.post.action;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;

import com.post.pageModel.Json;

@Action(value = "verifyCodeAction")
public class VerifyCodeAction extends BaseAction {
	private String code;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void do_verify() {
		Json j = new Json();
		String yzm = (String) ServletActionContext.getRequest().getSession()
				.getAttribute("yzm");
		if (yzm != null && yzm.equalsIgnoreCase(code)) {
			j.setSuccess(true);
			j.setMsg("验证码通过！");
		} else {
			j.setSuccess(false);
			j.setMsg("验证码错误！");
		}
		super.writeJson(j);
	}
}
