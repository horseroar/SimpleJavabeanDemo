<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="cn.javabean.demo.model.*"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 包含的共页头部页面，用于作登录权限的判断 -->
<%@ include file="common/checkLogin.jsp"%>
<!--删除用户信息-->
<%
	//不使用useBean方式，直接把对象new出来
	User user = new User();
	//获取传入的用户ID
	String id = request.getParameter("id");
	if (id != null && id.matches("^\\d+$")) {
		user.delete(Integer.valueOf(id));
%>
	<script>
		alert("删除成功!");
		window.location.href="${pageContext.request.contextPath}/list.jsp";
	</script>
<%
	}
%>