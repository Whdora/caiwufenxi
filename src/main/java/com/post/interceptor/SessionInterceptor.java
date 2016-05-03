package com.post.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.post.pageModel.SessionInfo;
import com.post.util.ResourceUtil;

public class SessionInterceptor extends MethodFilterInterceptor {

	protected String doIntercept(ActionInvocation actionInvocation)	throws Exception {
		SessionInfo sessionInfo = (SessionInfo) ServletActionContext.getRequest().getSession().getAttribute(ResourceUtil.getSessionInfoName());
		if (sessionInfo == null) {
			ServletActionContext.getRequest().setCharacterEncoding("utf-8");
			//ServletActionContext.getResponse().sendRedirect(ServletActionContext.getRequest().getContextPath());
			ServletActionContext.getRequest().setAttribute("msg","您还没有登录或登录已超时，请重新登录！");
			return "noSession";
		}
		return actionInvocation.invoke();
	}

}
