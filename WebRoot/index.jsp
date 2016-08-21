<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 包含的共页头部页面，用于作登录权限的判断 -->
<%@ include file="common/checkLogin.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>首页demo</title>
	</head>
	<body>
		欢迎您回来,${user.username }
		<br>
		注销
		<a href="<%=basePath%>login.jsp?action=logout">注销</a>
		<br>
		<br>
		<br>
		<a href="${pageContext.request.contextPath }/add.jsp">增加用户信息</a>
		<br><br>
		<a href="<%=basePath%>list.jsp">查看管理用户列表</a>
	</body>
</html>